function f = EvaluateIndividualPlot(weights1, weights2, bias1, bias2, iSlope, iDataSet)
% Same function as EvaluateIndividual but with vectors that saves data so
% it can plot the 5 subplots asked for.

% Non-changable constants.
TEMPERATURE_MAX = 750; % K
ALPHA_MAX = 10; % degrees
CONSTANT_BRAKE = 3000;

MASS_OF_TRUCK = 20000; % kg
TEMPERATURE_START = 500; % K

VELOCITY_MAX = 25; % m/s
VELOCITY_MIN = 1; % m/s
VELOCITY_START = 20; % m/s
ACCELERATION_GRAVITY = 9.82; % m/s/s

GEAR_FORCE = [7.0 5.0 4.0 3.0 2.5 2.0 1.6 1.4 1.2 1]*CONSTANT_BRAKE;
deltaT = 0.1; % Discrete time step

% Initialisation
gear = 7;
distance = 0;
velocity = VELOCITY_START;
brakeTemperature = TEMPERATURE_START;
gearRestriction = 0;

iIteration = 0;

while distance < 1000 % meter
  iIteration = iIteration+1;
  alpha = GetSlopeAngle(distance, iSlope, iDataSet);
  alphaVector(iIteration) = alpha;
  velocityVector(iIteration) = velocity;
  distanceVector(iIteration) = distance;
  gearVector(iIteration) = gear;
  velocityInput = velocity/VELOCITY_MAX;
  alphaInput = alpha/ALPHA_MAX;
  temperatureInput = brakeTemperature/TEMPERATURE_MAX;
  
  [pedalPressure, desiredGearChange] = ...
    FFNN(velocityInput, alphaInput,temperatureInput, weights1, weights2, bias1, bias2 );
  brakeTemperatureVector(iIteration) = brakeTemperature;
  pedalPressureVector(iIteration) = pedalPressure;
  brakeTemperature = NewBrakeTemperature( brakeTemperature, deltaT, pedalPressure );
  if brakeTemperature >= TEMPERATURE_MAX
    f = mean(velocityVector)*distance;
    break;
  end
  
  
  [gear, gearRestriction] = ChangeGear( desiredGearChange, gear, gearRestriction);
  gearRestriction = gearRestriction - deltaT;
  
  
  % Caulculating the three forces
  
  if brakeTemperature < (TEMPERATURE_MAX-100)
    brakeForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY/20*pedalPressure;
  else
    ePower = -(brakeTemperature-(TEMPERATURE_MAX-100))/100;
    expTerm = exp(ePower);
    brakeForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY/20*pedalPressure*expTerm;
  end
  engineBrakeForce  = GEAR_FORCE(gear);
  gravityForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY*sind(alpha);
  
  acceleration = (gravityForce-brakeForce-engineBrakeForce)/MASS_OF_TRUCK;
  
  distance = distance + velocity*deltaT*cosd(alpha);
  
  if velocity > 25
    f = mean(velocityVector)*distance;
    break;
  end
  if velocity < 1
    f = mean(velocityVector)*distance;
    break;
  end
  velocity = velocity + acceleration*deltaT;
  f = mean(velocityVector)*distance;
  
end
disp('Distance travelled')
disp(distance)

subplot(5,1,1), plot(distanceVector(:), alphaVector(:))
title('slope [degrees]')
subplot(5,1,2), plot(distanceVector(:), pedalPressureVector(:))
title('Pedal pressure')
subplot(5,1,3), plot(distanceVector(:), gearVector(:))
title('Gear')
subplot(5,1,4), plot(distanceVector(:), velocityVector(:))
title('Velocity')
subplot(5,1,5), plot(distanceVector(:), brakeTemperatureVector(:))
title('Break temperature')
