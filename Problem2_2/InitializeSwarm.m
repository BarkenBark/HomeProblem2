function swarm = InitializeSwarm(nbrOfParticles, nbrOfVariables, ...
  positionLimits, alpha, deltaT)

  swarm = [];
  x_min = positionLimits(1);
  x_max = positionLimits(2);
  
  for i = 1:nbrOfParticles
    position = zeros(nbrOfVariables, 1);
    velocity = zeros(nbrOfVariables, 1);
    for j = 1:nbrOfVariables
      position(j) = x_min + rand*(x_max - x_min);
      velocity(j) = alpha/deltaT * (-(x_max-x_min)/2 + rand*(x_max-x_min));
      particle = struct('Position', position, 'Velocity', velocity, ...
        'BestPosition', position);
    end
    swarm = [swarm particle];
  end

end

