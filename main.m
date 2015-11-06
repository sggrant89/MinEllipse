close all
clear
clc
commandwindow

%% Enter User Inputs
N = 50;
x_mu = 7;
y_mu = 10;
x_sigma = 50;
y_sigma = 26;
theta = pi/4;
rep = 'axc';
obj = 'log';
fig = true;
iterHistory = false;

%% Generate random set of points
D = [ x_sigma^2 ,     0     ;...
          0     , y_sigma^2];
U = [cos(theta),-sin(theta);...
     sin(theta), cos(theta)];
sigma = U*D*U';
          
pp = mvnrnd([x_mu;y_mu],sigma,N);

%% Find Minimum Area Ellipse
[xx,fval,exitflag,output,xx0] = findMinEllip(pp,rep,obj,fig,iterHistory);