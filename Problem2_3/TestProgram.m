%% TestProgram

bestNetwork = load('bestNetwork.mat');
bestNetwork = bestNetwork.bestNet;

iSlope = 1;
iDataSet = 2;

[fitness, state] = EvaluateIndividual(bestNetwork, iSlope, iDataSet);

fprintf(strcat('Fitness score for best network achieved, evaluated on slope %d of dataset %d:\n '), iSlope, iDataSet)
fprintf('F = %.2f', fitness);

