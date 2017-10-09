function [ pedalPressure, desiredGearChange] = ...
  FFNN(velocity, alpha, temperature, weights1, weights2, bias1, bias2 )
% The forward feeding neural network
% output(1) = pedalPressure; output(2) = desired gear change
input = [ velocity; alpha; temperature];

stateOfNeurons = sigmf((weights1*input-bias1),[1 0]); %[4x3]*[3x1] = 4x1 matrix
output = sigmf((weights2*stateOfNeurons - bias2), [1 0]); %[2x4]*[4x1] = 2x1 matrix

pedalPressure = output(1);
desiredGearChange = output(2);

end

