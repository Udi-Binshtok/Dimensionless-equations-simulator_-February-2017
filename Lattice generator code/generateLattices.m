%% generating lattice
dir = 'lattices';
mkdir(dir)
nlat = 20; %% number of lattices
regl = 'ri';
for reg = 0:1, %% if reg==1, regular lattice (6 neighbor/cell) or not. 
    allper = [];
    bfname = [dir '/' regl(reg+1) 'lat12x12_'];
    for nl = 1:nlat,
        close all;
        g=hexIrregLattice(12,12,reg);
        fname = [bfname num2str(nl)]
        print(gcf,'-depsc2',[fname '.eps']);    % Encapsulated Level 2 Color PostScript
        [weights perim area] = getConnectivity(g);
        save(fname,'g','weights','perim','area');
        allper = [allper perim];
    end
    figure, hist(allper);
    xlabel('perimeter');
    print(gcf,'-depsc2',[bfname 'hist.eps']);    % Encapsulated Level 2 Color PostScript
end


%% reloading lattices
if(0),
   bfname = [dir 'lattices/lat12x12_'];
   for nl = [2:20],
        close all;
         fname = [bfname num2str(nl)];
         load (fname);
         LatticePresentation(g,0);
         print(gcf,'-depsc2',[fname '.eps']);
   end
end