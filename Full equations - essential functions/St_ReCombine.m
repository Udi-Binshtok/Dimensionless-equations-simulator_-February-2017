function [ N,D ] = St_ReCombine(  n_ij,d_ij,params )
%RECOMBINE will calculate and plot out the Notch and Delta proteins value for each cell
%   N and D are both vector of length 1x#OfCells where each component is a value of Notch or Delta

l_ij = params.fweights;
k = size(l_ij,1);
N = zeros(1,k);
D = zeros(1,k);
for i = 1:1:k 
    for j =1:1:k
        N(1,i) = N(1,i) + n_ij(1,k*(i-1) + j)*l_ij(i,j);
        D(1,i) = D(1,i) + d_ij(1,k*(i-1) + j)*l_ij(i,j);
    end
end

end

