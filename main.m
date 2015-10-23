close all
clear
clc
commandwindow

%% Enter User Inputs
N = 80;
x_mu = 7;
y_mu = 10;
x_sigma = 30;
y_sigma = 26;
obj = 'log';
fig = true;
iterHistory = true;

%% Generate random set of points
pp(:,1) = normrnd(x_mu,x_sigma,N,1);
pp(:,2) = normrnd(y_mu,y_sigma,N,1);

%% Find Minimum Area Ellipse
[xx,fval,exitflag,output,xx0] = findMinEllip(pp,obj,fig,iterHistory);


%% Create GIF of Iterations
if iterHistory
    load('iterHistory.mat')
    drawIterHistory(xx0,h,pp,'test.gif')
end