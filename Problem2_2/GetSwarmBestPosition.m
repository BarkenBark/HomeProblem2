function swarmBestPosition = GetSwarmBestPosition(swarm, functionValue, functionBestValue, mode)

  nbrOfParticles = length(swarm);
  swarmBestPositionIndex = 1; %Arbitrary initial value
  
  for iParticle = 1:nbrOfParticles
    if strcmp(mode, 'Current swarm')
      if functionValue(iParticle) < functionValue(swarmBestPositionIndex)
        swarmBestPositionIndex = iParticle;
      end 
    elseif strcmp(mode, 'All swarms')
      if functionValue(iParticle) < functionBestValue(swarmBestPositionIndex)
        swarmBestPositionIndex = iParticle;
      end       
    end
  end
  
  swarmBestPosition = swarm(swarmBestPositionIndex).Position;

end

