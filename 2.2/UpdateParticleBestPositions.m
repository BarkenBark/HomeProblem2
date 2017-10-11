function updatedSwarm = UpdateParticleBestPositions(swarm, functionValue, functionBestValue)

  nbrOfParticles = length(swarm);
  
  updatedSwarm = swarm;
  for iParticle = 1:nbrOfParticles
    particle = swarm(iParticle);
    position = particle.Position;
    if functionValue(iParticle) < functionBestValue(iParticle)
      particle.BestPosition = position;
    end
    updatedSwarm(iParticle) = particle;
  end

end

