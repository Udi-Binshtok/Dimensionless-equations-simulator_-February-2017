function [ cells_info ] = Map_of_cells( g,area )
%MAP_of_cells will provide a "map" showing each cell's position and radius (calculated from its area, as a circle
%around its averaged center) - also in the "imaged" lattices created by periodic boundry condition.

%   cell.position = position of center of all cells
%   cell.radi = radius from the center of all cells

% Here I'm creating a new "area" vector so I know to associate each cell to its area
%dead_cells = find(g.dead == 1);
%new_area = zeros(1,length(g.cells)-1);

%skip = 0;
%for j = 1:length(g.cells)-1
%    flag = 0;
%    for d = 1:length(dead_cells)
%        if j == dead_cells(d,1)
%            skip = skip + 1;
%            flag = 1;
%        end
%    end
    
%    if flag ~= 1                            % change in hear!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%        new_area(1,j-skip) = area(1,j);
%    end
    
%end


for i = 1:length(area)                      % change in hear!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    [ cells_info(1,i).position ] = Location_of_one_cell( g, i ); 
    [ cells_info(1,i).radius ] = sqrt(area(1,i)/pi);  % change in hear!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end


end

