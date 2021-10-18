clc
clear all
close all

global rb1 rb2 rb3 rb4 rb5 rb6 rb7 window f nr nc box_size square_horizontal square_vertical nrows ncols

function buttonPressed(h, e)
  global rb1 rb2 rb3 rb4 rb5 rb6 rb7 f window nr nc box_size square_horizontal square_vertical nrows ncols
  
  horizontal_lines = [get(rb1, 'Value'), get(rb2, 'Value'), get(rb3, 'Value')];
  
  vertical_lines = [get(rb4, 'Value'), get(rb5, 'Value'), get(rb6, 'Value')];
  
  idx_horz = find(horizontal_lines == 1);
  idx_vert = find(vertical_lines == 1);
  
  blank = get(rb7, 'Value');
  
  % Lines width
  line_width = 10;
  
  % Check that at least one number of lines is selected
  if sum(idx_horz) == 0 || sum(idx_vert) == 0
    fprintf("You must select at least one horizontal and vertical line\n");
    return;
  end
  
  % Check for horizontal_lines
  if sum(idx_horz) > 0 % horizontal lines selected
    % Define the x and y position of the line
##    y = (nr-1)*box_size + (3-idx_horz)*(box_size/3) + line_width/2;
##    x = (nc-1)*box_size;
##    
##    % Draw horizontal lines on the desired box
##    figure(window)
##    plot([x, x+box_size], [y, y], 'linewidth', line_width, 'color', 'k')
    
    square_horizontal(nr, nc) = idx_horz;
  endif
  
  if sum(idx_vert) > 0 % horizontal lines selected
    % Define the x and y position of the line
##    y = (nr-1)*box_size;
##    x = (nc-1)*box_size + (idx_vert-1)*(box_size/3) + line_width/2;
##    
##    % Draw horizontal lines on the desired box
##    figure(window)
##    plot([x, x], [y, y+box_size], 'linewidth', line_width, 'color', 'k')
    square_vertical(nr, nc) = idx_vert;
  endif
  
  % Redraw all the squares
  figure(window)
  clf
  
  % Draw Lines
  hold on
  x = 0;
  y = 0;
  for r = 1:nrows
      for c = 1:ncols
          x1 = x;
          y1 = y;
          
          x2 = x1 + box_size;
          y2 = y1 + box_size;
          
          plot([x1, x2], [y1, y1], 'linewidth', 2, 'color', 'k')
          plot([x1, x1], [y1, y2], 'linewidth', 2, 'color', 'k')
          plot([x2, x2], [y1, y2], 'linewidth', 2, 'color', 'k')
          plot([x1, x2], [y2, y2], 'linewidth', 2, 'color', 'k')
          
          
          % Draw horizontal lines
          idx_horz = square_horizontal(r, c);
          if idx_horz > 0
            yh = (r-1)*box_size + (3-idx_horz)*(box_size/3) + line_width/2;
            xh = (c-1)*box_size;
            
            % Draw horizontal lines on the desired box
            plot([xh, xh+box_size], [yh, yh], 'linewidth', line_width, 'color', 'k')
          endif
          
          % Draw vertical lines
          idx_vert = square_vertical(r, c);
          if idx_vert > 0
            yh = (r-1)*box_size;
            xh = (c-1)*box_size + (idx_vert-1)*(box_size/3) + line_width/2;
            
            % Draw horizontal lines on the desired box
            plot([xh, xh], [yh, yh+box_size], 'linewidth', line_width, 'color', 'k')
          endif
                
          x = x + box_size;
      end
      
      y = y + box_size;
      x = 0;
  end
  xlim([0, ncols*box_size])
  ylim([0, nrows*box_size])
  axis off
  
  close(f)
endfunction


%% First, dispay the grid with 16 boxes

nrows = 4;
ncols = 4;

box_size = 30;

length = box_size*nrows;
width = box_size*ncols;

% Compute coordinates of each line
x = 0;
y = 0;

% Create a matrix that will store info about each square
% The info stored will be the lines that needs to be draw on each square

square_horizontal = zeros(nrows, ncols)
square_vertical = zeros(nrows, ncols) 

window = figure
hold on
for r = 1:nrows
    for c = 1:ncols
        x1 = x;
        y1 = y;
        
        x2 = x1 + box_size;
        y2 = y1 + box_size;
        
        plot([x1, x2], [y1, y1], 'linewidth', 2, 'color', 'k')
        plot([x1, x1], [y1, y2], 'linewidth', 2, 'color', 'k')
        plot([x2, x2], [y1, y2], 'linewidth', 2, 'color', 'k')
        plot([x1, x2], [y2, y2], 'linewidth', 2, 'color', 'k')
        
        x = x + box_size;
    end
    
    y = y + box_size;
    x = 0;
end
xlim([0, ncols*box_size])
ylim([0, nrows*box_size])
axis off


while(1)
  % Get blick
  figure(window)
  [ix, iy] = ginput(1);

  % Calculate the row and col of box
  nr = ceil(iy/box_size);
  nc = ceil(ix/box_size);


  % create figure and panel on it
  f = figure;
  % create a button group
  ##gp = uibuttongroup (f, "Position", [ 0 0.5 1 1])
  % create a buttons in the group
  title = uicontrol (f, "style", "text", ...
                  "string", "Select one or more lines, but a pair can't have a blank", ...
                  "Position", [ 10 350 400 50 ]);
                  
  label1 = uicontrol (f, "style", "text", ...
                  "string", "Horizontal Line", ...
                  "Position", [ 10 250 200 50 ]);
  label2 = uicontrol (f, "style", "text", ...
                  "string", "Vertical Line", ...
                  "Position", [ 10 200 200 50 ]);
  label3 = uicontrol (f, "style", "text", ...
                  "string", "Blank", ...
                  "Position", [ 10 150 200 50 ]);
                  
  label4 = uicontrol (f, "style", "text", ...
                  "string", "Pos", ...
                  "Position", [ 220 250 50 50 ]);
  label5 = uicontrol (f, "style", "text", ...
                  "string", "Pos", ...
                  "Position", [ 220 200 50 50 ]);
                  
  label6 = uicontrol (f, "style", "text", ...
                  "string", "Pos", ...
                  "Position", [ 220 150 50 50 ]);
  gp1 = uibuttongroup (f, "Position", [ 0.51, 0.61, 0.4, 0.1]);

  rb1 = uicontrol (gp1, "style", "radiobutton", ...
                  "string", "top", ...
                  "Position", [ 10 0 50 50 ]);
                  
  rb2 = uicontrol (gp1, "style", "radiobutton", ...
                  "string", "mid", ...
                  "Position", [ 60 0 50 50 ]);
                  
  rb3 = uicontrol (gp1, "style", "radiobutton", ...
                  "string", "bottom", ...
                  "Position", [ 110 0 60 50 ]);
                  
  gp2 = uibuttongroup (f, "Position", [ 0.51, 0.5, 0.4, 0.1]);
             
  rb4 = uicontrol (gp2, "style", "radiobutton", ...
                  "string", "left", ...
                  "Position", [ 10 0 50 50 ]);
                  
  rb5 = uicontrol (gp2, "style", "radiobutton", ...
                  "string", "mid", ...
                  "Position", [ 60 0 50 50 ]);
                  
  rb6 = uicontrol (gp2, "style", "radiobutton", ...
                  "string", "right", ...
                  "Position", [ 110 0 50 50 ]);

  gp3 = uibuttongroup (f, "Position", [ 0.51, 0.39, 0.4, 0.1]);       
  rb7 = uicontrol (gp3, "style", "radiobutton", ...
                  "string", "1", ...
                  "Position", [ 10 0 50 50 ]);
                  
  btn = uicontrol (f, "style", "pushbutton", ...
                  "string", "Done", ...
                  "Position", [ 430 50 50 50 ], ...
                  "callback", {@buttonPressed});
  
  set(rb1, 'Value', 0)
  set(rb2, 'Value', 0)
  set(rb3, 'Value', 0)
  set(rb4, 'Value', 0)
  set(rb5, 'Value', 0)
  set(rb6, 'Value', 0)
  set(rb7, 'Value', 0)
  
  idx_horz = square_horizontal(nr, nc);
  if idx_horz == 1
    set(rb1, 'Value', 1);
  elseif idx_horz == 2
    set(rb2, 'Value', 1);
  elseif idx_horz == 3
    set(rb3, 'Value', 1);
  end
  
  idx_vert = square_vertical(nr, nc);
  if idx_vert == 1
    set(rb4, 'Value', 1);
  elseif idx_vert == 2
    set(rb5, 'Value', 1);
  elseif idx_vert == 3
    set(rb6, 'Value', 1);
  end
endwhile