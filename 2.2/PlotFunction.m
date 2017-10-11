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
set(gca, 'FontSize', 12)
title('Contour plot of $f(x,y)$', 'FontSize', 18, 'Interpreter', 'Latex')
xlabel('$x$', 'FontSize', 18, 'Interpreter', 'Latex')
ylabel('$y$', 'FontSize', 18, 'Interpreter', 'Latex')

minima(1,:) = [3.000022, 2.000015];
minima(2,:) = [3.584428, -1.848127];
minima(3,:) = [-3.779308, -3.283193];
minima(4,:) = [-2.805118, 3.131313];

hold on
scatter(minima(:,1), minima(:,2), 180, 'x', 'LineWidth', 3, 'MarkerEdgeColor', 'black')
text(minima(1,1) - 1, minima(1,2) + 0.5, '(3.00,2.00)', 'FontSize', 18, 'Interpreter', 'Latex') 
text(minima(2,1)-1, minima(2,2)+0.5, '(3.58, -1.85)', 'FontSize', 18, 'Interpreter', 'Latex') 
text(minima(3,1)-1, minima(3,2)+0.5, '(-3.78, -3.28)', 'FontSize', 18, 'Interpreter', 'Latex') 
text(minima(4,1)-1, minima(4,2)+0.5, '(-2.81, 3.13)', 'FontSize', 18, 'Interpreter', 'Latex') 