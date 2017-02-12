function g=findTransitions(g,eps,probT1,probT2)
%% generates T1 transition with probability  probT1 if edge is  shorter than eps
%% if cell has less than 4  edges,  generates a T2 transition is probability probT2
cand = randperm(size(g.bonds,1)); %% random  selection order
while length(cand)>0,
    bo = cand(1);
    if(g.bonds(bo,1)==0),
        cand = cand(2:end);
        continue;
    end
    v1 = g.verts(g.bonds(bo,1),:);
    v2 = g.verts(g.bonds(bo,2),:);
    vec = v1-v2;
    
    if(length(g.cells{g.bonds(bo,3)+1})>3 && length(g.cells{g.bonds(bo,4)+1})>3)
        len = norm(vec);
        if(len<eps),
            mid = 0.5*(v1+v2);
            Ediff = v1(2)^4 + v2(2)^4 -2*mid(2)^4;
            if(rand()<probT1/(1+exp(-Ediff))),
                g=T1transition(g,bo);
                len = norm(g.verts(g.bonds(bo,1),:)- g.verts(g.bonds(bo,2),:));
            end
        end
    else
        c1 = g.bonds(bo,3);
        c2 = g.bonds(bo,4);
        torem = [];
        if(length(g.cells{c1+1})==3)
            if(rand()<probT2),
                [g torem]=T2transition(g,c1);
            end
        end
        if(length(g.cells{c2+1})==3)
            if(rand()<probT2),
                [g torem]=T2transition(g,c2);
            end
        end
    end
    cand = cand(2:end);
end

