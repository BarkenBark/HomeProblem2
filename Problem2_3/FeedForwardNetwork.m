classdef FeedForwardNetwork < handle
  
  properties
    weights; %Cell vector of weight matrices
    thresholds; %Cell vector of threshold vectors
    networkDimensions;
    nbrOfLayers;
    
    ACTIVATION_CONSTANT = 1;
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
    
    function output = ForwardPropagate(obj, input)
      output = input;
      for iLayer = 1:obj.nbrOfLayers-1
        s = obj.weights{iLayer}*output - obj.thresholds{iLayer};
        output = obj.ActivationFunction(s);
      end
    end
    
    function value = ActivationFunction(obj, s)
      value = 1./(1+exp(-obj.ACTIVATION_CONSTANT*s));
    end
  end
  
end

