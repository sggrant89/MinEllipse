function [result,f] = testAXC(A,bb,result)
%% Read ME
% testAXC(A,bb) tests the AXC ellipse representation conversion algorithms
% by converting the inputs into each of the 3 other representations and
% then converting back to AXC. The result is compared to the input and test
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
    result = {     'AXC Test'     ,'Inputs',  []  ,'CGP',[],'NCP',[],'QMC',[];...
                       'A'        , A(1,1) ,A(1,2), [ ] ,[], [ ] ,[], [ ] ,[];...
                       [ ]        , A(2,1) ,A(2,2), [ ] ,[], [ ] ,[], [ ] ,[];...
               'Xformed X-Center' ,  bb(1) ,  []  , [ ] ,[], [ ] ,[], [ ] ,[];...
               'Xformed Y-Center' ,  bb(2) ,  []  , [ ] ,[], [ ] ,[], [ ] ,[]};
else
    result{size(result,1)+5,size(result,2)} = [];
    result{end-3,1} = 'A';
    result{end-1,1} = 'Xformed X-Center';
    result{end,1} = 'Xformed Y-Center';
    result{end-3,2} = A(1,1);
    result{end-2,2} = A(2,1);
    result{end-3,3} = A(1,2);
    result{end-2,3} = A(2,2);
    result{end-1,2} = bb(1);
    result{end,2} = bb(2);
end
f = true;

%% TEST AXC-->CGP-->AXC
fprintf('\nTesting AXC-->CGP-->AXC...') 
[S_maj,S_min,theta,p0] = axc2cgp(A,bb);
[A_p,bb_p] = cgp2axc(S_maj,S_min,theta,p0);

if abs(A(1,1)-A_p(1,1)) <= 1e-10 && ...
   abs(A(1,2)-A_p(1,2)) <= 1e-10 && ...
   abs(A(2,2)-A_p(2,2)) <= 1e-10 && ...
   abs(bb(1)-bb_p(1)) <= 1e-10 && ...
   abs(bb(2)-bb_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,4} = A_p(1,1);
    result{end-2,4} = A_p(2,1);
    result{end-3,5} = A_p(1,2);
    result{end-2,5} = A_p(2,2);
    result{end-1,4} = bb_p(1);
    result{end,4} = bb_p(2);
else
    fprintf('failure.\n')
    result{end-3,4} = A_p(1,1);
    result{end-2,4} = A_p(2,1);
    result{end-3,5} = A_p(1,2);
    result{end-2,5} = A_p(2,2);
    result{end-1,4} = bb_p(1);
    result{end,4} = bb_p(2);
    f = false;
end

%% TEST AXC-->NCP-->AXC
fprintf('Testing AXC-->NCP-->AXC...') 
c = axc2ncp(A,bb);
[A_p,bb_p] = ncp2axc(c);

if abs(A(1,1)-A_p(1,1)) <= 1e-10 && ...
   abs(A(1,2)-A_p(1,2)) <= 1e-10 && ...
   abs(A(2,2)-A_p(2,2)) <= 1e-10 && ...
   abs(bb(1)-bb_p(1)) <= 1e-10 && ...
   abs(bb(2)-bb_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,6} = A_p(1,1);
    result{end-2,6} = A_p(2,1);
    result{end-3,7} = A_p(1,2);
    result{end-2,7} = A_p(2,2);
    result{end-1,6} = bb_p(1);
    result{end,6} = bb_p(2);
else
    fprintf('failure.\n')
    result{end-3,6} = A_p(1,1);
    result{end-2,6} = A_p(2,1);
    result{end-3,7} = A_p(1,2);
    result{end-2,7} = A_p(2,2);
    result{end-1,6} = bb_p(1);
    result{end,6} = bb_p(2);
    f = false;
end

%% TEST AXC-->QMC-->AXC
fprintf('Testing AXC-->QMC-->AXC...') 
[R,p0] = axc2qmc(A,bb);
[A_p,bb_p] = qmc2axc(R,p0);

if abs(A(1,1)-A_p(1,1)) <= 1e-10 && ...
   abs(A(1,2)-A_p(1,2)) <= 1e-10 && ...
   abs(A(2,2)-A_p(2,2)) <= 1e-10 && ...
   abs(bb(1)-bb_p(1)) <= 1e-10 && ...
   abs(bb(2)-bb_p(2)) <= 1e-10
    fprintf('success.\n')
    result{end-3,8} = A_p(1,1);
    result{end-2,8} = A_p(2,1);
    result{end-3,9} = A_p(1,2);
    result{end-2,9} = A_p(2,2);
    result{end-1,8} = bb_p(1);
    result{end,8} = bb_p(2);
else
    fprintf('failure.\n')
    result{end-3,8} = A_p(1,1);
    result{end-2,8} = A_p(2,1);
    result{end-3,9} = A_p(1,2);
    result{end-2,9} = A_p(2,2);
    result{end-1,8} = bb_p(1);
    result{end,8} = bb_p(2);
    f = false;
end

