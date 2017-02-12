function [ n_ij,d_ij] = St_getSeparation( n,d )
%GETSEPARATION takes Notch/Delta concentration (n/d) as a matrix and separate them into vectors that presents the concentration on each bond.
%   Each vector has a direction of signal sender/receiver (for double index ij/ji - i/j is the sender and j/i is the receiver)


    k = size(n,1);
    n_ij = zeros(k*k,1);
    d_ij = zeros(k*k,1);

    for i = 1:1:k
        for j = 1:1:k
            n_ij(k*(i-1) + j,1) = n(i,j);
            d_ij(k*(i-1) + j,1) = d(i,j);
        end
    end

    
end

