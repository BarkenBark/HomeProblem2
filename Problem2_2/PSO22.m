% Particle swarm optimization

%clc; clear all

nbrOfParticles = 30;
nbrOfIterations = 100;
alpha = 1;
deltaT = 1;
c_1 = 2;
c_2 = 2;
variableRange = [-5, 5]; 
maxVelocity = (variableRange(2) - variableRange(1))/deltaT;
inertiaWeight = 1.4;
inertiaWeightDecay = 0.97;
minInertiaWeight = 0.35;

nbrOfVariables = 2;

bestDefinitions = {'Current swarm', 'All swarms'};
bestDefinition = bestDefinitions{2};


%% Optimization
swarm = InitializeSwarm(nbrOfParticles, nbrOfVariables, variableRange, ...
  alpha, deltaT);

for iIteration = 1:nbrOfIterations
    
  [functionValue, functionBestValue] = EvaluateParticles(swarm);

  swarm = UpdateBestPositions(swarm, functionValue, functionBestValue);
  swarmBestPosition = GetSwarmBestPosition(swarm, functionValue, ...
    functionBestValue, bestDefinition);

  swarm = UpdateParticleStates(swarm, swarmBestPosition, c_1, c_2, ...
    inertiaWeight, deltaT, maxVelocity);
  
  if inertiaWeight >= minInertiaWeight
    inertiaWeight = inertiaWeight*inertiaWeightDecay;
  end
  
end

%Final evaluation
[functionValue, functionBestValue] = EvaluateParticles(swarm);
swarmBestPosition = GetSwarmBestPosition(swarm, functionValue, ...
  functionBestValue, bestDefinition);
minimum = ObjectiveFunction(swarmBestPosition);

fprintf('Minimum f(x,y)=%.6f found at (x,y)=(%.6f,%.6f).\n', minimum, swarmBestPosition);
