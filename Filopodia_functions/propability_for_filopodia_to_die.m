function [ propability_for_existing_filopodia_to_die ] = propability_for_filopodia_to_die( time_passed, d, n,params )
%PROPABILITY_FOR_FILOPODIA_TO_DIE function will calculate the propability for filopodia between two cells to die. 

if params.life_time == 0
    % Note: I need to take, somehow, into account n(t) and d(t) when solving the integral to find factor_die
    k_plus = params.k_plus;
    k_minus = params.k_minus;
    k_signal = params.k_signal;
    S = params.Filopodia_Surface_at_tip; % Note: this is the typical surface area of the connection between filopodia and a cell (i.e. the surface of the head of filopodia). I need to scale it to the pattern dimensions
    life_time = (k_plus/((k_minus + k_signal)^2))*n*d*S;
    
else
    life_time = params.life_time;
end

factor_die = 1/life_time; % Note: this sholud be an integration over the propability between 0 to infinity on the time step
propability_for_existing_filopodia_to_die = factor_die*life_time*(1-exp(-time_passed/life_time)); % Note: This is an intrgral result from 0 to time step
%propability_for_existing_filopodia_to_die = factor_die*(time_step/life_time)*exp(-time_step/life_time); 
end

