function fitness = EvaluateIndividual(network)
%EvaluateIndividual Run the simulation where the truck is controlled by a
%network encoded by chromosome. The fitness score returned is the
%horisontal distance traveled.
  
  %Initial truck state
  position = 0;
  speed = 20;
  brakeTemperature = 500; 
  gear = 7;
  brakePressure = 0.2;
  
  %Limits
  maxSpeed = 25;
  minSpeed = 1;
  maxSlopeAngle = 10; %Not imposing constraint
  maxBrakeTemperature = 750;
  
  %Simulation parameters
  deltaT = 0.01;
  predictedNbrOfIterations = 2000;
  
  %Dataset settings
  iSlope = 1;
  iDataSet = 1;
  slopeLength = 1000;

  truck = TruckModel(position, speed, brakeTemperature, gear, brakePressure);
  
  simulationRunning = true;
  iIteration = 0;
  recordedSpeed = zeros(predictedNbrOfIterations, 1); 
  while simulationRunning
    iIteration = iIteration + 1;
    recordedSpeed(iIteration) = speed;
    
    slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);
    
    input = zeros(3,1);
    input(1) = speed/maxSpeed;
    input(2) = slopeAngle/maxSlopeAngle;
    input(3) = brakeTemperature/maxBrakeTemperature;
    
    output = network.ForwardPropagate(input);
    gearChangeRequest = output(1);
    brakePressure = output(2);
    
    if gearChangeRequest <= 1/3
      truck.ShiftGear(gear-1);
    elseif (gearChangeRequest > 2/3) && (gearChangeRequest <= 1)
      truck.ShiftGear(gear-1);
    end
    truck.ApplyBrakePressure(brakePressure);
    
    truck.Iterate(slopeAngle, deltaT);
    [position, speed, brakeTemperature] = truck.GetDynamics;
    
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
  recordedSpeed(iIteration+1:end) = [];
  averageSpeed = mean(recordedSpeed);
  
  fitness = averageSpeed*distanceTraveled;
  
  %fprintf('L = %.2f, v = %.2f, T = %.2f.\n', distanceTraveled, speed, brakeTemperature)
  %iIteration
  
end

