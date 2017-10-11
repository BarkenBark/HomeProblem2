function [nbrOfWeights, nbrOfThresholds] = GetNbrOfWeightsAndThresholds(networkDimensions)

  nbrOfLayers = length(networkDimensions);
  nbrOfWeights = 0;
  nbrOfThresholds = 0;
  for i = 1:nbrOfLayers-1
    nbrOfLayerWeights = networkDimensions(i)*networkDimensions(i+1);
    nbrOfWeights = nbrOfWeights + nbrOfLayerWeights;
    nbrOfLayerThresholds = networkDimensions(i+1);
    nbrOfThresholds = nbrOfThresholds + nbrOfLayerThresholds;
  end

end

