function [A,bb] = ncp2axc(c,fig)
%% Read ME
% [A,bb] = ncp2axc(c,fig) returns parameters of an ellipse in terms of its
% affine transform matrix and negative transformed center (AXC) given the
% same ellipse in terms of its nonlinearly-constrained polynomial
% coefficients (NCP).
%
%INPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%           (1x6 Row Vector)
%   fig:   Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
%%

if nargin==1
    fig = false;
end

[R,p0] = ncp2qmc(c);
[A,bb] = qmc2axc(R,p0);

if fig
    ind = 1;
    e = .01;
    [S_maj,S_min] = axc2cgp(A,bb);
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
