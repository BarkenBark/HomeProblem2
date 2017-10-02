function brakingForce = GetBrakingForce(mass, brakePressure, brakeTemperature, maxTemperature)

  g = GetGravityConstant;

  if brakeTemperature <= maxTemperature - 100
    brakingForce = mass*g/20*brakePressure;
  else 
    tmp = exp(-(brakeTemperature-(maxTemperature-100))/100);
    brakingForce = mass*g/20*brakePressure*tmp;
  end

end

