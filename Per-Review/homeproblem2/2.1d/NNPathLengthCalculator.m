clc;
clear all;

cityLocations = LoadCityLocations;

% Will as in 2.b generate nearest neighbour path length.
nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocations);
