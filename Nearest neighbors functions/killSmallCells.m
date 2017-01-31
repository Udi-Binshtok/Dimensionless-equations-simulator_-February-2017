function ng = killSmallCells(g,thresh)
ng  =g;
nbcell = length(ng.cells)-1;
cand = find(ng.dead==0);
for ci=1:length(cand),
    c = cand(ci);
    if (cellarea(ng,c)<thresh*ng.areas(c)),
        while (length(ng.cells{c+1})>3),
            vidx=g.bonds(ng.cells{c+1},1);
            vert = getRelativePosition(ng,vidx,c);
            nb=length(vidx);
            len = zeros(nb,1);
            for j=1:nb
             len(j) = norm(vert(j,1:2)-vert(mod(j,nb)+1,1:2));
            end
            [ord id] =sort(len);
            ng = T1transition(ng,ng.cells{c+1}(id(1)));
        end
        ng = T2transition(ng,c);
    end
end
            