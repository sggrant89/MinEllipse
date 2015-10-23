function v = axc2epb(A,bb,N,fig)
%% Read ME
% v = axc2epb(A,bb,N,fig) returns N points of a polygon forming the boudary
% of an ellipse (EPB) given the same ellipse in terms of its affine
% transform matrix, A, and negative transformed center, b.
%
%INPUTS:
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
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
if size(bb) == [1 2];
    bb = bb';
end

[S_maj,S_min,theta,p0] = axc2cgp(A,bb);
v = cgp2epb(S_maj,S_min,theta,p0,N);

if fig
    plot(v(1,:),v(2,:),'-')
    grid on
    m = max([S_maj S_min]);
    xlim([-1.1*m 1.1*m]+p0(1))
    ylim([-1.1*m 1.1*m]+p0(2))
end