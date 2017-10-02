%% Simulate truck
clc
clf
clear all

%Dataset
iSlope = 1;
iDataset = 1;

%Simulation
deltaT = 0.05;

%Conditions
maxBrakingTemperature = 750;

%Initial state
brakeTemperature = 500;
speed = 80;
xPosition = 0;
gear = 7;
brakePressure = 0;

truck = TruckModelB(xPosition, speed, brakeTemperature, gear, brakePressure);
% 
% % Plot hill
% xLength = 4000;
% deltaX = 1;
% X = linspace(0,xLength,xLength/deltaX);
% Hill = zeros(size(X));
% Hill(1) = 4000;
% for i = 1:length(Hill)-1
%   alpha = GetSlopeAngle(X(i), iSlope, iDataset);
%   Hill(i+1) = Hill(i) - deltaX/cosd(alpha); 
% end
% plot(X, Hill);
% hold on
% clear X

%% Simulate truck
hold on
[x, v, T] = truck.GetState;
i = 0;
y = 1000;
plot(x, 1, 'o')
axis([0 1000 0 y])
while T < maxBrakingTemperature
  i = i+1;
  alpha = GetSlopeAngle(x, iSlope, iDataset);
  y = y - sind(alpha)*v*deltaT;
  truck.Iterate(alpha, deltaT);
  [x, v, T] = truck.GetState
  if mod(i,100)==0
      plot(x, 1, 'o');
  drawnow
  pause(0.01)
  end
end