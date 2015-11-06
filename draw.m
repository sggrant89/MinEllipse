function draw(xx0,xx,pp,rep)
%% Read Me
% draw(xx0,xx,pp) creates a figure of the initial ellipse, minimum area
% ellipse and the set of points to be contained by the ellipses.

%% Map Initial Ellipse Parameters
if strcmp(rep,'axc')
    A(1,1) = xx0(1);
    A(2,2) = xx0(2);
    A(1,2) = xx0(3);
    A(2,1) = xx0(3);
    bb(1,1) = xx0(4);
    bb(2,1) = xx0(5);
elseif strcmp(rep,'ncp')
    xx0(6) = ((xx0(1)*xx0(5)^2 + xx0(2)*xx0(4)^2 - 2*xx0(3)*xx0(4)*xx0(5))/(4*(xx0(1)*xx0(2)-xx0(3)^2)))-1;
end
%% Draw Initial Ellipse
if strcmp(rep,'axc')
    axc2epb(A,bb,1000,true);
elseif strcmp(rep,'ncp')
    ncp2epb(xx0,1000,true);
end
lims = axis;

%% Map Minimum Area Ellipse Parameters
hold on

if strcmp(rep,'axc')
    A(1,1) = xx(1);
    A(2,2) = xx(2);
    A(1,2) = xx(3);
    A(2,1) = xx(3);
    bb(1,1) = xx(4);
    bb(2,1) = xx(5);
elseif strcmp(rep,'ncp')
    xx(6) = ((xx(1)*xx(5)^2 + xx(2)*xx(4)^2 - 2*xx(3)*xx(4)*xx(5))/(4*(xx(1)*xx(2)-xx(3)^2)))-1;
end

%% Draw Minimum Area Ellipse
if strcmp(rep,'axc')
    axc2epb(A,bb,1000,true);
elseif strcmp(rep,'ncp')
    ncp2epb(xx,1000,true);
end

%% Plot Points
scatter(pp(:,1),pp(:,2));
hold off

axis(lims)
