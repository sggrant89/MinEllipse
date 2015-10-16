function xx = findMinEllip(pp,obj,fig)
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
% OUTPUTS
%   xx: The affine transform coefficients of the minimum area ellipse.
%
%% Parse Inputs
if nargin == 2
    fig = false;
end

%% Generate Initial Ellipse
xx0 = genInitEllip(pp);

%% Set Bounds and Options
lb= [0; 0; -Inf; -Inf; -Inf];
ub= [Inf; Inf; Inf; Inf; Inf];
options= optimoptions('fmincon','GradObj','on','GradConstr', 'on','MaxIter',10000);

%% Find Minimum Area Ellipse
xx = fmincon(@(xx)minEllipObj(xx,obj), xx0, ...
           [],[],[],[],lb,ub, @(xx)ellipCon(xx,pp), options);

%% Draw Figure if Necessary
if fig
    draw(xx0,xx,pp);
    legend('Initial Ellipse','Minimum Area Ellipse')
end