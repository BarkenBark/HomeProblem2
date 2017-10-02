function [functionValue, functionBestValue] = EvaluateParticles(swarm)

  nbrOfParticles = length(swarm);

  functionValue = zeros(nbrOfParticles, 1);
  functionBestValue = zeros(nbrOfParticles, 1);
  for iParticle = 1:nbrOfParticles
    particle = swarm(iParticle);
    position = particle.Position;
    bestPosition = particle.BestPosition;
    functionValue(iParticle) = f(position);
    functionBestValue(iParticle) = f(bestPosition);   
  end

end

