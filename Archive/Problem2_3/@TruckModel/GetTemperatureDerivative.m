function temperatureDerivative = GetTemperatureDerivative(deltaTemperature, brakingPressure, tau, Ch)

  if brakingPressure < 0.01
    temperatureDerivative =  -deltaTemperature/tau;
  else
    temperatureDerivative = Ch*brakingPressure;
  end

end

