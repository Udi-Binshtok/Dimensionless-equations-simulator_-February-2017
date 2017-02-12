function g = relaxLattice(g,n)
for i=1:n,
    ve = extractverts(g);
    dE=denergy(ve,g);
    noE = norm(dE);
    if(noE>1E-10),
        dE = 0.01*dE/noE;
        ve = ve-dE';
        g = insertverts(ve,g);
    end
    
end
end