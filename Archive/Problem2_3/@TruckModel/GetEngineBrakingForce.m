function engineBrakingForce = GetEngineBrakingForce(gear, engineBrakingConstant)

  brakingFactors = {7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1};
  engineBrakingForce = brakingFactors{gear}*engineBrakingConstant;
  
end

