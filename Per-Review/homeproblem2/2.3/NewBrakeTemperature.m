function [ breakTemperature ] = NewBreakTemperature( temperature, deltaT, pedalPressure )
% Function to calculate actual break temperature
TEMPERATURE_AMBIENT = 283; % K
TAU = 30; % K
CONSTANT_H = 40; % K/s

deltaTemperature = temperature - TEMPERATURE_AMBIENT;

if pedalPressure < 0.01
  deltaTemperature = -deltaTemperature/TAU*deltaT;
else
  deltaTemperature = CONSTANT_H*pedalPressure*deltaT;
end

breakTemperature = deltaTemperature + temperature;

if breakTemperature <=  TEMPERATURE_AMBIENT
  breakTemperature = TEMPERATURE_AMBIENT;
end

end

