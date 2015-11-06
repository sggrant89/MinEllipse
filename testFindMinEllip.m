close all
clear
clc
commandwindow

%% Enter User Inputs
N = 50;
x_mu = 5;
y_mu = 10;
maj_sigma = 10;
min_sigma = 5;
d = .01;
rep = {'axc'};
obj = {'log'};
fig = true;
hull = false;
theta = pi/35;
iters = 1;

%% Parse Inputs
if ~isscalar(N)
    if isscalar(x_mu)
        x_mu = x_mu*ones(size(N));
    end
    if isscalar(y_mu)
        y_mu = y_mu*ones(size(N));
    end
    if isscalar(maj_sigma)
        maj_sigma = maj_sigma*ones(size(N));
    end
    if isscalar(min_sigma)
        min_sigma = min_sigma*ones(size(N));
    end
end
if ~isscalar(x_mu)
    if isscalar(N)
        N = N*ones(size(x_mu));
    end
    if isscalar(maj_sigma)
        maj_sigma = maj_sigma*ones(size(x_mu));
    end
    if isscalar(min_sigma)
        min_sigma = min_sigma*ones(size(x_mu));
    end
end
if ~isscalar(y_mu)
    if isscalar(N)
        N = N*ones(size(y_mu));
    end
    if isscalar(maj_sigma)
        maj_sigma = maj_sigma*ones(size(y_mu));
    end
    if isscalar(min_sigma)
        min_sigma = min_sigma*ones(size(y_mu));
    end
end
if ~isscalar(maj_sigma)
    if isscalar(N)
        N = N*ones(size(maj_sigma));
    end
    if isscalar(x_mu)
        x_mu = x_mu*ones(size(maj_sigma));
    end
    if isscalar(y_mu)
        y_mu = y_mu*ones(size(maj_sigma));
    end
    if isscalar(min_sigma)
        min_sigma = min_sigma*ones(size(maj_sigma));
    end
end
if ~isscalar(min_sigma)
    if isscalar(N)
        N = N*ones(size(min_sigma));
    end
    if isscalar(x_mu)
        x_mu = x_mu*ones(size(min_sigma));
    end
    if isscalar(y_mu)
        y_mu = y_mu*ones(size(min_sigma));
    end
    if isscalar(maj_sigma)
        maj_sigma = maj_sigma*ones(size(min_sigma));
    end
end
if length(N)~=length(x_mu) || length(N)~=length(maj_sigma) || ...
   length(N)~=length(y_mu) || length(N)~=length(min_sigma) || ...
   length(x_mu)~=length(maj_sigma) || length(x_mu)~=length(min_sigma) || ...
   length(y_mu)~=length(maj_sigma) || length(y_mu)~=length(min_sigma)
    error('Length of inputs vectors must be the same')
end
D = [ maj_sigma^2 ,     0     ;...
          0     , min_sigma^2];
U = [cos(theta),-sin(theta);...
     sin(theta), cos(theta)];
sigma = U*D*U';
w0 = [x_mu;y_mu];

%% Test Optimization
iter = zeros(length(rep),iters,length(N),length(obj));
if hull
    iter_h = zeros(length(rep),iters,length(N),length(obj));
end
f_axc = 0;
f_ncp = 0;
for l = 1:length(rep)
    for k = 1:iters
        for i = 1:length(N)
            %% Generate random set of points
            if ~d
                pp = mvnrnd(w0,sigma,N);
            else
                pp = mvnrnd(w0,D,N);
                pp(:,2) = abs(pp(:,2)).^d;
                pp = U*[pp(:,1)'; pp(:,2)'];
                pp = (pp + repmat(w0,1,N))';
            end
            if hull
                pp_ch = pp(convhull(pp(:,1),pp(:,2)),:);
            end
            j = 1;
            new_pp = false;
            while j <= length(obj)
                if new_pp
                    if ~d
                        pp = mvnrnd(w0,sigma,N);
                    else
                        pp = mvnrnd(w0,D,N);
                        pp(:,2) = abs(pp(:,2)).^d;
                        pp = U*[pp(:,1)'; pp(:,2)'];
                        pp = (pp + repmat(w0,1,N))';
                    end
                    if hull
                        pp_ch = pp(convhull(pp(:,1),pp(:,2)),:);
                    end
                end
                clc
                fprintf('k = %d of %d\n',k,iters)
                fprintf('N = %d\n',N(i))
                fprintf('x_mu = %d\n',x_mu(i))
                fprintf('y_mu = %d\n',y_mu(i))
                fprintf('x_sigma = %d\n',maj_sigma(i))
                fprintf('y_sigma = %d\n',min_sigma(i))
                fprintf(['rep = ',rep{l},'\n'])
                fprintf(['obj = ',obj{j},'\n'])

                %% Find Minimum Area Ellipse
                [xx,fval,exitflag,output] = findMinEllip(pp,rep{l},obj{j},fig);
                if hull
                    [xx_h,fval_h,exitflag_h,output_h] = findMinEllip(pp_ch,rep{l},obj{j},fig);
                end
                if exitflag == 1
                    fprintf('\nSuccess!\n')
                    iter(l,k,i,j)=output.iterations;
                    if hull
                        iter_h(l,k,i,j)=output_h.iterations;
                    end
                    j = j+1;
                    new_pp = false;
                else
                    if strcmp(rep{l},'axc')
                        f_axc=f_axc+1;
                    elseif strcmp(rep{l},'ncp')
                        f_ncp=f_ncp+1;
                    end
                    new_pp = true;
                end
            end
        end
    end
end
