function network = DecodeChromosome(chromosome, networkDimensions, weightInterval, thresholdInterval)
%DecodeChromosome Return the neural network encoded by chromosome

  minWeight = weightInterval(1);
  maxWeight = weightInterval(2);
  minThreshold = thresholdInterval(1);
  maxThreshold = thresholdInterval(2);

  nbrOfLayers = length(networkDimensions);
  weights = cell(1, nbrOfLayers-1);
  thresholds = cell(1, nbrOfLayers-1);
  
  [nbrOfWeights, nbrOfThresholds] = GetNbrOfWeightsAndThresholds(networkDimensions);
  weightElements = zeros(1, nbrOfWeights);
  thresholdElements = zeros(1, nbrOfThresholds);
  
  for j = 1:nbrOfWeights
    weightElements(j) = ...
      minWeight + (maxWeight-minWeight)*chromosome(j);
  end
  for j = 1:nbrOfThresholds
    thresholdElements(j) = ...
      minThreshold + (maxThreshold-minThreshold)*chromosome(nbrOfWeights+j);
  end
  
  for iLayer = 1:nbrOfLayers-1
    nbrOfInputNeurons = networkDimensions(iLayer);
    nbrOfOutputNeurons = networkDimensions(iLayer+1);
    
    layerWeightElements = weightElements(1:nbrOfInputNeurons*nbrOfOutputNeurons);
    weights{iLayer} = reshape(layerWeightElements, nbrOfOutputNeurons, nbrOfInputNeurons); 
    weightElements(1:nbrOfInputNeurons*nbrOfOutputNeurons) = [];
    
    layerThresholdElements = thresholdElements(1:nbrOfOutputNeurons);
    thresholds{iLayer} = reshape(layerThresholdElements, nbrOfOutputNeurons, 1);
    thresholdElements(1:nbrOfOutputNeurons) = [];
  end
    
  network = FeedForwardNetwork(networkDimensions);
  network.SetWeights(weights, thresholds)

end

