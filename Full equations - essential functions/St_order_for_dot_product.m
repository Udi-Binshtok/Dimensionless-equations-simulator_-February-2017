function [ n_ij_d_ji_l_ij ] = St_order_for_dot_product( n_ij,d_ji,params )
%ORDER_FOR_DOT_PRODUCT Summary of this function goes here
%   Detailed explanation goes here

l_ij = params.fweights;
k = size(l_ij,1);

n_ij_d_ji = n_ij.*d_ji;
nijdji = zeros (k,k);

for i=1:1:k
    for j=1:1:k
        nijdji(i,j) = n_ij_d_ji(k*(i-1) + j,1);
    end
end

nijdjilij = nijdji.*l_ij;
n_ij_d_ji_l_ij = sum(nijdjilij,2);

end

