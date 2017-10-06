classdef FeedForwardNetwork < handle
  
  properties
    weights; %Cell vector of weight matrices
    thresholds; %Cell vector of threshold vectors
    networkDimensions;
    nbrOfLayers;
    activationConstant = 1; %Constant in logistic sigmoid activation function
  end
  
  methods
    function obj = FeedForwardNetwork(networkDimensions)
      obj.networkDimensions = networkDimensions;
      obj.nbrOfLayers = length(networkDimensions);
      obj.weights = cell(1, obj.nbrOfLayers-1);
      obj.thresholds = cell(1, obj.nbrOfLayers-1);
    end
        
    function SetWeights(obj, weights, thresholds)
      obj.weights = weights;
      obj.thresholds = thresholds;
    end
    
    function RandomlyInitializeWeights(obj, weightInterval, thresholdInterval) %To be removed
      for iLayer = 1:obj.nbrOfLayers-1
        weightDimension = [obj.networkDimensions(iLayer+1), ...
          obj.networkDimensions(iLayer)];
        thresholdDimension = [obj.networkDimensions(iLayer+1), 1];
        
        minWeight = weightInterval(1);
        maxWeight = weightInterval(2);
        tmp = rand(weightDimension);
        tmpWeights = minWeight + (maxWeight-minWeight).*tmp;
        
        minThreshold = thresholdInterval(1);
        maxThreshold = thresholdInterval(2);
        tmp = rand(thresholdDimension);
        tmpThresholds = minThreshold + (maxThreshold-minThreshold).*tmp;
        
        obj.weights{iLayer} = tmpWeights;
        obj.thresholds{iLayer} = tmpThresholds;
      end
    end
    
    function output = ForwardPropagate(obj, input)
      output = input;
      for iLayer = 1:obj.nbrOfLayers-1
        s = obj.weights{iLayer}*output - obj.thresholds{iLayer};
        output = obj.ActivationFunction(s);
      end
    end
    
    function value = ActivationFunction(obj, s)
      value = 1./(1+exp(-obj.activationConstant*s));
    end
  end
  
end

