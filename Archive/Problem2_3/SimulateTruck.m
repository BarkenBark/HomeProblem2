function [fitness, recordedState] = SimulateTruck(network)
%EvaluateIndividual Run the simulation where the truck is controlled by a
%network encoded by chromosome. The fitness score returned is the
%horisontal distance traveled.
  
  %Initial truck state
  position = 0;
  speed = 20;
  brakeTemperature = 500; 
  gear = 7;
  brakePressure = 0;
  
  %Limits
  maxSpeed = 25;
  minSpeed = 1;
  maxSlopeAngle = 10; %Not imposing constraint
  maxBrakeTemperature = 750;
  
  %Simulation parameters
  deltaT = 0.01;
  predictedNbrOfIterations = 6000; %To make code slightly faster per MATLAB's recommendation
  
  %Dataset settings
  iSlope = 1;
  iDataSet = 1;
  slopeLength = 1000;

  truck = TruckModel(position, speed, brakeTemperature, gear, brakePressure);
  
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
    
    recordedPosition(iIteration) = position;
    recordedSlopeAngle(iIteration) = slopeAngle; 
    recordedBrakePressure(iIteration) = brakePressure;  
    recordedGear(iIteration) = gear; 
    recordedSpeed(iIteration) = speed;
    recordedBrakeTemperature(iIteration) = brakeTemperature;   
    
    truck.Iterate(slopeAngle, deltaT);
    [position, speed, brakeTemperature] = truck.GetDynamics;
    
    input(1) = speed/maxSpeed;
    input(2) = slopeAngle/maxSlopeAngle;
    input(3) = brakeTemperature/maxBrakeTemperature;
    
    output = network.ForwardPropagate(input);
    gearChangeRequest = output(1);
    brakePressure = output(2);
    
    if gearChangeRequest <= 1/3
      truck.ShiftGear('down');
    elseif (gearChangeRequest > 2/3) && (gearChangeRequest <= 1)
      truck.ShiftGear('up');
    end
    truck.ApplyBrakePressure(brakePressure);
    [gear, brakePressure] = truck.GetInputs;
    
    isWithinSpeedLimits = (speed <= maxSpeed) && (speed >= minSpeed);
    isBelowBrakeTempLimit = (brakeTemperature <= maxBrakeTemperature);
    isSatisfyingConstraints = isWithinSpeedLimits && isBelowBrakeTempLimit;
    isWithinSlope = (position <= slopeLength);
    simulationRunning = isSatisfyingConstraints && isWithinSlope;
  end

  if position > slopeLength
    distanceTraveled = slopeLength;
  else
    distanceTraveled = position;
  end
  
  recordedSlopeAngle(iIteration+1:end) = [];
  recordedBrakePressure(iIteration+1:end) = [];
  recordedGear(iIteration+1:end) = [];
  recordedSpeed(iIteration+1:end) = [];
  recordedBrakeTemperature(iIteration+1:end) = [];
  recordedState = [recordedPosition, recordedSlopeAngle, recordedBrakePressure, ...
    recordedGear, recordedSpeed, recordedBrakeTemperature];
  
  averageSpeed = mean(recordedSpeed);
  fitness = averageSpeed*distanceTraveled;
  
end