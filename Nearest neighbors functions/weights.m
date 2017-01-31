function [ M ] = weights( g )
%WEIGHTS Summary of this function goes here
%   Detailed explanation goes here

k = size(g.cells,2) - 1;
W = zeros(k,k);

for i=1:k
    n = g.cells{1,i+1}; %neighbors
    s = size(n,2);
    if s ~= 0
        W(g.bonds(n,4),i) = 1/s;
        %W(g.bonds(n,4),i) = 1;
    end
end

alive = find(~g.dead);
M = W(alive,alive);

end

