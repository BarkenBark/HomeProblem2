%% TestProgram

bestNetwork = load('bestNetwork.mat');
bestNetwork = bestNetwork.bestNet;

iSlope = 1;
iDataSet = 2;

[fitness, state] = EvaluateIndividual(bestNetwork, iSlope, iDataSet);
%state contains position, slope angle, brake pedal pressure, gear, 
%speed and brake temperature in that order 

fprintf('Fitness score for best network achieved, evaluated on slope %d of dataset %d:\n ', iSlope, iDataSet)
fprintf('F = %.2f\n', fitness);

for iPlot = 1:5
  subplot(5, 1, iPlot);
  plot(state(:,1), state(:,iPlot+1))
end

