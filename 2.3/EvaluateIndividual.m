function [fitness, recordedState] = EvaluateIndividual(network, iDataSet, iSlope)
  
  %Dataset settings
  if ~exist('iSlope', 'var')
    if (iDataSet == 1)
      slopes = 1:10;
    elseif (iDataSet == 2 || iDataSet == 3)
      slopes = 1:5;
    end
  else
    slopes = iSlope;
  end

  %Limits
  %Note: Get maxBrakeTemperature from truck properties
  MAX_SPEED = 25;
  MIN_SPEED = 1;
  MAX_SLOPE_ANGLE = 10;
  MIN_SLOPE_ANGLE = 0;
  SLOPE_LENGTH = 1000;

  %Simulation parameters
  TIME_STEP = 0.1;
  predictedNbrOfIterations = 50/TIME_STEP; %To make code slightly faster per MATLAB's recommendation
  
  %Commence evaluation
  slopeFitness = [];
  for iSlope = slopes
    
    %Initial truck state
    position = 0;
    speed = 20;
    brakeTemperature = 500;
    gear = 7;
    brakePressure = 0;
    
    truck = TruckModel(position, speed, brakeTemperature, gear, brakePressure);
    maxBrakeTemperature = truck.MAX_BRAKE_TEMPERATURE;
    
    recordedPosition = zeros(predictedNbrOfIterations, 1);
    recordedSlopeAngle = zeros(predictedNbrOfIterations, 1);
    recordedBrakePressure = zeros(predictedNbrOfIterations, 1);
    recordedGear = zeros(predictedNbrOfIterations, 1);
    recordedSpeed = zeros(predictedNbrOfIterations, 1);
    recordedBrakeTemperature = zeros(predictedNbrOfIterations, 1);
    
    simulationRunning = true;
    iIteration = 0;
    input = zeros(3,1);
    while simulationRunning
      iIteration = iIteration + 1;
      
      slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);
      if slopeAngle < MIN_SLOPE_ANGLE
        error('The slope angle should never be less than %d.', MIN_SLOPE_ANGLE)
      elseif slopeAngle > MAX_SLOPE_ANGLE
        error('The slope angle should never be greater than %d.', MAX_SLOPE_ANGLE)
      end
      
      recordedPosition(iIteration) = position;
      recordedSlopeAngle(iIteration) = slopeAngle;
      recordedBrakePressure(iIteration) = brakePressure;
      recordedGear(iIteration) = gear;
      recordedSpeed(iIteration) = speed;
      recordedBrakeTemperature(iIteration) = brakeTemperature;
      
      input(1) = speed/MAX_SPEED;
      input(2) = slopeAngle/MAX_SLOPE_ANGLE;
      input(3) = brakeTemperature/maxBrakeTemperature;
      
      output = network.ForwardPropagate(input);
      gearChangeRequest = output(1);
      brakePressure = output(2);
      if gearChangeRequest <= 1/3
        truck.ShiftGear('down');
      elseif gearChangeRequest > 2/3
        truck.ShiftGear('up');
      end
      truck.ApplyBrakePressure(brakePressure);

      truck.UpdateDynamics(slopeAngle, TIME_STEP);
      
      [gear, brakePressure] = truck.GetControllables;
      [position, speed, brakeTemperature] = truck.GetDynamics;
      
      isWithinSpeedLimits = (speed <= MAX_SPEED) && (speed >= MIN_SPEED);
      isBelowBrakeTempLimit = (brakeTemperature <= maxBrakeTemperature);
      isSatisfyingConstraints = isWithinSpeedLimits && isBelowBrakeTempLimit;
      isWithinSlope = (position <= SLOPE_LENGTH);
      simulationRunning = isSatisfyingConstraints && isWithinSlope;
    end
    
    if position > SLOPE_LENGTH
      distanceTraveled = SLOPE_LENGTH;
    else
      distanceTraveled = position;
    end
    
    recordedPosition(iIteration+1:end) = [];
    recordedSlopeAngle(iIteration+1:end) = [];
    recordedBrakePressure(iIteration+1:end) = [];
    recordedGear(iIteration+1:end) = [];
    recordedSpeed(iIteration+1:end) = [];
    recordedBrakeTemperature(iIteration+1:end) = [];
    recordedState = [recordedPosition, recordedSlopeAngle, recordedBrakePressure, ...
      recordedGear, recordedSpeed, recordedBrakeTemperature];
    
    averageSpeed = mean(recordedSpeed);
    thisSlopeFitness = averageSpeed*distanceTraveled;
    slopeFitness = [slopeFitness, thisSlopeFitness];
    
  end

  fitness = min(slopeFitness);
  
end
