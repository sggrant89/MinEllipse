function [ff,gg] = minEllipObj(xx,option)
%% Read Me
% [ff,gg] = minEllipObj(xx,option) generates the value of the objective
% function specified by the user and its gradient for fmincon in finding
% the minimum area ellipse that contains a set of points.
%
% INPUTS
%   xx:     The affine transform coefficients of the inputs ellipse. 
%               [1x5 row vector]
%   option: String indicating the objective function to be used in finding
%               the minimum area ellipse. [char]
%               Options are as follows:
%               1) 'linear' : -(xx(1)*xx(2)-xx(3)^2)
%               2) 'log'    : -log(xx(1)*xx(2)-xx(3)^2);
%               3) 'root'   : -sqrt(xx(1)*xx(2)-xx(3)^2);
%
% OUTPUTS
%   ff: The value of the objective function for the input ellipse xx
%   gg: The gradient of the objective function for the input ellipse xx
%
%% Determine Input Option and Calulate Objective Function and Gradient
if strcmp(option,'linear')
    ff = -(xx(1)*xx(2)-xx(3)^2);
    gg(1,1) = -xx(2);
    gg(1,2) = -xx(1);
    gg(1,3) = 2*xx(3);
elseif strcmp(option,'log')
    ff = -log(xx(1)*xx(2)-xx(3)^2);
    gg(1,1) = xx(2)/(xx(3)^2-xx(1)*xx(2));
    gg(1,2) = xx(1)/(xx(3)^2-xx(1)*xx(2));
    gg(1,3) = 2*xx(3)/(xx(1)*xx(2)-xx(3)^2);
elseif strcmp(option,'root')
    ff = -sqrt(xx(1)*xx(2)-xx(3)^2);
    gg(1,1) = -xx(2)/(2*sqrt(xx(1)*xx(2)-xx(3)^2));
    gg(1,2) = -xx(1)/(2*sqrt(xx(1)*xx(2)-xx(3)^2));
    gg(1,3) = xx(3)/sqrt(xx(1)*xx(2)-xx(3)^2);
end
gg(1,4) = 0;
gg(1,5) = 0;