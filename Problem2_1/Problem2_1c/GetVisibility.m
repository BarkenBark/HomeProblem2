function visibility = GetVisibility(cityLocation)

  numberOfCities = length(cityLocation);
  visibility = zeros(numberOfCities);
  
  for i = 1:numberOfCities
    for j = 1:numberOfCities
      if i ~= j
        distance = norm(cityLocation(i,:)-cityLocation(j,:));
        visibility(i,j) = 1/distance;
      end
    end
  end

end

