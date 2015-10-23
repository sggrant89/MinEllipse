close all
clear
clc
commandwindow

%% Enter User Inputs
N = 1000:1000:10000;
mu = 7;
sigma = 1000;
obj = 'log';
fig = true;

%% Parse Inputs
if ~isscalar(N)
    if isscalar(mu)
        mu = mu*ones(size(N));
    end
    if isscalar(sigma)
        sigma = sigma*ones(size(N));
    end
end
if ~isscalar(mu)
    if isscalar(N)
        N = N*ones(size(mu));
    end
    if isscalar(sigma)
        sigma = sigma*ones(size(mu));
    end
end
if ~isscalar(sigma)
    if isscalar(N)
        N = N*ones(size(sigma));
    end
    if isscalar(mu)
        mu = mu*ones(size(sigma));
    end
end
if length(N)~=length(mu) || length(N)~=length(sigma) || ...
   length(mu)~=length(sigma)
    error('Length of inputs vectors must be the same')
end

%% Test Optimization
for i = 1:length(N)
    clc
    fprintf('N = %d\n',N(i))
    fprintf('mu = %d\n',mu(i))
    fprintf('sigma = %d\n',sigma(i))
    fprintf(['obj = ',obj,'\n'])
%% Generate random set of points
    pp = normrnd(mu(i),sigma(i),N(i),2);

%% Find Minimum Area Ellipse
    [xx,fval,exitflag,output] = findMinEllip(pp,obj,fig);
    if exitflag == 1
        fprintf('\nSuccess!\n')
    else
        error('\nUhoh! No solution found.\n')
    end
end