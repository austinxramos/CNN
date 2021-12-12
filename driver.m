clc
clear all
close all

global rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 window f nr nc box_size square_horizontal square_vertical nrows ncols



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

square_horizontal = zeros(nrows, ncols);
square_vertical = zeros(nrows, ncols);

window = figure;
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
  nr = nrows+1-ceil(iy/box_size);
  nc = ceil(ix/box_size);
  if nr >= 1 && nr <= nrows && nc >= 1 && nc <= ncols

    % create figure and panel on it
    f = figure;
    % create a button group
    ##gp = uibuttongroup (f, "Position", [ 0 0.5 1 1])
    % create a buttons in the group
    createWindow(f);
   end
endwhile
