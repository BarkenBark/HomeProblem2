%% Plot log(a+f(x,y))

clc; clf;
clear all;

f = @(x1, x2) (x1.^2 + x2 - 11).^2 + (x1 + x2.^2 -7).^2;
a=0.01;
loggedFunction = @(x1, x2) log(a + f(x1, x2));

resolution = 100;
X1 = linspace(-5,5,resolution);
X2 = linspace(-5,5,resolution);
[X1, X2] = meshgrid(X1, X2);

F = loggedFunction(X1, X2);
contour(X1, X2, F)