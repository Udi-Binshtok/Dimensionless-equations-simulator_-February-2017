function [ propability_to_create_new_filopodia ] = propability_to_create_filopodia( cells_info, distance_info, params )
%PROPABILITY_TO_CREATE_FILOPODIA function will calculate the propability to create filopodia between two cells. 
% [ cells_info ] = Map_of_cells( g,area );
% [ distance_info ] = distance_between_cells( cells_info )

k = size(cells_info,2); % k is the # of cells
propability_to_create_new_filopodia = zeros(k,k,9);



%radius_vector = zeros(k,1);
%for i = 1:k
%    radius_vector(i,1) = cells_info(1,i).radius;
%end
%average_radius = mean(radius_vector);

%factor_filopodia_average_length = average_radius*2*1.4 - average_radius; % Note and problem: mean size of filopodia (from cell center) according to Buzz Baum is 1.4 cell's diamiter, that is about 7 mic-meter. According to B.Rubinstein its upper limit is 2 mic-meter. According to Kondo it about 200 mic-meters
%factor_filopodia_average_length = 2*pi/5; % about 2.4 cells, i still need to check expermintal filopodia length
factor_filopodia_average_length = params.factor_filopodia_average_length;

factor_create = 1/factor_filopodia_average_length; % integration over the propability between 0 to infinity on the distance between pair of cells (membrane to membrane)

for i = 1:k
    for j = 1:k
        for l = 1:9 % these are the 9 lattices (1 real and 8 imagined)
            r = distance_info(i,j,l); % distance between cell i in the original lattice and cell j in lattice l (between cell's centres)
            propability_to_create_new_filopodia(i,j,l) = factor_create*exp(-(r-(cells_info(1,i).radius+cells_info(1,j).radius))/factor_filopodia_average_length);
            %propability_to_create_new_filopodia(i,j,l) = factor_create*exp(-(r-(cells_info(1,i).radius+cells_info(1,j).radius))/factor_filopodia_average_length)*(0.5+0.5*tanh(10*(r-(cells_info(1,i).radius+cells_info(1,j).radius))));        
        end
    end
end

end

