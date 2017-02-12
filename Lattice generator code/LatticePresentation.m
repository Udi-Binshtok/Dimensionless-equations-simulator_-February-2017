function LatticePresentation(g,num)
%% Draws the lattice g. If num is true, display the cell numbers
if nargin==1,
    num=0;
end
cells = [1:length(g.cells)-1];
for i = cells
    if(length(g.cells{i+1})>2),
        if(g.dead(i)==0),
            verts = (g.bonds(g.cells{i+1}(:),1));
            if(length(verts)>2),
                v = getRelativePosition(g,verts,i);
                if(isfield(g,'scale')),
                    v = v*g.scale;
                end
                patch(v(:,1),v(:,2),'w','EdgeColor','g');
                hold on;
                if(num),
                  text(mean(v(:,1)),mean(v(:,2)),num2str(i),'HorizontalAlignment','center','color','g');
                end
            end
        end
    end
end
axis equal
hold off;
end
