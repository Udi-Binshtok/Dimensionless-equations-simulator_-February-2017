function pos = getRelativePosition(g,v,i)
pos = g.verts(v,1:2);
if(g.bc==1),
    for d=1:2,
        ap = g.verts(v,d);
        [p pid] = min(abs(ap));
        p = ap(pid);
        idx = mod(pid,length(v))+1;
        while (idx~=pid),
            if(abs(pos(idx,d)+2*pi-p)< abs(pos(idx,d)-p)),
               pos(idx,d) =  pos(idx,d)+2*pi;
            end
            if(abs(pos(idx,d)-2*pi-p)< abs(pos(idx,d)-p)),
               pos(idx,d) =  pos(idx,d)-2*pi;
            end
            p= pos(idx,d);
            idx = mod(idx,length(v))+1;
            %[idx pid]
        end
    
%   mup = find(abs(pos(:,d)+2*pi-p)<abs(pos(:,d)-p));
%   mdown = find(abs(pos(:,d)-2*pi-p)<abs(pos(:,d)-p));
%   pos(mup,d) = pos(mup,d)+(2*pi);
%   pos(mdown,d)=pos(mdown,d)-(2*pi);
%   if(length(intersect(mup,mdown))>0)
%       disp('strange');
%   end

end
end