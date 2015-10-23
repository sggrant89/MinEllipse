function [cc,d1,grad_cc,d2] = ellipCon(xx,pp)
%% Read Me
% [cc,d1,grad_cc,d2] = ellipCon(xx,pp) calculates the non-linear contraints
% and their gradients for the fmincon used to find the minimum area ellipse
% containing a set of points.
%
% INPUTS
%   xx: The affine transform coefficients of the inputs ellipse. 
%           [1x5 row vector]
%   pp: The set of N points to be contained by the minimum area ellipse.
%           [Nx2 matrix]
%
% OUTPUTS
%   cc:      The value of the constraints for the input ellipse xx
%   d1:      Dummy empty matrix for input to fmincon
%   grad_cc: The gradient of the constraints for the input ellipse xx
%   d2:      Dummy empty matrix for input to fmincon

%% Assign Dummy Matrices as Empty
d1 = [];
d2 = [];

%% Map Ellipse Parameters
A(1,1) = xx(1);
A(2,2) = xx(2);
A(1,2) = xx(3);
A(2,1) = xx(3);
bb(1,1) = xx(4);
bb(2,1) = xx(5);

%% Calculate the Constraint and Its Gradient for Each of the N points in pp
cc = zeros(length(pp),1);
grad_cc = zeros(length(xx),length(pp));
for i = 1:size(pp,1)
    cc(i) = norm(A*pp(i,:)'+bb,2)^2-1;
    grad_cc(1,i) = 2*pp(i,1)*(xx(1)*pp(i,1)+xx(3)*pp(i,2)+xx(4));
    grad_cc(2,i) = 2*pp(i,2)*(xx(2)*pp(i,2)+xx(3)*pp(i,1)+xx(5));
    grad_cc(3,i) = 2*pp(i,2)*(xx(3)*pp(i,2)+xx(1)*pp(i,1)+xx(4))+...
                   2*pp(i,1)*(xx(3)*pp(i,1)+xx(2)*pp(i,2)+xx(5));
    grad_cc(4,i) = 2*(xx(4)+xx(1)*pp(i,1)+xx(3)*pp(i,2));
    grad_cc(5,i) = 2*(xx(5)+xx(3)*pp(i,1)+xx(2)*pp(i,2));
end