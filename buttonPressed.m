function buttonPressed(h, e)
  global rb1 rb2 rb3 rb4 rb5 rb6 rb7 rb8 f window nr nc box_size square_horizontal square_vertical nrows ncols
  
  horizontal_lines = [get(rb1, 'Value'), get(rb2, 'Value'), get(rb3, 'Value'), get(rb7, 'Value')];
  
  vertical_lines = [get(rb4, 'Value'), get(rb5, 'Value'), get(rb6, 'Value'), get(rb8, 'Value')];
  
  idx_horz = find(horizontal_lines == 1);
  idx_vert = find(vertical_lines == 1);
  
  % Lines width
  line_width = 10;
  
  % Check that at least one number of lines is selected
  %if sum(idx_horz) == 0 || sum(idx_vert) == 0
  %  fprintf("You must select at least one horizontal and vertical line\n");
  %  return;
  % end
  
  % Check for horizontal_lines
  if sum(idx_horz) > 0 % horizontal lines selected
    % Define the x and y position of the line
##    y = (nr-1)*box_size + (3-idx_horz)*(box_size/3) + line_width/2;
##    x = (nc-1)*box_size;
##    
##    % Draw horizontal lines on the desired box
##    figure(window)
##    plot([x, x+box_size], [y, y], 'linewidth', line_width, 'color', 'k')
    
    if idx_horz < 4
      square_horizontal(nr, nc) = idx_horz;
    else
      square_horizontal(nr, nc) = 0;
    endif
  endif
  
  if sum(idx_vert) > 0 % horizontal lines selected
    % Define the x and y position of the line
##    y = (nr-1)*box_size;
##    x = (nc-1)*box_size + (idx_vert-1)*(box_size/3) + line_width/2;
##    
##    % Draw horizontal lines on the desired box
##    figure(window)
##    plot([x, x], [y, y+box_size], 'linewidth', line_width, 'color', 'k')
    if idx_vert < 4
      square_vertical(nr, nc) = idx_vert;
    else
      square_vertical(nr, nc) = 0;
    endif
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
            yh = nrows*box_size - ((r-1)*box_size + (idx_horz-1)*(box_size/3) + line_width/2);
            xh = (c-1)*box_size;
            
            % Draw horizontal lines on the desired box
            plot([xh, xh+box_size], [yh, yh], 'linewidth', line_width, 'color', 'k')
          endif
          
          % Draw vertical lines
          idx_vert = square_vertical(r, c);
          if idx_vert > 0
            yh = (nrows-1)*box_size - ((r-1)*box_size);
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
  
  
  
  % Now, check for letters
  % Check for I
  for r = 1:nrows-1
    for c = 1:ncols
      a = square_horizontal(r, c) == 1;
      b = square_vertical(r,c) == 2;
      c2 = square_vertical(r+1, c) == 2;
      d = square_horizontal(r+1, c) == 3;
      if a && b && c2 && d % the letter is I
        fprintf("The S1 layer has recognized the letter I\n");
      endif
    endfor
  endfor
  
  % Now check for H
  for r = 1:nrows
    for c = 1:ncols-1
      a = square_horizontal(r, c) == 2;
      b = square_vertical(r,c) == 1;
      c2 = square_vertical(r, c+1) == 3;
      d = square_horizontal(r, c+1) == 2;
      if a && b && c2 && d % the letter is H
        fprintf("The S1 layer has recognized the letter H\n");
      endif
    endfor
  endfor
  
  % Check for L
  for r = 1:nrows-1
    for c = 1:ncols
      a = square_horizontal(r, c) == 0;
      b = square_vertical(r,c) == 1;
      c2 = square_vertical(r+1, c) == 1;
      d = square_horizontal(r+1, c) == 3;
      if a && b && c2 && d % the letter is L
        fprintf("The S1 layer has recognized the letter L\n");
      endif
    endfor
  endfor
  
  % Check for T
  for r = 1:nrows-1
    for c = 1:ncols
      a = square_horizontal(r, c) == 1;
      b = square_vertical(r,c) == 2;
      c = square_vertical(r+1, c) == 2;
      d = square_horizontal(r+1, c) == 0;
      if a && b && c && d % the letter is T
        fprintf("The S1 layer has recognized the letter T\n");
      endif
    endfor
  endfor
  
  % Check for U
  for r = 1:nrows
    for c = 1:ncols-1
      a = square_horizontal(r, c) == 3;
      b = square_vertical(r,c) == 1;
      c2 = square_vertical(r, c+1) == 3;
      d = square_horizontal(r, c+1) == 3;
      if a && b && c2 && d% the letter is U
        fprintf("The S1 layer has recognized the letter U\n");
      endif
    endfor
  endfor
  
  % Check for C
  for r = 1:nrows-1
    for c = 1:ncols
      a = square_horizontal(r, c) == 1;
      b = square_vertical(r,c) == 1;
      c2 = square_vertical(r+1, c) == 1;
      d = square_horizontal(r+1, c) == 3;
      if a && b && c2 && d% the letter is C
        fprintf("The S1 layer has recognized the letter C\n");
      endif
    endfor
  endfor

  
  close(f)
endfunction