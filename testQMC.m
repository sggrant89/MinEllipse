function [result,f] = testQMC(R,p0,result)
%% Read ME
% testAXC(A,bb) tests the QMC ellipse representation conversion algorithms
% by converting the inputs into each of the 3 other representations and
% then converting back to QMC. The result is compared to the input and test
% results are printed to the command window.
%
%INPUTS:
%   A:   Affine transform matrix A of an ellipse (2x2 Matrix)
%   bb:  Transformed center of ellipse (i.e. -A*p0) (2x1 Column Vector)
%   result: Optional user input. Results are appended to input result cell
%
%OUTPUTS:
%   result: Cell containing results of testing (Cell)
%   f:      Boolean flag indicating whether tests passed (true) or
%               failed (false)

%% Initialize Result Cell
if nargin == 2 || (nargin == 3 && isempty(result))
    result = { 'QMC Test' ,'Inputs',  []  ,'AXC',[],'CGP',[],'NCP',[];...
                   'R'    , R(1,1) ,R(1,2), [ ] ,[], [ ] ,[], [ ] ,[];...
                   [ ]    , R(2,1) ,R(2,2), [ ] ,[], [ ] ,[], [ ] ,[];...
               'X-Center' ,  p0(1) ,  []  , [ ] ,[], [ ] ,[], [ ] ,[];...
               'Y-Center' ,  p0(2) ,  []  , [ ] ,[], [ ] ,[], [ ] ,[]};
else
    result{size(result,1)+5,size(result,2)} = [];
    result{end-3,1} = 'R';
    result{end-1,1} = 'X-Center';
    result{end,1} = 'Y-Center';
    result{end-3,2} = R(1,1);
    result{end-2,2} = R(2,1);
    result{end-3,3} = R(1,2);
    result{end-2,3} = R(2,2);
    result{end-1,2} = p0(1);
    result{end,2} = p0(2);
end
f = true;

%% TEST QMC-->AXC-->QMC
fprintf('\nTesting QMC-->AXC-->QMC...') 
[A,bb] = qmc2axc(R,p0);
[R_p,p0_p] = axc2qmc(A,bb);

if abs(R(1,1)-R_p(1,1)) <= 1e-10 && ...
   abs(R(1,2)-R_p(1,2)) <= 1e-10 && ...
   abs(R(2,2)-R_p(2,2)) <= 1e-10 && ...
   abs(p0(1)-p0_p(1)) <= 1e-10 && ...
   abs(p0(2)-p0_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,4} = R_p(1,1);
    result{end-2,4} = R_p(2,1);
    result{end-3,5} = R_p(1,2);
    result{end-2,5} = R_p(2,2);
    result{end-1,4} = p0_p(1);
    result{end,4} = p0_p(2);
else
    fprintf('failure.\n')
    result{end-3,4} = R_p(1,1);
    result{end-2,4} = R_p(2,1);
    result{end-3,5} = R_p(1,2);
    result{end-2,5} = R_p(2,2);
    result{end-1,4} = p0_p(1);
    result{end,4} = p0_p(2);
    f = false;
end

%% TEST QMC-->CGP-->QMC
fprintf('Testing QMC-->CGP-->QMC...') 
[S_maj,S_min,theta,p0] = qmc2cgp(R,p0);
[R_p,p0_p] = cgp2qmc(S_maj,S_min,theta,p0);

if abs(R(1,1)-R_p(1,1)) <= 1e-10 && ...
   abs(R(1,2)-R_p(1,2)) <= 1e-10 && ...
   abs(R(2,2)-R_p(2,2)) <= 1e-10 && ...
   abs(p0(1)-p0_p(1)) <= 1e-10 && ...
   abs(p0(2)-p0_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,6} = R_p(1,1);
    result{end-2,6} = R_p(2,1);
    result{end-3,7} = R_p(1,2);
    result{end-2,7} = R_p(2,2);
    result{end-1,6} = p0_p(1);
    result{end,6} = p0_p(2);
else
    fprintf('failure.\n')
    result{end-3,6} = R_p(1,1);
    result{end-2,6} = R_p(2,1);
    result{end-3,7} = R_p(1,2);
    result{end-2,7} = R_p(2,2);
    result{end-1,6} = p0_p(1);
    result{end,6} = p0_p(2);
    f = false;
end

%% TEST QMC-->NCP-->QMC
fprintf('Testing QMC-->NCP-->QMC...') 
[c] = qmc2ncp(R,p0);
[R_p,p0_p] = ncp2qmc(c);

if abs(R(1,1)-R_p(1,1)) <= 1e-10 && ...
   abs(R(1,2)-R_p(1,2)) <= 1e-10 && ...
   abs(R(2,2)-R_p(2,2)) <= 1e-10 && ...
   abs(p0(1)-p0_p(1)) <= 1e-10 && ...
   abs(p0(2)-p0_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,8} = R_p(1,1);
    result{end-2,8} = R_p(2,1);
    result{end-3,9} = R_p(1,2);
    result{end-2,9} = R_p(2,2);
    result{end-1,8} = p0_p(1);
    result{end,8} = p0_p(2);
else
    fprintf('failure.\n')
    result{end-3,8} = R_p(1,1);
    result{end-2,8} = R_p(2,1);
    result{end-3,9} = R_p(1,2);
    result{end-2,9} = R_p(2,2);
    result{end-1,8} = p0_p(1);
    result{end,8} = p0_p(2);
    f = false;
end

