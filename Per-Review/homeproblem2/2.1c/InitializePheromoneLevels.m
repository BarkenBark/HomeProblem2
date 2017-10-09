function [ pheromoneLevel ] = InitializePheromoneLevels( numberOfCities, tau0 )

pheromoneLevel = zeros(numberOfCities, numberOfCities);
pheromoneLevel(:,:) = tau0;

end