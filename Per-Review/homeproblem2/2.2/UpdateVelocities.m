function velocity = UpdateVelocities(velocity, xPositions, xBestParticle, ...
  bestSwarm, minVelocity, maxVelocity, weight )
numberOfParticles = length(xPositions);
numberOfDimensions = size(xPositions,2);
cCognitive = 2;
cSocial = 2;

for i = 1:numberOfParticles
  r = rand;
  q = rand;
  for j = 1:numberOfDimensions
    cognitiveUpdate = cCognitive*q*(xBestParticle(1,j)-xPositions(i,j));
    socialUpdate = cSocial*r*(bestSwarm(i,j)-xPositions(i,j));
    newVelocity(i,j) = weight*velocity(i,j) + cognitiveUpdate + socialUpdate;
    if newVelocity(i,j) < minVelocity
      newVelocity(i,j) = minVelocity;
    elseif newVelocity(i,j) > maxVelocity
      newVelocity(i,j) = maxVelocity;
    else
      continue
    end
    
  end
end
velocity = newVelocity;
end

