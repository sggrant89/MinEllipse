function v = ncp2epb(c,N,fig)
%% Read ME
% v = ncp2epb(c,N,fig) returns N points of a polygon forming the boudary
% of an ellipse (EPB)  given the same ellipse in terms of its nonlinearly-
% constrained polynomial coefficients.
%
%INPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%           (1x6 Row Vector)
%   fig:   Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   v: N points describing vertices of N sided polygon indicating boundary
%           of an ellipse. (2xN Matrix)

%%

if nargin==2
    fig = false;
end

[R,p0] = ncp2qmc(c);
v = qmc2epb(R,p0,N);

if fig
    plot(v(1,:),v(2,:),'-o')
    grid on
    m = max(v(:));
    xlim([-1.1*m 1.1*m]+p0(1))
    ylim([-1.1*m 1.1*m]+p0(2))
end