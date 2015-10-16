function v = qmc2epb(R,p0,N,fig)
%% Read ME
% v = qmc2epb(R,p0,N,fig) returns N points of a polygon forming the boudary
% of an ellipse (EPB) given the same ellipse in terms of its quadratic
% matrix and center (QMC)
%
%INPUTS:
%   R:   Quadratic matrix of ellipse (2x2 Matrix)
%   p0:  Ellipse center (2x1 Column Vector)
%   fig: Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   v: N points describing vertices of N sided polygon indicating boundary
%           of an ellipse. (2xN Matrix)
%%

if nargin == 3
    fig = false;
end
if size(p0) == [1 2];
    p0 = p0';
end

[S_maj,S_min,theta,p0] = qmc2cgp(R,p0);
v = cgp2epb(S_maj,S_min,theta,p0,N);

if fig
    plot(v(1,:),v(2,:),'-o')
    grid on
    m = max([S_maj S_min]);
    xlim([-1.1*m 1.1*m]+p0(1))
    ylim([-1.1*m 1.1*m]+p0(2))
end