%% problem parameters

  %Truck properties
  %Encapsulate in LoadTruckProperties.m
  mass = 20000;
  %maxBrakeTemperature = 750; %Not a truck property, but needed in
  %calculations
  ambientBrakeTemperature = 283;
  engineBrakingConstant = 3000;
  gearBrakingFactors = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1];
  minGear = 1;
  maxGear = length(gearBrakingFactors);
  tau = 30;
  Ch = 40;
  
  %Problem limits
  maxSpeed = 25; %Not a truck property
  minSpeed = 1; %Not a truck property
  maxSlopeAngle = 10; %Not a truck property
  maxBrakeTemperature = 750;
  slopeLength = 1000;
  
  %Simulation parameters
  deltaT = 0.05;
  
  
  
  %Initial truck state (dynamics & controllables)
  %Encapsulate in LoadInitialTruckState.m
  position = 0;
  speed = 20;
  brakeTemperature = 500; 
  gear = 7;
  brakePressure = 0.2;

  %Dataset
  iSlope = 1;
  iDataSet = 1;

  %Controller (network) properties
  nbrOfHiddenNeurons = 7;
  networkDimensions = [3, nbrOfHiddenNeurosn, 2];
  weightInterval = [-7, 7];
  thresholdInterval = weightInterval;
  activationConstant = 1;
