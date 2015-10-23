function stop = outfun(x,d,state)
%% Read Me
% stop = outfun(x,d,state) is the output function for each iteration of
% fmincon. After each iteration it appends the most recent result and saves
% it to a file called iterHistory.mat
%
% INPUTS:
%   x: The current value of fmincon iteration
%   d: Placeholder dummy variable
%   state: State of fmincon (either 'init', 'iter' or 'done')
%
% OUTPUTS
%   stop: Placeholder boolean

%% Initialize or Append Iteration History
stop = false;
if strcmp(state,'init')
    h = [];
    save('iterHistory.mat','h')
elseif strcmp(state,'iter')
   load('iterHistory.mat');
   h = [h;x];
   save('iterHistory.mat','h')
end