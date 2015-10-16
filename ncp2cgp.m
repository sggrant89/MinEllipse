function [S_maj,S_min,theta,p0] = ncp2cgp(c,fig)
%% Read ME
% [S_maj,S_min,theta,p0] = ncp2cgp(c,fig) returns parameters of an ellipse
% in terms of canonical geometric parameters (CGP) given the same ellipse
% in terms of its nonlinearly-constrained polynomial coefficients.
%
%INPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%           (1x6 Row Vector)
%   fig:   Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   S_maj: Major (horizontal) ellipse axis measured from center to axis
%           crosssing
%   S_min: Minor (vertical) ellipse axis measured from center to axis
%           crossing
%   theta: Ellipse heading (i.e. tilt) measured clockwise from vertical
%   p0:    Ellipse center
%%

if nargin==1
    fig = false;
end

[R,p0] = ncp2qmc(c);
[S_maj,S_min,theta,p0] = qmc2cgp(R,p0);

if fig
    ind = 1;
    e = .01;
    m = max([S_maj S_min]);
    for x = linspace(-m,m,500)+p0(1);
        for y = linspace(-m,m,500)+p0(2);
            p = [x;y];
            l1 = (((p(1)-p0(1))*sin(theta)+(p(2)-p0(2))*cos(theta))/S_maj)^2;
            l2 = (((p(1)-p0(1))*cos(theta)-(p(2)-p0(2))*sin(theta))/S_min)^2;
            l = l1+l2;
            if l<=1 && l>(1-e) 
                s(:,ind) = p';
                ind = ind+1;
            end
        end
    end
    plot(s(1,:),s(2,:),'o')
    grid on
    xlim([-1.1*m 1.1*m]+p0(1))
    ylim([-1.1*m 1.1*m]+p0(2))
end