function LatticePresentation(g,f,Color) % g is a GLattice structure. f figure, or not? Color Specifies the color
epsil = pi;
fac = 0.04;
if(max(g.level(:,1))>25),
    fac = 1/(max(g.level(:,1))+0.5)
end
if nargin == 2
    Color = 'g';
elseif nargin <2
    Color = 'g';
    f = 0;
end
if f
    figure
end

for i = 1: length(g.cells)-1
    if(length(g.cells{i+1})>2),
        if(g.dead(i)==0),
            verts = (g.bonds(g.cells{i+1}(:),1));
            if(length(verts)>2),
                
                v = getRelativePosition(g,verts,i);
                patch(v(:,1),v(:,2),'w','EdgeColor',Color,'FaceColor',1- fac*g.level(i,1)*ones(1,3)+g.dead(i)*[0 -0.2 -0.2]);
                hold on;
%                 % uncomment to display cell number
%                 text(mean(v(:,1)),mean(v(:,2)),num2str(i),'HorizontalAlignment','center');
                
            end
        end
    end
    end
    axis equal
end
