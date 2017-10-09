% TestFit, hard-coded function attined from FunctionOptimization.m
clf;
clear all;
clc;
functionData = LoadFunctionData;
functionValue = zeros(length(functionData),1);
for i = 1:length(functionData)
  x = functionData(i,1);
  functionNumerator = x^3 - x^2 + 1;
  functionDenominator = x^4 - x^2 + 1;
  functionValue(i) = functionNumerator/functionDenominator;
  
  difference = functionValue(i,1)-functionData(i,2);
end

errorRMS = mean(difference);

plot(functionData(:,1), functionValue(:,1), 'r*')
hold on
plot(functionData(:,1), functionData(:,2), 'ob')
title('Function values of found plynomial and given data')
legend('Function value of polynomial found by LGP', 'Function value from given data')
disp(sprintf('Root mean square error: %d, ',errorRMS));
