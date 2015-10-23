function [result,f] = testNCP(c,result)
%% Read ME
% testNCP(A,bb) tests the NCP ellipse representation conversion algorithms
% by converting the inputs into each of the 3 other representations and
% then converting back to NCP. The result is compared to the input and test
% results are printed to the command window.
%
%INPUTS:
%   c: Row vector containing 6 polynomial coefficients of ellipse
%           (1x6 Row Vector)
%   result: Optional user input. Results are appended to input result cell
%
%OUTPUTS:
%   result: Cell containing results of testing (Cell)
%   f:      Boolean flag indicating whether tests passed (true) or
%               failed (false)

%% Initialize Result Cell
if nargin == 1 || (nargin == 2 && isempty(result))
    result = {     'NCP Test'     ,'Inputs', 'AXC','CGP','QMC';...
                       'a'        ,  c(1)  ,  [ ] , [ ] , [ ] ;...
                       'b'        ,  c(2)  ,  [ ] , [ ] , [ ] ;...
                       'c'        ,  c(3)  ,  [ ] , [ ] , [ ] ;...
                       'd'        ,  c(4)  ,  [ ] , [ ] , [ ] ;...
                       'e'        ,  c(5)  ,  [ ] , [ ] , [ ] ;...
                       'f'        ,  c(6)  ,  [ ] , [ ] , [ ] };
else
    result{size(result,1)+7,size(result,2)} = [];
    result{end-5,1} = 'a';
    result{end-4,1} = 'b';
    result{end-3,1} = 'c';
    result{end-2,1} = 'd';
    result{end-1,1} = 'e';
    result{end-0,1} = 'f';
    result{end-5,2} = c(1);
    result{end-4,2} = c(2);
    result{end-3,2} = c(3);
    result{end-2,2} = c(4);
    result{end-1,2} = c(5);
    result{end-0,2} = c(6);
end
f = true;

%% TEST NCP-->AXC-->NCP
fprintf('\nTesting NCP-->AXC-->NCP...') 
[A,bb] = ncp2axc(c);
c_p = axc2ncp(A,bb);

if abs(c(1)-c_p(1)) <= 1e-10 && ...
   abs(c(2)-c_p(2)) <= 1e-10 && ...
   abs(c(3)-c_p(3)) <= 1e-10 && ...
   abs(c(4)-c_p(4)) <= 1e-10 && ...
   abs(c(5)-c_p(5)) <= 1e-10 && ...
   abs(c(6)-c_p(6)) <= 1e-10
    fprintf('success.\n')
    result{end-5,3} = c_p(1);
    result{end-4,3} = c_p(2);
    result{end-3,3} = c_p(3);
    result{end-2,3} = c_p(4);
    result{end-1,3} = c_p(5);
    result{end-0,3} = c_p(6);
else
    result{end-5,3} = c_p(1);
    result{end-4,3} = c_p(2);
    result{end-3,3} = c_p(3);
    result{end-2,3} = c_p(4);
    result{end-1,3} = c_p(5);
    result{end-0,3} = c_p(6);
    f = false;
end

%% TEST NCP-->CGP-->NCP
fprintf('Testing NCP-->CGP-->NCP...') 
[S_maj,S_min,theta,p0] = ncp2cgp(c);
[c_p] = cgp2ncp(S_maj,S_min,theta,p0);

if abs(c(1)-c_p(1)) <= 1e-10 && ...
   abs(c(2)-c_p(2)) <= 1e-10 && ...
   abs(c(3)-c_p(3)) <= 1e-10 && ...
   abs(c(4)-c_p(4)) <= 1e-10 && ...
   abs(c(5)-c_p(5)) <= 1e-10 && ...
   abs(c(6)-c_p(6)) <= 1e-10
    fprintf('success.\n')
    result{end-5,4} = c_p(1);
    result{end-4,4} = c_p(2);
    result{end-3,4} = c_p(3);
    result{end-2,4} = c_p(4);
    result{end-1,4} = c_p(5);
    result{end-0,4} = c_p(6);
else
    result{end-5,4} = c_p(1);
    result{end-4,4} = c_p(2);
    result{end-3,4} = c_p(3);
    result{end-2,4} = c_p(4);
    result{end-1,4} = c_p(5);
    result{end-0,4} = c_p(6);
    f = false;
end

%% TEST NCP-->QMC-->NCP
fprintf('Testing NCP-->QMC-->NCP...') 
[R,p0] = ncp2qmc(c);
c_p = qmc2ncp(R,p0);

if abs(c(1)-c_p(1)) <= 1e-10 && ...
   abs(c(2)-c_p(2)) <= 1e-10 && ...
   abs(c(3)-c_p(3)) <= 1e-10 && ...
   abs(c(4)-c_p(4)) <= 1e-10 && ...
   abs(c(5)-c_p(5)) <= 1e-10 && ...
   abs(c(6)-c_p(6)) <= 1e-10
    fprintf('success.\n')
    result{end-5,5} = c_p(1);
    result{end-4,5} = c_p(2);
    result{end-3,5} = c_p(3);
    result{end-2,5} = c_p(4);
    result{end-1,5} = c_p(5);
    result{end-0,5} = c_p(6);
else
    result{end-5,5} = c_p(1);
    result{end-4,5} = c_p(2);
    result{end-3,5} = c_p(3);
    result{end-2,5} = c_p(4);
    result{end-1,5} = c_p(5);
    result{end-0,5} = c_p(6);
    f = false;
end

