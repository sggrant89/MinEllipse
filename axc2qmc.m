function [R,p0] = axc2qmc(A,bb,fig)
%% Read ME
% [R,p0] = axc2qmc(A,bb,fig) returns parameters of an ellipse in terms of
% its quadratic matrix and center (QMC) given the same ellipse in terms of
% its affine transform matrix, A, and negative transformed center, b.
%
%INPUTS:
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
%   fig: Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   R:  Quadratic matrix of ellipse (2x2 Matrix)
%   p0: Ellipse center (2x1 Column Vector)
%%
if nargin == 2
    fig = false;
end
if size(bb) == [1 2];
    bb = bb';
end

R = A^2;
p0 = -A\bb;

if fig
    ind = 1;
    e = .02;
    [S_maj,S_min] = axc2cgp(A,bb);
    m = max([S_maj S_min]);
    for x = linspace(-m,m,500)+p0(1);
        for y = linspace(-m,m,500)+p0(2);
            p = [x;y];
            if (p-p0)'*R*(p-p0)<=1 && (p-p0)'*R*(p-p0)>(1-e) 
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

