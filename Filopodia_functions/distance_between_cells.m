function [ distance_info, distance_values_x, distance_values_y ] = distance_between_cells( cells_info )
%DISTANCE_BETWEEN_CELLS will calculate the distance between every pair of cells within the lattice and also the 'imaged' lattices created from the periodic boundry condition
% distance_info is a structure containing the information of the distances.
% 
% every cell has a (0;3) tensor: 9 times the (number_of_cell X number_of_cell) matrix.
% 5 is the original lattice.
% 1 is the upper-left imaged lattice.
% 2 is upper-midle. 
% 3 is upper-right.
% 4 is midle-left 
% ... 
% 9 is lower-right
%
% that means that for each cell this function will plot the distance to any
% other cell including cells in imaged lattices
%
%[ cells_info ] = Map_of_cells( g,area );

k = size(cells_info,2); % k is the # of cells
Dist = NaN(k,k,9);

% I inserted these two arrays for killing filopodia in the function fixed filopodia
v_x = NaN(k,k,9);
v_y = NaN(k,k,9);

for i = 1:k    
    for j = 1:k
        % go through all lattices
        Dist(i,j,1) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,1,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,1,2))^2);
        v_x(i,j,1) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,1,1);
        v_y(i,j,1) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,1,2);
        
        Dist(i,j,2) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,2,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,2,2))^2);
        v_x(i,j,2) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,2,1);
        v_y(i,j,2) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,2,2);
        
        Dist(i,j,3) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,3,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,3,2))^2);
        v_x(i,j,3) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(1,3,1);
        v_y(i,j,3) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(1,3,2);
        
        Dist(i,j,4) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,1,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,1,2))^2);
        v_x(i,j,4) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,1,1);
        v_y(i,j,4) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,1,2);
        
        Dist(i,j,5) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,2,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,2,2))^2);
        v_x(i,j,5) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,2,1);
        v_y(i,j,5) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,2,2);
        
        Dist(i,j,6) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,3,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,3,2))^2);
        v_x(i,j,6) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(2,3,1);
        v_y(i,j,6) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(2,3,2);
        
        Dist(i,j,7) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,1,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,1,2))^2);
        v_x(i,j,7) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,1,1);
        v_y(i,j,7) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,1,2);
        
        Dist(i,j,8) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,2,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,2,2))^2);
        v_x(i,j,8) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,2,1);
        v_y(i,j,8) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,2,2);
        
        Dist(i,j,9) = sqrt((cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,3,1))^2 + (cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,3,2))^2);
        v_x(i,j,9) = cells_info(1,i).position(2,2,1) - cells_info(1,j).position(3,3,1);
        v_y(i,j,9) = cells_info(1,i).position(2,2,2) - cells_info(1,j).position(3,3,2);
        
    end
    % distance_info{1,i} = Dist(i,:,:); % that is not needed
end

distance_info = Dist;
distance_values_x = v_x;
distance_values_y = v_y;

end

