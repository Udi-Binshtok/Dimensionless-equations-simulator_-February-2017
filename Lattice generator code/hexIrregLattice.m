function g= hexIrregLattice(nrow,ncol,with_trans)
%% generates an irrgelular lattice  with nrow rows and ncol columns.
%% If with_trans is false, all cells have exactly  6 neighbors,
%% otherwise some cells may be removed.

[cc,ve] = mHexLattice(nrow+2,ncol+2,0);
 ve(~isfinite(ve))=nan;
  
% remove unused vertices
vidx = zeros(length(ve),1);
for i = 1:length(cc)
    vidx(cc{i}) = 1;
end
vindex = find(vidx == 1);
vertices = ve(vindex,1:2);
vshift = zeros(length(ve),1);
vshift(vindex) = 1:length(vindex);
for i = 1:length(cc)
    cc{i} = vshift(cc{i})';
    cc{i}(end+1) = cc{i}(1);
end



disp('Number of cells: ');disp(length(cc));
g(1) = GLattConversion(cc,vertices);
g.xboundary=zeros(length(g.cells)-1,2);
g.yboundary=zeros(length(g.cells)-1,2);
g.bc=1;
g.scale =eye(2);
g.dead =zeros(length(g.cells)-1,1);
LatticePresentation(g,0);
if(g.bc)
g = periodicBC(g,nrow,ncol);
end

g = rescale(g);
g.dead =zeros(length(g.cells)-1,1);
figure(3), LatticePresentation(g,0);
%%

for i=1:length(g.cells)-1,
    if(g.dead(i)==0)
g.areas(i) = (1+2*(rand-0.5))*cellarea(g,i);
    end
end

g.paras = [1 ; 0.01; 0];
g = relaxLattice(g,200);
if(with_trans)
    for t =1:1,
    g = findTransitions(g,1,0.02,0.01);
        g = relaxLattice(g,50);
         g = killSmallCells(g,0.2);
          g = relaxLattice(g,200);
    end
end
figure(4),LatticePresentation(g,0);

