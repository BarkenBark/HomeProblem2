clear all;
clc;
clf;

format long
minRange = -5;
maxRange = 5;
cCognitive = 2;
cSocial = 2;
minVelocity = -5;
maxVelocity = 5;
numberOfParticles = 40;
numberOfDimensions = 2;
numberOfGenerations = 1000;
numberOfIndependentRuns = 20;
weight = 1.4;

% Plotting the function in the interval -5 to 5 for both x and y
PlotContour(minRange,maxRange)
hold on

xPositions = InitializePositions(numberOfParticles, minRange, maxRange, numberOfDimensions);
velocity = InitializeVelocities(numberOfParticles, minRange, maxRange, numberOfDimensions);
functionValues = zeros(1, numberOfParticles);
AllRunsBestParticlePositions = zeros(numberOfIndependentRuns,2);
AllRunsBestFunctionValue = zeros(numberOfIndependentRuns,1);

for o=1:numberOfIndependentRuns
  xBestParticle= [0 0];
  
  minFunctionValue = realmax; % Initializing bad value
  bestSwarm = realmax; % Initializing bad value;
  
  xPositions = InitializePositions(numberOfParticles, minRange, maxRange, numberOfDimensions);
  velocity = InitializeVelocities(numberOfParticles, minRange, maxRange, numberOfDimensions);
  functionValues = zeros(1, numberOfParticles);
  for k = 1:numberOfGenerations
    for i = 1:numberOfParticles
      particle = xPositions(i,:);
      functionValue(i) = EvaluateParticles(particle);
      if functionValue(i) < minFunctionValue
        minFunctionValue = functionValue(i);
        xBestParticle = particle;
      end
    end
    if sum(functionValue) < bestSwarm
      bestSwarm = sum(functionValue);
      bestSwarmPositions = xPositions;
    end
    weight = weight*0.99;
    if weight < 0.35
      weight = 0.35;
    end
    velocity = UpdateVelocities(velocity, xPositions, xBestParticle, ...
      bestSwarmPositions, minVelocity, maxVelocity, weight );
    
    xPositions = UpdatePositions(xPositions, velocity);
  end
  AllRunsBestParticlePositions(o,:) = xBestParticle;
  AllRunsBestFunctionValue(o,1) = minFunctionValue;
end
plot(AllRunsBestParticlePositions(:,1), AllRunsBestParticlePositions(:,2), '*r')
