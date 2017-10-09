function PlotContour( minRange, maxRange )

x = linspace(minRange,maxRange,1000);
y = linspace(minRange, maxRange,1000);
[X,Y] = meshgrid(x,y);
Z = log(0.01+(X.^2+Y-11).^2+(X+Y.^2-7).^2);
figure(1)
contour(X,Y,Z)

end

