function [ ni_dj_filopodiaSurface ] = St_add_Filopodia_for_full_equations( Filopodia, y, params )
%FILOPODIA_FOR_FULL_EQUATIONS will plot out the addition of filopoida to the repressor of cell i
%   di_nj_filopodia is a coloum vector contaning the amount of signal that each cell receive from filopodia of other cells


% % NOTE: here I destroy filopodia between neighbor cells
% [row,col] = find(l_ij ~= 0);
%z = [row col];
%for line_z = 1:size(z,1)
%    Filopodia(z(line_z,1),z(line_z,2)) = 0;
%end


% NOTE: here I calculate the amount of Delta protein that goes to filopodia in each cell
k = length(params.fweights); % # of cells
y = transpose(y);
[ N,D ] = St_ReCombine(  y(1,k*k+k+1:k*k+k+k*k),y(1,1:k*k),params );  % (n_ij,d_ij,params)


L = params.fperimeter;
num_of_filo_sending = sum(Filopodia,1); % row vector containing the # of filopodia that each cell sends (including filopodia from its imagined locations)

d = zeros(1,k);
n = zeros(1,k);
for i = 1:k
    %d(i) = D(i)/(L(i) + num_of_filo_sending(i)*params.Filopodia_Surface_at_tip); % NOTE: here I had the length of all filopodia to the perimeter of each cell
    %n(i) = N(i)/(L(i) + num_of_filo_sending(i)*params.Filopodia_Surface_at_tip); % NOTE: here I had the length of all filopodia to the perimeter of each cell
    d(i) = D(i)/L(i);
    n(i) = N(i)/L(i);
end

signal = zeros(k,k);
for i = 1:k % delta recieving cell
    for j = 1:k % delta sending cell
        signal(i,j) = n(i)*d(j)*Filopodia(i,j)*params.Filopodia_Surface_at_tip;
    end
end

ni_dj_filopodiaSurface = sum(signal,2);

end

