function params = defaultparams( g, area, smh )
%DEFUALT_PARAMS gives the default parameters if none provided in the main function DIMENSIONLESS.
%   SMH: the system parameters match seconds/minutes/hours respective to 1/2/3
%   G and AREA are inner properties of the lattice loaded 

if smh == 1
    
    params.Tmax = 10000; % seconds 
    Time_step = 10 + (90).*rand; % seconds
    params.Time_step = params.Tmax/round(params.Tmax/Time_step);
    
    params.betaD = 0.0125; % per sec
    params.betaR = 0.0125; % per sec
    params.betaN = 0.0125; % per sec
    params.gammaD = 0.014; % per sec
    params.gammaR = 0.014; % per sec
    params.gammaN = 0.014; % per sec
    params.gammaS = 0.014; % per sec
    params.k_plus = 0.167; % per sec
    params.k_minus = 0.034; % per sec 
    params.k_signal = 0.026; % per sec 

else if smh == 2
        
        params.betaD = 0.75; % per min
        params.betaR = 0.72; % per min
        params.betaN = 0.75; % per min
        params.gammaD = 1.63; % per min
        params.gammaR = 0.008334; % per min
        params.gammaN = 9.2; % per min
        params.gammaS = 0.008334; % per min
        params.k_plus = 10.02; % per min 
        params.k_minus = 2.04; % per min 
        params.k_signal =  20.4; % per min 


        params.Tmax = 420; % minutes 
        Time_step = 1/params.gammaR*(0.5 + (2-0.5)*rand); % minutes
        params.Time_step = params.Tmax/round(params.Tmax/Time_step);
        
    else if smh == 3
            
            params.Tmax = 24; % hours
            Time_step = 0.05555 + (0.25-0.05555).*rand; % hours
            params.Time_step = params.Tmax/round(params.Tmax/Time_step);
            
            params.betaD = 45; % per hr
            params.betaR = 27; % per hr
            params.betaN = 45; % per hr
            params.gammaD = 97.8; % per hr
            params.gammaR = 0.50004; % per hr
            params.gammaN = 552; % per hr
            params.gammaS = 0.50004; % per hr
            params.k_plus = 601.2; % per hr
            params.k_minus = 122.4; % per hr
            params.k_signal =  1224; % per hr
            
        end
    end
end
 
params.parameterR = 0.0046;
params.parameterS = 0.046; 

params.l = 3; 
params.m = 3; 

params.noiseAmp = 0.2;
params.epsilon = 1e-3;

[fweights, fperimeter, farea] = getConnectivity1(g); % getConnectivity1 is suitable for full equations

params.fweights=fweights;
params.fperimeter=fperimeter;
params.farea=farea;
params.fconnectivity=zeros(size(fweights));
params.fconnectivity(fweights~=0)=1;

k = length(params.fperimeter); % number of cells

% this section is here in order to get a ratio between micro-meters and the lattices scale
[ cells_info ] = Map_of_cells( g,area );
radius_vector = zeros(k,1);
for i = 1:k
    radius_vector(i,1) = cells_info(1,i).radius;
end

average_perimeter_in_pattern_scale = mean(params.fperimeter);
average_perimeter_in_micro_meter = 6; 
convert_ratio = average_perimeter_in_pattern_scale/average_perimeter_in_micro_meter;
params.convert_ratio = convert_ratio;
params.k_plus = params.k_plus*convert_ratio; % asume params.k_plus is in mic-m/(mol*sec)

%% scaling :

params.k = params.k_plus*params.k_signal/(params.k_minus + params.k_signal);

% Scaling time
params.Tmax = params.Tmax*params.gammaR;
params.Time_step = params.Time_step*params.gammaR;
params.tauN = params.gammaR/params.gammaN;
params.tauD = params.gammaR/params.gammaD;
params.betaN = params.betaN/params.gammaN;
params.betaD = params.betaD/params.gammaD;
params.betaR = params.betaR/(params.gammaR*params.parameterR);

% Scaling space  (!!! I need to scale params.Filopodia_Surface_at_tip and params.factor_filopodia_average_length !!!)
average_perimeter_in_pattern_scale = mean(params.fperimeter);
params.fperimeter = params.fperimeter./average_perimeter_in_pattern_scale;
params.fweights = params.fweights./average_perimeter_in_pattern_scale;
params.n_zero = sqrt(params.parameterS*params.gammaD*params.gammaS/(params.gammaN*average_perimeter_in_pattern_scale*params.k));
params.d_zero = params.gammaN*params.n_zero/params.gammaD;
params.betaN = params.betaN/(params.n_zero*average_perimeter_in_pattern_scale);
params.betaD = params.betaD/(params.d_zero*average_perimeter_in_pattern_scale);

% params.k_minus1 = params.d_zero*params.k/params.betaN; % mistake!!
params.k_minus1 = params.d_zero*params.k/params.gammaN;
params.k_cis_minus1 = 100;


end

