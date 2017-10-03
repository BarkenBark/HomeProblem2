classdef TruckModel < handle
    
  properties
    
    %Dynamics (external)
    position;
    speed;
    brakeTemperature;
    
    %Dynamics (internal)
    gearRestTime;
    
    %Input
    gear; 
    brakePressure;
    
    %Constants
    mass = 20000;
    maxBrakeTemperature = 750;
    ambientBrakeTemperature = 283;
    engineBrakingConstant = 3000;
    gearBrakingFactors = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1];
    gearRestPeriod = 2;
    tau = 30;
    Ch = 40;
 
  end
  
  
  
  
  
  methods
    
    %Constructor
    function obj = TruckModel(position, speed, brakeTemperature, gear, brakePressure)
      obj.position = position;
      obj.speed = speed;
      obj.brakeTemperature = brakeTemperature;
      obj.gear = gear;
      obj.brakePressure = brakePressure;
      obj.gearRestTime = 0;
    end
    
    
    
    %Truck state functions
    function ApplyBrakePressure(obj, brakePressure)
      obj.brakePressure = brakePressure;
    end
    
    function ShiftGear(obj, direction)
      maxGear = length(obj.gearBrakingFactors);
      minGear = 1;
      if obj.gearRestTime >= obj.gearRestPeriod
        if strcmp(direction, 'up')
          obj.gear = obj.gear + 1;
        elseif strcmp(direction, 'down')
          obj.gear = obj.gear - 1;
        end
        if obj.gear > maxGear
          obj.gear = maxGear;
        elseif obj.gear < minGear
          obj.gear = minGear;
        end
      end
    end
    
    function Iterate(obj, slope, deltaT)
      obj.gearRestTime = obj.gearRestTime + deltaT;
      
      deltaTemperature = obj.brakeTemperature - obj.ambientBrakeTemperature;
      temperatureDerivative = obj.CalculateTemperatureDerivative(deltaTemperature);
      obj.brakeTemperature = obj.brakeTemperature + temperatureDerivative*deltaT;
      
      gravityForce = obj.CalculateGravityForce(slope);
      brakingForce = obj.CalculateBrakingForce;
      engineBrakingForce = obj.CalculateEngineBrakingForce;
      acceleration = obj.CalculateAcceleration(gravityForce, ...
        brakingForce, engineBrakingForce);
      
      obj.speed = obj.speed + acceleration*deltaT;
      obj.position = obj.position + cosd(slope)*obj.speed*deltaT;
    end
    
    function [position, speed, brakeTemperature] = GetDynamics(obj)
      speed = obj.speed;
      position = obj.position;
      brakeTemperature = obj.brakeTemperature;
    end
    
    function [gear, brakePressure] = GetInputs(obj)
      gear = obj.gear;
      brakePressure = obj.brakePressure;
    end
    
    
    %Physics functions
    function gravityForce = CalculateGravityForce(obj, slope)
      g = obj.GetGravityConstant;
      gravityForce = obj.mass*g*sind(slope);
    end
    
    function brakingForce = CalculateBrakingForce(obj)
      g = obj.GetGravityConstant;
      if obj.brakeTemperature < obj.maxBrakeTemperature - 100
        brakingForce = obj.mass*g/20*obj.brakePressure;
      else
        tmp = exp(-(obj.brakeTemperature-(obj.maxBrakeTemperature-100))/100); %Too complicated?
        brakingForce = obj.mass*g/20*obj.brakePressure * tmp;
      end
    end
        
    function engineBrakingForce = CalculateEngineBrakingForce(obj)
      engineBrakingForce = obj.gearBrakingFactors(obj.gear) * obj.engineBrakingConstant;
    end
    
    function acceleration = CalculateAcceleration(obj, gravityForce, ...
        brakingForce, engineBrakingForce)
      acceleration = (gravityForce - brakingForce - engineBrakingForce)/obj.mass;
    end
    
    function temperatureDerivative = CalculateTemperatureDerivative(obj, deltaTemperature)
      if obj.brakePressure < 0.01
        temperatureDerivative =  -deltaTemperature/obj.tau;
      else
        temperatureDerivative = obj.Ch * obj.brakePressure;
      end
    end
    
  end %end methods
  
  
  
  
  
  methods(Static)
    function g = GetGravityConstant
      g = 9.82;
    end
  end
  
end

