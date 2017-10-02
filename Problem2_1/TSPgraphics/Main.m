cityLocation = LoadCityLocations;
nCities = size(cityLocation,1);
path = bestIndividual;
%path = randperm(nCities); %Random example path          
tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]); 
connection = InitializeConnections(cityLocation); 
PlotPath(connection,cityLocation,path);     