function c = axc2ncp(A,bb,fig)
%% Read ME
% c = axc2ncp(A,bb,fig) returns parameters of an ellipse in terms of
% its nonlinearly-constrained polynomial coefficients (NCP) given the same
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
%   c: Row vector containing 6 polynomial coefficients of ellipse
%       (1x6 Row Vector)

%%
if nargin == 2
    fig = false;
end
if size(bb) == [1 2];
    bb = bb';
end

[R,p0] = axc2qmc(A,bb);
c = qmc2ncp(R,p0);

if fig
    ind = 1;
    e = .01;
    [S_maj,S_min] = axc2cgp(A,bb);
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
