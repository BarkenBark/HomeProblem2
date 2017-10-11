%% NNPathLengthCalculator
clc; clear all

cityLocation = LoadCityLocations;
pathLength = GetNearestNeighbourPathLength(cityLocation);

fprintf('A nearest neighbor path length is %.2f.\n', pathLength)