function [ new_g ] = SetNewg( g )
%SETNEWG will take the olg g and plot out a suitable new g for the full equations.
%   mainly takes out dead cells and renumbering the cells that are alive

k = length(g.dead); % # of total cells
order = zeros (k,1);
count = 0;

% this loop plots out a vector 'order' renumbering the cells - all dead cells are 0
for i = 1:k
    x = g.dead(i,1);
    if x == 1
        order(i,1) = 0;
        count = count + 1;
    else
        order(i,1) = i - count;
    end
end


z = find(g.bonds(:,3) ~= 0);
new_g.bonds = g.bonds(z,:);   % a new g.bonds with no zeros lines

% this loop renumbering the cells in new_g.bonds according to order vector above
for i = 1:length(z)
    new_g.bonds(i,3) = order(new_g.bonds(i,3));
    new_g.bonds(i,4) = order(new_g.bonds(i,4));
end

d = find(g.dead == 1);
new_k = k - length(d); % # of cells alive
new_g.dead = zeros(new_k,1); % setting a new vector for g.dead with no dead cells

% this loop rewriting g.cells with no dead cells and according to the new g.bonds
new_g.cells{1,1} = [];
for i = 1:new_k
    new_g.cells{1,i+1} = (find(new_g.bonds(:,3) == i))';
    
    % here I check if the order of new_g.cell(cell) is the same as g.cell(cell)
    A = new_g.cells{1,i+1};
    A_new = zeros(1,length(new_g.cells{1,i+1}));
    i_old = find(order == i);
    B = g.cells{1,i_old+1};
    B_s = sort(B);
    for j = 1:length(B)
        f = find(B_s == B(j));
        A_new(1,j) = A(1,f);
    end
    new_g.cells{1,i+1} = A_new;
end



% all the rest stays the same
new_g.verts = g.verts;
new_g.level = g.level;
new_g.xboundary = g.xboundary;
new_g.yboundary = g.yboundary;
new_g.bc = g.bc;
new_g.areas = g.areas;
%new_g.disp = g.disp;
new_g.paras = g.paras;