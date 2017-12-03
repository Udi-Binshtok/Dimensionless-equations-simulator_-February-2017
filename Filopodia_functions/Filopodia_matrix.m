function [ Filopodia, filopodia_time_matrix ] = Filopodia_matrix( cells_info, propability_to_create_new_filopodia, t, time_step, current_Filopodia, Current_filopodia_time_matrix, y, params )
%FILOPODIA_MATRIX will plot out the filopodia matrix for the current time   
% Filopodia is (number_of_cells X number_of_cells) matrix (iXj). 
% Each element is a natural number describing how many filopodia are connected to cell i (the reciever of the signal) by cell j (the sender of the signal) in its location in all lattices (original and imaginary - from periodic boundary condition)
%
% [ cells_info ] = Map_of_cells( g,area );
% [ propability_to_create_new_filopodia ] = propability_to_create_filopodia( cells_info, distance_info )


Filopodia = current_Filopodia;
filopodia_time_matrix = Current_filopodia_time_matrix;
k = size(cells_info,2); % k is the # of cells

% addition to fit the full equations
y = transpose(y);
[ N,D ] = St_ReCombine(  y(1,k*k+k+1:k*k+k+k*k),y(1,1:k*k),params );  % (n_ij,d_ij,params)

L = params.fperimeter;
num_of_filo_sending = sum(Filopodia,1); % row vector containing the # of filopodia that each cell sends (including filopodia from its imagined locations)

% concentraition of total Notch and Delta in each cell
d = zeros(1,k);
n = zeros(1,k);
for i = 1:k
    %d(i) = D(i)/(2*pi*cells_info(1,i).radius);
    %n(i) = N(i)/(2*pi*cells_info(1,i).radius);
    %d(i) = D(i)/(L(i) + num_of_filo_sending(i)*params.Filopodia_Surface_at_tip); % NOTE: here I had the length of all filopodia to the perimeter of each cell
    %n(i) = N(i)/(L(i) + num_of_filo_sending(i)*params.Filopodia_Surface_at_tip); % NOTE: here I had the length of all filopodia to the perimeter of each cell
    d(i) = D(i)/(L(i));
    n(i) = N(i)/(L(i));
end


%% using kind of metropolis:

for i = 1:k
    for j = 1:k
        if Filopodia(i,j) == 0
            % Creating new filopodia
            for l = 1:9
                random_number_uniform_0_to_1 = rand;
                if propability_to_create_new_filopodia(i,j,l) >= random_number_uniform_0_to_1
                    Filopodia(i,j) = Filopodia(i,j) + 1;
                    filopodia_time_matrix(i,j) = t;
                end
            end
        else
            % Destroy existing filopodia
            time_passed = t - filopodia_time_matrix(i,j);
            %time_passed = time_step;
            propability_for_existing_filopodia_to_die = propability_for_filopodia_to_die(time_passed,d(j),n(i),params);
            for f = 1:Filopodia(i,j)
                another_random_number_uniform_0_to_1 = rand;
                if propability_for_existing_filopodia_to_die >= another_random_number_uniform_0_to_1;
                    Filopodia(i,j) = Filopodia(i,j) - 1;
                end
            end
        end
        
    end
end

                                                                  

end

