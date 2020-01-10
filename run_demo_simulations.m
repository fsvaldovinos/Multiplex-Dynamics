% A demo of the dynamic model on network structure 2978 subjected to each 
% of the six treatments (RO FW, RO Low, RO High, RP FW, RP Low, RP High).
% Expected output should match Fig. S4, with explanation in Fig. S4 and
% Fig. 2 of the Main Text. Computation time should be approximately 2 mins.
%
% CITE THIS CODE AS FOLLOWS:
% Hale, K.R.S. (2019). Pollinators in food webs: Mutualistic interactions 
%   increase diversity, stability, and function in multiplex networks

demo_network = 2978;

disp('Loading network structures and parameters...')
load('simulation_parameters.mat','parameter_set')

% food webs
load('networks_RO_FW.mat')
load('metabolics_RO_FW.mat')

% multiplex
load('networks_RO.mat')
load('metabolics_RO.mat')

% food webs
load('networks_RP_FW.mat')
load('metabolics_RP_FW.mat')

% multiplex
load('networks_RP.mat')
load('metabolics_RP.mat')

num_networks = numel(networks_RO_FW);
num_parameter_sets = numel(parameter_set.food_web);
num_simulations = num_networks * num_parameter_sets;

display_figures = 1;

% Run food webs (FW) and Low Multiplex...
i = demo_network;
this_network = mod(i,num_networks);
this_set = floor(i/(num_networks)) + 1;

if (this_network == 0)
    this_network = num_networks;
    this_set = this_set - 1;
end

disp('Starting RO FW...') % food web
sim_ID = strcat('RO_FW',sprintf('%05d',i));
[output_RO_FW, solution_RO_FW] = food_web_dynamics(networks_RO_FW(this_network), ...
    metabolics_RO_FW(this_network), parameter_set.food_web(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RO_FW.persistence)
title(''); sgtitle('RO FW');

disp('Starting RP FW...')
sim_ID = strcat('RP_FW',sprintf('%05d',i));
[output_RP_FW, solution_RP_FW] = food_web_dynamics(networks_RP_FW(this_network), ...
    metabolics_RP_FW(this_network), parameter_set.food_web(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RP_FW.persistence)
title(''); sgtitle('RP FW')

disp('Starting RO Low...') % multiplex, low rewards availability
sim_ID = strcat('RO_Low',sprintf('%05d',i));
[output_RO_Low, solution_RO_Low] = multiplex_dynamics(networks_RO(this_network), ...
    metabolics_RO(this_network), parameter_set.multiplex(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RO_Low.persistence)
title(''); sgtitle('RO Low')

disp('Starting RP Low...')
sim_ID = strcat('RP_Low',sprintf('%05d',i));
[output_RP_Low, solution_RP_Low] = multiplex_dynamics(networks_RP(this_network), ...
    metabolics_RP(this_network), parameter_set.multiplex(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RP_Low.persistence)
title(''); sgtitle('RP Low')

% Run High Multiplex...
i = i + num_networks;
this_network = mod(i,num_networks);
this_set = floor(i/(num_networks)) + 1;

if (this_network == 0)
    this_network = num_networks;
    this_set = this_set - 1;
end

disp('Starting RO High...') % multiplex, high rewards availability
sim_ID = strcat('RO_High',sprintf('%05d',i));
[output_RO_High, solution_RO_High] = multiplex_dynamics(networks_RO(this_network), ...
    metabolics_RO(this_network), parameter_set.multiplex(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RO_High.persistence)
title(''); sgtitle('RO High')

disp('Starting RP High...')
sim_ID = strcat('RP_High',sprintf('%05d',i));
[output_RP_High, solution_RP_High] = multiplex_dynamics(networks_RP(this_network), ...
    metabolics_RP(this_network), parameter_set.multiplex(this_set), sim_ID, ...
    display_figures);
disp('persistence = ')
disp(output_RP_High.persistence)
title(''); sgtitle('RP High')