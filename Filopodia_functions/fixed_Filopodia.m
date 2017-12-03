function [ Filopodia ] = fixed_Filopodia( cells_info, distance_info, distance_values_x, distance_values_y, params, range, kill )
%FIXED_FILOPODIA Will plot out Filopodia matrix of fixed filopodia (no change in time)
%   Filopodia is (number_of_cells X number_of_cells) matrix (iXj). 
%   Each element is a natural number describing how many filopodia are connected to cell i (the reciever of the signal) by cell j (the sender of the signal) in its location in all lattices (original and imaginary - from periodic boundary condition)
%
%   [ cells_info ] = Map_of_cells( g,area );
%   [ distance_info, distance_values_x, distance_values_y  ] = distance_between_cells( cells_info )
%   range = [min max] , is the range betweeen min and max values (shortest line between cell's membranes, in mic-meter) of filopodia length
%   if kill=1 than some filopodia between pair of cells will die. see below some options (randomly chosen filopodia or oriented) 

convert_ratio = params.convert_ratio;
r_min = range(1,1)*convert_ratio;
r_max = range(1,2)*convert_ratio;

k = size(cells_info,2); % k is the # of cells
Filopodia = zeros(k,k);
for i = 1:k
    for j = 1:k
        for l = 1:9 % these are the 9 lattices (1 real and 8 imagined)
            r = distance_info(i,j,l)-(cells_info(1,i).radius+cells_info(1,j).radius); % distance between cell i in the original lattice and cell j in lattice l (shortest line between cell's membranes) 
            if r >= r_min && r <= r_max
                Filopodia(i,j) = Filopodia(i,j) + 1;
                if kill == 1
                    diff = [ distance_values_x(i,j,l) distance_values_y(i,j,l) ];
                    if abs(diff(1))/(abs(diff(2))) > 1 % kills x axis filopodia (for exmple: up to 45 degrees from the x axis)
                        Filopodia(i,j) = 0;
                    end
                end
            end
        end
    end
end

% if kill == 1
%     %f = find(Filopodia ~= 0);
%     %s = length(f);
%     
%     %r = randi(0:1:1, k,k);
%     r = ones(k,k);
%     %r(1:4:size(r,1),:) = 0;
%     %r(2:4:size(r,1),:) = 0;
%     r(:,1:4:size(r,1)) = 0;
%     r(:,2:4:size(r,1)) = 0;
%     
%     Filopodia = Filopodia.*r;
% end
end

