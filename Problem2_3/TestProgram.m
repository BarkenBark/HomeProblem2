%% TestProgram
iDataSet = 3;
iSlope = 1;

netToLoad = 'BestNetwork.mat';
result = load(netToLoad);
bestNetwork = result.BestNetwork;

SLOPE_LENGTH = 1000;
[fitness, state] = EvaluateIndividual(bestNetwork, iDataSet, iSlope);
%state contains position, slope angle, brake pedal pressure, gear, 
%speed and brake temperature in that order 

plotTitle = {'$x$ (m)', '$\alpha$ (${}^o$)', '$P_p$', ...
  'Gear', '$v$ ($\frac{m}{s}$)', '$T_b$ (${}^o$K)'};

for iPlot = 1:5
  subplot(5, 1, iPlot);
  plot(state(:,1), state(:,iPlot+1))
  xlim([0 SLOPE_LENGTH])
  ylabel(plotTitle{iPlot+1}, 'Interpreter', 'latex', 'FontSize', 14)
  if iPlot <=4
    set(gca, 'xticklabel',[])
  end
end
xlabel('Horizontal distance $x$ (m)', 'FontWeight', 'Bold', 'Interpreter', 'latex')

if iDataSet == 1
  datasetString = 'training set';
elseif iDataSet == 2
  datasetString = 'validation set';
elseif iDataSet == 3
  datasetString = 'test set';
end
fprintf('Fitness score for best network achieved, evaluated on slope %d of %s:\n', iSlope, datasetString)
fprintf('F = %.2f\n', fitness);