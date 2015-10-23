function [xx,fval,exitflag,output,xx0] = findMinEllip(pp,obj,fig,iterHistory)
%% Read Me
% xx = findMinEllip(pp,obj,fig) finds the minimum area ellipse that
% contains all N points in the Nx2 matrix pp. It achieves this by
% minimizing the objective function specified by the string obj.
%
% INPUTS
%   pp:  Set of N points that minimum area ellipse will contain. 
%           [Nx2 matrix]
%   obj: String specifying which objective function to be minimized. [char]
%           Options are as follows:
%           1) 'linear' : -(xx(1)*xx(2)-xx(3)^2)
%           2) 'log'    : -log(xx(1)*xx(2)-xx(3)^2);
%           3) 'root'   : -sqrt(xx(1)*xx(2)-xx(3)^2);
%   fig: Optional flag for drawing the resulting ellipse. Default is false.
%           [Boolean]
%   iterHistory: Optional flag for saving the results of each iteration.
%           Default is false. [Boolean]
%           
% OUTPUTS
%   xx:       The affine transform coefficients of the minimum area ellipse.
%   fval:     Objective function value at the solution.
%   exitflag: Flag indicating reason fmincon stopped, returned as integer.
%               See MATLAB's fmincon documentation for details.
%   outout:   Information about the optimization process, returned as a
%               structure. See MATLAB's fmincon documentation for details.
%   xx0:      The affine transform coefficients of the initial ellipse
%
%% Parse Inputs
if nargin == 2
    fig = false;
    iterHistory = false;
elseif nargin == 3
    iterHistory = false;
end

%% Generate Initial Ellipse
xx0 = genInitEllip(pp);

%% Set Bounds and Options
lb= [0; 0; -Inf; -Inf; -Inf];
ub= [Inf; Inf; Inf; Inf; Inf];
if iterHistory
    options= optimoptions('fmincon','GradObj','on','GradConstr', 'on',...
                        'MaxIter',10000,'Display','off','OutputFcn',@outfun);
else
    options= optimoptions('fmincon','GradObj','on','GradConstr', 'on',...
                        'MaxIter',10000,'Display','off');
end

%% Find Minimum Area Ellipse
[xx,fval,exitflag,output] = fmincon(@(xx)minEllipObj(xx,obj), xx0, ...
           [],[],[],[],lb,ub, @(xx)ellipCon(xx,pp), options);

%% Draw Figure if Necessary
if fig
    draw(xx0,xx,pp);
    legend('Initial Ellipse','Minimum Area Ellipse')
end