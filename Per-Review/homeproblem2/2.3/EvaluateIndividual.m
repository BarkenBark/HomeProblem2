function f = EvaluateIndividual(weights1, weights2, bias1, bias2, iSlope, iDataSet)

% Non-changable constants.
TEMPERATURE_MAX = 750; % K
ALPHA_MAX = 10; % degrees
CONSTANT_BREAK = 3000;

MASS_OF_TRUCK = 20000; % kg
TEMPERATURE_START = 500; % K

VELOCITY_MAX = 25; % m/s
VELOCITY_MIN = 1; % m/s
VELOCITY_START = 20; % m/s
ACCELERATION_GRAVITY = 9.82; % m/s/s

GEAR_FORCE = [7.0 5.0 4.0 3.0 2.5 2.0 1.6 1.4 1.2 1]*CONSTANT_BREAK;

deltaTime = 0.1; % Discrete time step

% Initialisation
gear = 7;
distance = 0;
velocity = VELOCITY_START;
breakTemperature = TEMPERATURE_START;
gearRestriction = 0;

iIteration = 0;

while distance < 1000 % meter
  iIteration = iIteration+1;
  velocityVector(iIteration) = velocity;
  alpha = GetSlopeAngle(distance, iSlope, iDataSet);
  velocityInput = velocity/VELOCITY_MAX;
  alphaInput = alpha/ALPHA_MAX;
  temperatureInput = breakTemperature/TEMPERATURE_MAX;
  
  [pedalPressure, desiredGearChange] = ...
    FFNN(velocityInput, alphaInput,temperatureInput, weights1, weights2, bias1, bias2 );
  breakTemperatureVector(iIteration) = breakTemperature;
  pedalPressureVector(iIteration) = pedalPressure;
  breakTemperature = NewBrakeTemperature( breakTemperature, deltaTime, pedalPressure );
  if breakTemperature >= TEMPERATURE_MAX
    f = mean(velocityVector)*distance;
    break;
  end
  
  
  [gear, gearRestriction] = ChangeGear( desiredGearChange, gear, gearRestriction);
  gearRestriction = gearRestriction - deltaTime;
  
  % Caulculating the three forces
  
  if breakTemperature < (TEMPERATURE_MAX-100)
    breakForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY/20*pedalPressure;
  else
    ePower = -(breakTemperature-(TEMPERATURE_MAX-100))/100;
    expTerm = exp(ePower);
    breakForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY/20*pedalPressure*expTerm;
  end
  engineBreakForce  = GEAR_FORCE(gear);
  gravityForce = MASS_OF_TRUCK*ACCELERATION_GRAVITY*sind(alpha);
  
  acceleration = (gravityForce-breakForce-engineBreakForce)/MASS_OF_TRUCK;
  distance = distance + velocity*deltaTime*cosd(alpha); % cos(alppha) due to horizontal distance
  
  if velocity > 25
    f = mean(velocityVector)*distance*0.9; % pentaly if it violates constraint.
    break;
  end
  if velocity < 1
    f = mean(velocityVector)*distance;
    break;
  end
  velocity = velocity + acceleration*deltaTime;
  f = mean(velocityVector)*distance;
  
end

