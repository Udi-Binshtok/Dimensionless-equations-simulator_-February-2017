% This script will run the code simulating the dimensionless differential
% equations over a loaded lattice of cells.

lattice = 'latCu12x12_1.mat';
load(lattice)
[yout,tout,params,F] = dimensionless(g,area);
% [yout,tout,params,F] = dimensionless(g,area,params); % uncomment when PARAMS is also inserted