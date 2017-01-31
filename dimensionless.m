function [yout,tout,params,F] = dimensionless(g,area,params)

% DIMENSIONLESS simulates lateral inhibition on a disordered lattice, using the full dimensionless mathematical model equations.
%   The structure params contains the model parameters of the system.
%   TOUT is a vector containing the time points of the solution between 0 and Tmax.
%   YOUT is a matrix containing the numerical solution for each variable for each time point.
%   Each row in YOUT is a vector the size of TOUT.
%   F is a movie showing the simulation. 
%   G and AREA are inner properties of the lattice loaded

%%
addpath('Nearest neighbors functions')
addpath('Full equations - essential functions')

[ new_g ] = SetNewg( g ); % setting new sutible g for full equations (no dead cells)
if(nargin < 3)
    smh = 1; % smh: the system parameters match seconds/minutes/hours respective to 1/2/3
    [ params ] = defaultparams(new_g, area, smh); %get the default parameters if none provided
end
k = length(params.fperimeter); % number of cells

%setting the initial conditions + noise - rearranging them to fit full equations
y0 = getIC(params,k);
R0 = y0(k+1:2*k);
d0 = zeros(k,k);
n0 = zeros(k,k); 
L = params.fperimeter;
for i = 1:k
    for j = 1:k
        d0(i,j) = y0(i,1)/L(1,i); % this is the concentraion of Delta (belongs to cell i) on the bond ij
        n0(i,j) = y0(2*k+i,1)/L(1,i); % this is the concentraion of Notch (belongs to cell i) on the bond ij
    end
end
[ n_ij,d_ij ] = St_getSeparation( n0,d0 );

% Scaling:
R0 = R0./params.parameterR;
n_ij = n_ij./params.n_zero;
d_ij = d_ij./params.d_zero;
full_y0 = [d_ij;R0;n_ij];

%run simulation with lateral inhibition
Tmax = params.Tmax;
[tout,full_yout] = ode23(@li,[0 Tmax],full_y0,[],params); % solve differential equations

% show lattice simulation
yout = zeros(size(full_yout,1),size(y0,1));  
for t = 1:1:size(full_yout,1)
    [ N,D ] = St_ReCombine(  full_yout(t,k*k+k+1:k*k+k+k*k),full_yout(t,1:k*k),params );  % (n_ij,d_ij,params)
    R = full_yout(t,k*k+1:k*k+k);
    yout(t,:) = [D R N];
end

F = movielattice(tout,yout,k,new_g);
%%


function dy = li(t,y,params) %#ok<*INUSL>

betaD = params.betaD;
betaR = params.betaR;
betaN = params.betaN;
l = params.l;
m = params.m;
k_minus1 = params.k_minus1;

L = params.fperimeter;
k = length(params.fweights); % # of cells


dij = y(1:k*k,1); % concentration of Delta from cell i in border ij
R = y(k*k+1:k*k+k,1); % levels of Repressor in cells 1 to k
nij = y(k*k+k+1:k*k+k+k*k,1); % concentration of Notch from cell i in border ij

dji = zeros(size(dij,1),1); % concentration of Delta from cell j in border ij
nji = zeros(size(nij,1),1); % concentration of Notch from cell j in border ij
d = zeros(k,k);
n = zeros(k,k);
Ri = zeros(size(dij,1),1);
Li = zeros(size(dij,1),1);


for i=1:1:k
    for j=1:1:k
        d(i,j) = dij(k*(i-1) + j,1);
        n(i,j) = nij(k*(i-1) + j,1);
    end
end
dt = transpose(d);
nt = transpose(n);
for i = 1:1:k
    for j = 1:1:k
        dji(k*(i-1) + j,1) = dt(i,j);
        nji(k*(i-1) + j,1) = nt(i,j);
        Ri(k*(i-1) + j,1) = R(i,1);
        Li(k*(i-1) + j,1) = L(1,i);
    end
end


[ n_ij_d_ji_l_ij ] = St_order_for_dot_product( nij, dji, params); % signal from neighbors

%%% Without CIS inhibition
ddij = (betaD./(Li)).*(1./(1 + (Ri).^l)) - dij - k_minus1.*dij.*nji;
dR = betaR.*((n_ij_d_ji_l_ij).^m)./(1 + ((n_ij_d_ji_l_ij).^m)) - R;        
dnij = betaN./(Li) - nij - k_minus1.*nij.*dji; 

%%% With CIS inhibition
% k_cis_minus1 = params.k_cis_minus1;
% ddij = (betaD./(Li)).*(1./(1 + (Ri).^l)) - dij - k_minus1.*dij.*nji - k_cis_minus1.*dij.*nij;
% dR = betaR.*((n_ij_d_ji_l_ij).^m)./(1 + ((n_ij_d_ji_l_ij).^m)) - R;        
% dnij = betaN./(Li) - nij - k_minus1.*nij.*dji - k_cis_minus1.*dij.*nij;

dy = [ddij;dR;dnij];
%%


function y0=getIC(params,k)

noise = 1 + params.noiseAmp*(rand(k,1) - 1/2); %noise in inital condition ranges from 1-0.5*noiseAmp to 1+0.5*noiseAmp
noise(noise < 0) = 0;
epsilon = params.epsilon;
D0=params.betaD*epsilon.*ones(k,1).*noise; % Initial Delta levels are small with noise
R0=zeros(k,1); %All initial Repressor levels are zero
N0=ones(k,1); %All initial Notch levels are 1
y0=[D0;R0;N0]; % vector of initial conditions
%%


function F=movielattice(tout,yout,k,g)

figure(996);
edgecolor=[0.5 0.5 0.5];
sy1 = sort(yout(end,1:k));
Norm = sy1(round(length(sy1)*0.95)); %find the Delta level in the high Delta cells
frameind=0;
for tind = 1:5:length(tout)   %shows every 5th frame
    clf;
    for i = 1: length(g.cells)-1
        if(length(g.cells{i+1})>2)
            if(g.dead(i)==0)
                verts = (g.bonds(g.cells{i+1}(:),1));
                if(length(verts)>2)
                    ind=i-sum(g.dead(1:i));
                    v = getRelativePosition(g,verts,i);
                    mycolor = min([yout(tind,ind)/ Norm,1]); %defined the normalized color of cell
                    patch(v(:,1),v(:,2),'w','EdgeColor',edgecolor,'FaceColor',[mycolor,1-mycolor,0]);
                    hold on;
                    % uncomment to display cell number
%                     text(mean(v(:,1)),mean(v(:,2)),num2str(i),'HorizontalAlignment','center');
                    hold on;
                end
            end
        end
    end
    
    
    axis image; axis off; box off;
    
    frameind=frameind+1;
    F(frameind) = getframe; %generates a movie variable
end;
% movie2avi(F,'movielattice'); % save movie in avi format (in old matlab versions)
vid = VideoWriter('movielattice.avi');
open(vid);
writeVideo(vid,F);
close(vid);
%%