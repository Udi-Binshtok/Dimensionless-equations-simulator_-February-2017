function [fweights, fperimeter farea] = getConnectivity(g)
ncell = length(g.cells) -1;
weights = zeros(ncell);

for c=1:ncell,
    if(~g.dead(c)),
        perimeter(c) = cellPerimeter(g,c);
        %area(c) = cellarea(g,c);
        area(c) = cellArea(g,c);
    end
end


for b=1:size(g.bonds,1),
    if(g.bonds(b,1) ~= 0),
        pos= getRelativePosition(g,g.bonds(b,1:2),g.bonds(b,3));
        weights(g.bonds(b,3),g.bonds(b,4)) = norm(pos(1,:)-pos(2,:))./(perimeter(g.bonds(b,3))*perimeter(g.bonds(b,4)));
    end
end


alive = find(~g.dead);
fweights = weights(alive,alive);
fperimeter = perimeter(alive);
farea = area(alive);