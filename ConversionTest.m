function [result_CGP,result_QMC,result_AXC] = ConversionTest(S_maj,S_min,theta,p0,save,filename)
%% Read ME
% ConversionTestAXC(S_maj,S_min,theta,p0,save,filename) tests all of the
% elliptical conversion algorithms by converting from each form into all
% the others and back and comparing the results. Test results are printed
% out to the command window and can be saved to csv if desired. The
% parameters of the test ellipse can be entered as scalar values or as
% vectors of test values. If one input parameter is a vector, all other
% inputs must be either a vector of the same length or a scalar (the scalar
% will be treated as a constant vector of the appropriate length). If a
% test fails the results of the offending test will be saved to file as a
% csv and the script aborted.
%
%INPUTS:
%   S_maj:    Major (horizontal) ellipse axis measured from center to axis
%             crossing of test ellipse.[Row Vector or scalar]
%   S_min:    Minor (vertical) ellipse axis measured from center to axis
%             crossing of test ellipse.[Row Vector or scalar]
%   theta:    Ellipse heading (i.e. tilt) measured clockwise from vertical
%   p0:       Ellipse center. [2xN matrix]
%   save:     Optional boolean if user wants results saved to csv. Default
%             is false.
%   filename: Optional string for saved filename. If save boolean is
%             true and filename is not specified, default is
%             'conversionTest.csv'
%
%OUTPUTS:
%   result_CGP: Cell containing results of CGP testing [Cell]
%   result_QMC: Cell containing results of QMC testing [Cell]
%   result_AXC: Cell containing results of AXC testing [Cell]
%
%% Parse Inputs
if nargin == 4
    save = false;
    filename = 'conversionTest.csv';
elseif nargin == 5
    filename = 'conversionTest.csv';
end
if strfind(filename,'.')
    p = strfind(filename,'.');
else
    p = length(filename)+1;
end
if size(p0,1)~=2
    p0=p0';
end
if ~isscalar(S_maj)
    if isscalar(S_min)
        S_min = S_min*ones(size(S_maj));
    end
    if isscalar(theta)
        theta = theta*ones(size(S_maj));
    end
    if size(p0,2) == 1
        p(1,:) = p0(1)*ones(size(S_maj));
        p(2,:) = p0(2)*ones(size(S_maj));
        p0 = p;clear p
    end
end
if ~isscalar(S_min)
    if isscalar(S_maj)
        S_maj = S_maj*ones(size(S_min));
    end
    if isscalar(theta)
        theta = theta*ones(size(S_min));
    end
    if size(p0,2) == 1
        pp(1,:) = p0(1)*ones(size(S_min));
        pp(2,:) = p0(2)*ones(size(S_min));
        p0 = pp;clear pp
    end
end
if ~isscalar(theta)
    if isscalar(S_maj)
        S_maj = S_maj*ones(size(theta));
    end
    if isscalar(S_min)
        S_min = S_min*ones(size(theta));
    end
    if size(p0,2) == 1
        p(1,:) = p0(1)*ones(size(theta));
        p(2,:) = p0(2)*ones(size(theta));
        p0 = p;clear p
    end
end
if size(p0,2)>1
    if isscalar(S_maj)
        S_maj = S_maj*ones(size(p0,2));
    end
    if isscalar(S_min)
        S_min = S_min*ones(size(p0,2));
    end
    if isscalar(theta)
        theta = theta*ones(size(p0,2));
    end
end
if length(S_maj)~=length(S_min) || length(S_maj)~=length(theta) || ...
   length(S_maj)~=length(S_min) || length(S_maj)~=length(p0(1,:)) || ...
   length(S_min)~=length(theta) || length(S_min)~=length(p0(1,:)) || ...
   length(theta)~=length(p0(1,:));
    error('Length of inputs vectors must be the same')
end

%% Perform Comparison
result_CGP = {};
result_QMC = {};
result_AXC = {};
for i = 1:length(S_maj)
    clc
    fprintf('S_maj = %d\n',S_maj(i))
    fprintf('S_min = %d\n',S_min(i))
    fprintf('theta = %.3f\n',theta(i))
    fprintf('p0 = %d\n',p0(:,i))
    
    [result_CGP,f_cgp] = testCGP(S_maj(i),S_min(i),theta(i),p0(:,i),result_CGP);
    
    R = cgp2qmc(S_maj(i),S_min(i),theta(i),p0(:,i));
    [result_QMC,f_qmc] = testQMC(R,p0(:,i),result_QMC);
    
    [A,bb] = cgp2axc(S_maj(i),S_min(i),theta(i),p0(:,i));
    [result_AXC,f_axc] = testAXC(A,bb,result_AXC);
    
    if ~f_cgp
        f = result_CGP([1 end-(4:-1:0)],:);
        f_str = [filename(1:(p-1)) '_cgp.csv'];
        cell2csv(f_str,f);
    end
    if ~f_qmc
        f = result_QMC([1 end-(3:-1:0)],:);
        f_str = [filename(1:(p-1)) '_qmc.csv'];
        cell2csv(f_str,f);
    end
    if ~f_axc
        f = result_AXC([1 end-(3:-1:0)],:);
        f_str = [filename(1:(p-1)) '_axc.csv'];
        cell2csv(f_str,f);
    end
    if ~f_cgp
        error('Failure in CGP. Results of failed test have been saved as csv.')
    end
    if ~f_qmc
        error('Failure in QMC. Results of failed test have been saved as csv.')
    end
    if ~f_axc
        error('Failure in AXC. Results of failed test have been saved as csv.')
    end
end

if save
    fprintf('\nSaving...')
    f_cgp = [filename(1:(p-1)) '_cgp.csv'];
    f_axc = [filename(1:(p-1)) '_axc.csv'];
    f_qmc = [filename(1:(p-1)) '_qmc.csv'];
    cell2csv(f_cgp,result_CGP);
    cell2csv(f_axc,result_AXC);
    cell2csv(f_qmc,result_QMC);
    fprintf('complete.\n')
end