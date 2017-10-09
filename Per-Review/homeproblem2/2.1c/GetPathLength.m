function pathLength = GetPathLength(path, cityLocation)

numberOfCities = length(path);
pathLength=0;
for i=1:(numberOfCities-1);
  deltaX = (cityLocation(path(i),1)-cityLocation(path(i+1),1));
  deltaY = (cityLocation(path(i),2)-cityLocation(path(i+1),2));
  pathLength = pathLength + sqrt(deltaX^2+deltaY^2);
  
end
%get back to start point
deltaXLast = cityLocation(path(1),1)-cityLocation(path(end),1);
deltaYLast = cityLocation(path(1),2) - cityLocation(path(end),2);
pathLength = pathLength + sqrt(deltaXLast^2+deltaYLast^2);
end

