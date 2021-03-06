function [S_maj,S_min,theta,p0] = axc2cgp(A,bb,fig)
%% Read ME
% [S_maj,S_min,theta,p0] = axc2cgp(A,bb,fig) returns parameters of an
% ellipse in terms of canonical geometric parameters (CGP) given the same
% ellipse in terms of its affine transform matrix, A, and negative 
% transformed center, b.
%
%INPUTS:
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
%   fig: Optional input if user would like ellipse to be shown in figure.
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

if nargin == 2
    fig = false;
end
if size(bb) == [1 2];
    bb = bb';
end

[U,D] = eig(A);
S_maj = 1/D(1,1);
S_min = 1/D(2,2);
if U(2,1)~=0
    theta = asin(U(1,1))*sign(U(2,1));
else
    theta = asin(U(1,1));
end
p0 = -A\bb;

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

