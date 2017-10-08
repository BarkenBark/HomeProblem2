%% TestProgram
netToLoad = 'BestNetwork-Oct7-3.mat';
result = load(netToLoad);
bestNetwork = result.BestNetwork;

iDataSet = 1;
iSlope = 2;
SLOPE_LENGTH = 1000;

[fitness, state] = EvaluateIndividual(bestNetwork, iDataSet, iSlope);

%state contains position, slope angle, brake pedal pressure, gear, 
%speed and brake temperature in that order 
for iPlot = 1:5
  subplot(5, 1, iPlot);
  plot(state(:,1), state(:,iPlot+1))
  xlim([0 SLOPE_LENGTH])
end

if iDataSet == 1
  datasetString = 'training set';
elseif iDataSet == 2
  datasetString = 'validation set';
elseif iDataSet == 3
  datasetString = 'test set';
end
fprintf('Fitness score for best network achieved, evaluated on slope %d of %s:\n', iSlope, datasetString)
fprintf('F = %.2f\n', fitness);

% for iDataSet = 1:3
%   hurr(iDataSet) = EvaluateIndividual(bestNetwork, iDataSet);
% end
% fprintf(strcat('Scores of ', netToLoad, ': %.2f, %.2f and %.2f.'), hurr(1), hurr(2), hurr(3))