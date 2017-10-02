function updatedSwarm = UpdateParticleStates(swarm, swarmBestPosition, c_1, c_2, inertiaWeight, deltaT, maxVelocity)

  nbrOfParticles = length(swarm);
  nbrOfVariables = length(swarm(1).Position);

  updatedSwarm = swarm;
  
  for iParticle = 1:nbrOfParticles
    particle = swarm(iParticle);
    position = particle.Position;
    bestPosition = particle.BestPosition;
    velocity = particle.Velocity;
    
    q = rand;
    r = rand;
    for j = 1:nbrOfVariables
      cognitiveComponent = c_1*q*(bestPosition(j)-position(j))/deltaT;
      socialComponent = c_2*r*(swarmBestPosition(j)-position(j))/deltaT;
      velocity(j) = inertiaWeight*velocity(j) + cognitiveComponent + socialComponent;
      if abs(velocity(j)) > maxVelocity
        velocity(j) = sign(velocity(j))*maxVelocity;
      end
    end
    
    for j = 1:nbrOfVariables
      position(j) = position(j) + velocity(j)*deltaT;
    end
    
    particle.Position = position;
    particle.Velocity = velocity;
    updatedSwarm(iParticle) = particle;
  end

end

