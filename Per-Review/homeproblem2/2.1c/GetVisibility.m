function visibility = GetVisibility( cityLocation )
%Creates matrix of visibilty from one city to another
numberOfCities=size(cityLocation,1);
eta = zeros(numberOfCities,numberOfCities);

for i=1:numberOfCities
  for j=1:numberOfCities
    if i == j
      eta(i,j) = 0;
    else
      deltaX = cityLocation(i,1)- cityLocation(j,1);
      deltaY = cityLocation(i,2) - cityLocation(j,2);
      eta(i,j) = 1/sqrt(deltaX^2+deltaY^2);
    end
  end
end
visibility = eta;

end

