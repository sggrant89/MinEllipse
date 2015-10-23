function v = cgp2epb(S_maj,S_min,theta,p0,N,fig)
%% Read ME
% v = cgp2epb(S_maj,S_min,theta,p0,N,fig) returns N points of a polygon
% forming the boudary of an ellipse (EPB) given the same ellipse in terms
% of its canonical geometric parameters (CGP).
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
%   v: N points describing vertices of N sided polygon indicating boundary
%           of an ellipse. (2xN Matrix)

%%

if nargin == 5
    fig = false;
end
if size(p0) == [1 2];
    p0 = p0';
end

v = zeros(2,N);
for n = 0:N-1
    phi_n = 2*pi*n/N;
    v(1,n+1) = p0(1)+S_maj*sin(theta)*cos(phi_n)+S_min*cos(theta)*sin(phi_n);
    v(2,n+1) = p0(2)+S_maj*cos(theta)*cos(phi_n)-S_min*sin(theta)*sin(phi_n);
end

if fig
    plot(v(1,:),v(2,:),'-o')
    grid on
    m = max([S_maj S_min]);
    xlim([-1.1*m 1.1*m]+p0(1))
    ylim([-1.1*m 1.1*m]+p0(2))
end