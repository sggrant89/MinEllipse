function c = cgp2ncp(S_maj,S_min,theta,p0,fig)
%% Read ME
% c = cgp2ncp(S_maj,S_min,theta,p0,fig) returns parameters of an ellipse in
%terms of its nonlinearly-constrained polynomial coefficients (NCP) given
% the same ellipse in terms of its canonical geometric parameters (CGP).
%
%INPUTS:
%   S_maj: Major (horizontal) ellipse axis measured from center to axis
%           crosssing
%   S_min: Minor (vertical) ellipse axis measured from center to axis
%           crossing
%   theta: Ellipse heading (i.e. tilt) measured clockwise from vertical
%   p0:    Ellipse center
%   fig:   Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%       (1x6 Row Vector)
%%

if nargin == 4
    fig = false;
end
if size(p0) == [1 2];
    p0 = p0';
end

U = [sin(theta),-cos(theta);...
     cos(theta), sin(theta)];
 
L = [1/S_maj,    0    ;...
        0   , 1/S_min];

R = U*L^2*U';

c(1) = R(1,1);
c(2) = R(2,2);
c(3) = R(1,2);
c(4:5) = -2*R*p0;
c(6) = ((c(1)*c(5)^2 + c(2)*c(4)^2 - 2*c(3)*c(4)*c(5))/(4*(c(1)*c(2)-c(3)^2)))-1;

if fig
    ind = 1;
    e = .01;
    m = max([S_maj S_min]);
    for x = linspace(-m,m,500)+p0(1);
        for y = linspace(-m,m,500)+p0(2);
            p = [x;y];
            if abs(c(1)*p(1)^2+c(2)*p(2)^2+2*c(3)*p(1)*p(2)+c(4)*p(1)+c(5)*p(2)+c(6))<=e 
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

