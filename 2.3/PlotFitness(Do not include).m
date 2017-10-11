%% Plot training and validation fitness

clc; clf
clear all

load('Workspace')

%Remove zero-elements
%generations = length(maximumTrainingFitness

hold on
plot(generations, maximumTrainingFitness)
plot(generations, maximumValidationFitness)