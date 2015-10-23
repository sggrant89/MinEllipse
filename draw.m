function draw(xx0,xx,pp)
%% Read Me
% draw(xx0,xx,pp) creates a figure of the initial ellipse, minimum area
% ellipse and the set of points to be contained by the ellipses.

%% Map Initial Ellipse Parameters
A(1,1) = xx0(1);
A(2,2) = xx0(2);
A(1,2) = xx0(3);
A(2,1) = xx0(3);
bb(1,1) = xx0(4);
bb(2,1) = xx0(5);

%% Draw Initial Ellipse
axc2epb(A,bb,1000,true);
lims = axis;

%% Map Minimum Area Ellipse Parameters
hold on

A(1,1) = xx(1);
A(2,2) = xx(2);
A(1,2) = xx(3);
A(2,1) = xx(3);
bb(1,1) = xx(4);
bb(2,1) = xx(5);

%% Draw Minimum Area Ellipse
axc2epb(A,bb,1000,true);

%% Plot Points
scatter(pp(:,1),pp(:,2));
hold off

axis(lims)
