function [result,f] = testCGP(S_maj,S_min,theta,p0,result)
%% Read ME
% testCGP(S_maj,S_min,theta,p0) tests the CGP ellipse representation
% conversion algorithms by converting the inputs into each of the 3 other
% representations and then converting back to CGP. The result is compared
% to the input and test results are printed to the command window.
%
%INPUTS:
%   S_maj:  Major (horizontal) ellipse axis measured from center to axis
%           crosssing
%   S_min:  Minor (vertical) ellipse axis measured from center to axis
%           crossing
%   theta:  Ellipse heading (i.e. tilt) measured clockwise from vertical
%   p0:     Ellipse center
%   result: Optional user input. Results are appended to input result cell
%
%OUTPUTS:
%   result: Cell containing results of testing (Cell)
%   f:      Boolean flag indicating whether tests passed (true) or
%               failed (false)

%% Initialize Result Cell
if nargin == 4 || (nargin == 5 && isempty(result))
    result = { 'CGP Test' ,'Inputs','AXC','NCP','QMC';...
              'Major Axis',  S_maj , []  , []  , []  ;...
              'Minor Axis',  S_min , []  , []  , []  ;...
               'Heading'  ,  theta , []  , []  , []  ;...
               'X-Center' ,  p0(1) , []  , []  , []  ;...
               'Y-Center' ,  p0(2) , []  , []  , []  };
else
    result{size(result,1)+6,size(result,2)} = [];
    result{end-4,1} = 'Major Axis';
    result{end-3,1} = 'Minor Axis';
    result{end-2,1} = 'Heading Axis';
    result{end-1,1} = 'X-Center';
    result{end,1} = 'Y-Center';
    result{end-4,2} = S_maj;
    result{end-3,2} = S_min;
    result{end-2,2} = theta;
    result{end-1,2} = p0(1);
    result{end,2} = p0(2);
end
f = true;

%% TEST CGP-->AXC-->CGP
fprintf('\nTesting CGP-->AXC-->CGP...')
[A,bb] = cgp2axc(S_maj,S_min,theta,p0);
[S_maj_p,S_min_p,theta_p,p0_p] = axc2cgp(A,bb);

if S_maj ~= S_min
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(theta-theta_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,3}=S_maj_p;
        result{end-3,3}=S_min_p;
        result{end-2,3}=theta_p;
        result{end-1,3}=p0_p(1);
        result{end,3}=p0_p(2);
    elseif abs(S_min-S_maj_p) <= 1e-9 && ...
           abs(S_maj-S_min_p) <= 1e-9 && ...
           abs(theta-theta_p-pi/2*sign(theta)) <= 1e-9 && ...
           abs(p0(1)-p0_p(1)) <= 1e-9 && ...
           abs(p0(2)-p0_p(2)) <= 1e-9
        result{end-4,3}=S_maj_p;
        result{end-3,3}=S_min_p;
        result{end-2,3}=theta_p;
        result{end-1,3}=p0_p(1);
        result{end,3}=p0_p(2);
        fprintf('success.\n')
    else
        fprintf('failure.\n')
        result{end-4,3}=S_maj_p;
        result{end-3,3}=S_min_p;
        result{end-2,3}=theta_p;
        result{end-1,3}=p0_p(1);
        result{end,3}=p0_p(2);
        f = false;
    end
else %S_maj == S_maj (circle...ignore theta)
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,3}=S_maj_p;
        result{end-3,3}=S_min_p;
        result{end-2,3}=theta_p;
        result{end-1,3}=p0_p(1);
        result{end,3}=p0_p(2);
    else
        fprintf('failure.\n')
        result{end-4,3}=S_maj_p;
        result{end-3,3}=S_min_p;
        result{end-2,3}=theta_p;
        result{end-1,3}=p0_p(1);
        result{end,3}=p0_p(2);
        f = false;
    end
end

%% TEST CGP-->NCP-->CGP
fprintf('Testing CGP-->NCP-->CGP...') 
c = cgp2ncp(S_maj,S_min,theta,p0);
[S_maj_p,S_min_p,theta_p,p0_p] = ncp2cgp(c);

if S_maj ~= S_min
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(theta-theta_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,4}=S_maj_p;
        result{end-3,4}=S_min_p;
        result{end-2,4}=theta_p;
        result{end-1,4}=p0_p(1);
        result{end,4}=p0_p(2);
    elseif abs(S_min-S_maj_p) <= 1e-9 && ...
           abs(S_maj-S_min_p) <= 1e-9 && ...
           abs(theta-theta_p-pi/2*sign(theta)) <= 1e-9 && ...
           abs(p0(1)-p0_p(1)) <= 1e-9 && ...
           abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,4}=S_maj_p;
        result{end-3,4}=S_min_p;
        result{end-2,4}=theta_p;
        result{end-1,4}=p0_p(1);
        result{end,4}=p0_p(2);
    else
        fprintf('failure.\n')
        result{end-4,4}=S_maj_p;
        result{end-3,4}=S_min_p;
        result{end-2,4}=theta_p;
        result{end-1,4}=p0_p(1);
        result{end,4}=p0_p(2);
        f = false;
    end
else %S_maj == S_maj (circle...ignore theta)
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,4}=S_maj_p;
        result{end-3,4}=S_min_p;
        result{end-2,4}=theta_p;
        result{end-1,4}=p0_p(1);
        result{end,4}=p0_p(2);
    else
        fprintf('failure.\n')
        result{end-4,4}=S_maj_p;
        result{end-3,4}=S_min_p;
        result{end-2,4}=theta_p;
        result{end-1,4}=p0_p(1);
        result{end,4}=p0_p(2);
        f = false;
    end
end

%% TEST CGP-->QMC-->CGP
fprintf('Testing CGP-->QMC-->CGP...') 
[R,p0] = cgp2qmc(S_maj,S_min,theta,p0);
[S_maj_p,S_min_p,theta_p,p0_p] = qmc2cgp(R,p0);
if S_maj ~= S_min
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(theta-theta_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,5}=S_maj_p;
        result{end-3,5}=S_min_p;
        result{end-2,5}=theta_p;
        result{end-1,5}=p0_p(1);
        result{end,5}=p0_p(2);
    elseif abs(S_min-S_maj_p) <= 1e-9 && ...
           abs(S_maj-S_min_p) <= 1e-9 && ...
           abs(theta-theta_p-pi/2*sign(theta)) <= 1e-9 && ...
           abs(p0(1)-p0_p(1)) <= 1e-9 && ...
           abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,5}=S_maj_p;
        result{end-3,5}=S_min_p;
        result{end-2,5}=theta_p;
        result{end-1,5}=p0_p(1);
        result{end,5}=p0_p(2);
    else
        fprintf('failure.\n')
        result{end-4,5}=S_maj_p;
        result{end-3,5}=S_min_p;
        result{end-2,5}=theta_p;
        result{end-1,5}=p0_p(1);
        result{end,5}=p0_p(2);
        f = false;
    end
else %S_maj == S_maj (circle...ignore theta)
    if abs(S_maj-S_maj_p) <= 1e-9 && ...
       abs(S_min-S_min_p) <= 1e-9 && ...
       abs(p0(1)-p0_p(1)) <= 1e-9 && ...
       abs(p0(2)-p0_p(2)) <= 1e-9
        fprintf('success.\n')
        result{end-4,5}=S_maj_p;
        result{end-3,5}=S_min_p;
        result{end-2,5}=theta_p;
        result{end-1,5}=p0_p(1);
        result{end,5}=p0_p(2);
    else
        fprintf('failure.\n')
        result{end-4,5}=S_maj_p;
        result{end-3,5}=S_min_p;
        result{end-2,5}=theta_p;
        result{end-1,5}=p0_p(1);
        result{end,5}=p0_p(2);
        f = false;
    end
end
