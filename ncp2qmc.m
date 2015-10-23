function [R,p0] = ncp2qmc(c,fig)
%% Read ME
% [R,p0] = ncp2qmc(c,fig) returns parameters of an ellipse in terms of its
% quadratic matrix and center (QMC) given the same ellipse in terms of its
% nonlinearly-constrained polynomial coefficients.
%
%INPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%           (1x6 Row Vector)
%   fig:   Optional input if user would like ellipse to be shown in figure.
%           Default == false. (Boolean)
%
%OUTPUTS:
%   R:  Quadratic matrix of ellipse (2x2 Matrix)
%   p0: Ellipse center (2x1 Column Vector)

%%

if nargin==1
    fig = false;
end

R = [c(1) c(3);...
     c(3) c(2)];
p0 = (R\c(4:5)')*-.5;

if fig
    ind = 1;
    e = .02;
    [S_maj,S_min] = qmc2cgp(R,p0);
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