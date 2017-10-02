function population = InitializePopulation(populationSize, networkDimensions, weightInterval, thresholdInterval)
%InitializePopulation Initialize a population of chromosomes encoding a
%network of dimensions specified by networkDimensions

  minWeight = weightInterval(1);
  maxWeight = weightInterval(2);
  minThreshold = thresholdInterval(1);
  maxThreshold = thresholdInterval(2);

  nbrOfLayers = length(networkDimensions);
  nbrOfWeights = 0;
  nbrOfThresholds = 0;
  for i = 1:nbrOfLayers-1
    nbrOfLayerWeights = networkDimensions(i)*networkDimensions(i+1);
    nbrOfWeights = nbrOfWeights + nbrOfLayerWeights;
    nbrOfLayerThresholds = networkDimensions(i+1);
    nbrOfThresholds = nbrOfThresholds + nbrOfLayerThresholds;
  end
  
  chromosomeLength = nbrOfWeights+nbrOfThresholds;
  population = zeros(populationSize, chromosomeLength);

  for i = 1:populationSize
    chromosome = zeros(1, chromosomeLength);
    for j = 1:nbrOfWeights
      chromosome(j) = minWeight + rand*(maxWeight-minWeight);
    end
    for j = nbrOfWeights+1:chromosomeLength
      chromosome(j) = minThreshold + rand*(maxThreshold-minThreshold);
    end
  end

end

