function area=cellarea(g,cnum)

area=0;
vidx = g.bonds(g.cells{cnum+1},1);
vert= getRelativePosition(g,vidx,cnum);
area = polyarea(vert(:,1),vert(:,2));
