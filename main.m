close all
clear
clc
commandwindow

%% Enter User Inputs
N = 50;
mu = 30;
sigma = 8;
obj = 'log';
fig = true;

%% Generate random set of points
pp = normrnd(mu,sigma,N,2);

%% Find Minimum Area Ellipse
xx = findMinEllip(pp,obj,fig);