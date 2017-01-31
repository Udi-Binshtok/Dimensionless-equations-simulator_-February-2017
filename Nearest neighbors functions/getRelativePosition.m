function pos = getRelativePosition(g,v,i)
% v are the vertexes of cell i.
pos = g.verts(v,1:2);   % vertexes coordinates of i cell. pos is #_Of_VertsX2 matrix
if(g.bc==1),            % bc = 1 means periodic boundary condition
    for d=1:2, % x and y coordinates 
        ap = g.verts(g.bonds(g.cells{i+1},1),d); % all vertexes of cell i
    [p pid] = min(abs(ap));                      % p = value ; pid = posision in vector ap (it finds the closest vert to zero in ap)
    p = ap(pid);                                 % same value without abs
  mup = find(abs(pos(:,d)+2*pi-p)<abs(pos(:,d)-p));
  mdown = find(abs(pos(:,d)-2*pi-p)<abs(pos(:,d)-p));
  pos(mup,d) = pos(mup,d)+(2*pi);
  pos(mdown,d)=pos(mdown,d)-(2*pi);
  if(length(intersect(mup,mdown))>0)  % if there are values common to both mup and mdown.
      disp('strange');
  end

end
end