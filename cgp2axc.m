function [A,bb] = cgp2axc(S_maj,S_min,theta,p0,fig)
%% Read ME
% [A,bb] = cgp2axc(S_maj,S_min,theta,p0,fig) returns parameters of an
% ellipse in terms of its affine transform matrix and negative transformed
% center (AXC) given the same ellipse in terms of its canonical geometric
% parameters (CGP).
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
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
%% 
if nargin == 4
    fig = false;
end
if size(p0,1) == 1;
    p0 = p0';
end

U = [sin(theta),-cos(theta);...
     cos(theta), sin(theta)];
 
L = [1/S_maj,    0    ;...
        0   , 1/S_min];

A = U*L*U';
bb = -A*p0;
if fig
    ind = 1;
    e = .01;
    m = max([S_maj S_min]);
    for x = linspace(-m,m,500)+p0(1);
        for y = linspace(-m,m,500)+p0(2);
            p = [x;y];
            if norm(A*p+bb,2)^2<1 && norm(A*p+bb,2)^2>(1-e) 
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
