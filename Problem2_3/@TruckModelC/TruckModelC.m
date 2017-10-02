classdef TruckModelC < handle
    
  properties
    
    %Dynamics
    position;
    speed;
    brakeTemperature;
    
    %Controllables
    gear; 
    brakePressure;
    
    %Constants
    mass = 20000;
    maxBrakeTemperature = 750;
    ambientBrakeTemperature = 283;
    engineBrakingConstant = 3000;
    gearBrakingFactors = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1];
    tau = 30;
    Ch = 40;
    maxSpeed = 25;
    minSpeed = 1;
    maxSlope = 10;
    
  end
  
  
  
  
  
  methods
    
    %Constructor
    function obj = TruckModelC(position, speed, brakeTemperature, gear, brakePressure)
      obj.position = position;
      obj.speed = speed;
      obj.brakeTemperature = brakeTemperature;
      obj.gear = gear;
      obj.brakePressure = brakePressure;
    end
    
    
    
    %Truck state functions
    function ApplyBrakePressure(obj, brakePressure)
      obj.brakePressure = brakePressure;
    end
    
    function ShiftGear(obj, gear)
      obj.gear = gear;
    end
    
    function [position, speed, brakeTemperature] = GetState(obj)
      speed = obj.speed;
      position = obj.position;
      brakeTemperature = obj.brakeTemperature;
    end
    
    function Iterate(obj, slope, deltaT)
      gravityForce = obj.GetGravityForce(slope);
      brakingForce = obj.GetBrakingForce;
      engineBrakingForce = obj.GetEngineBrakingForce;
      
      acceleration = obj.GetAcceleration(gravityForce, ...
        brakingForce, engineBrakingForce);
      
      deltaTemperature = obj.brakeTemperature - obj.ambientBrakeTemperature;
      temperatureDerivative = obj.GetTemperatureDerivative(deltaTemperature);
      
      obj.brakeTemperature = obj.brakeTemperature + temperatureDerivative*deltaT;
      obj.speed = obj.speed + acceleration*deltaT;
      obj.position = obj.position + cosd(slope)*obj.speed*deltaT;
    end
    
    
    
    %Physics functions
    function gravityForce = GetGravityForce(obj, slope)
      g = obj.GetGravityConstant;
      gravityForce = obj.mass*g*sind(slope);
    end
    
    function brakingForce = GetBrakingForce(obj)
      g = obj.GetGravityConstant;
      if obj.brakeTemperature <= obj.maxBrakeTemperature - 100
        brakingForce = obj.mass*g/20*obj.brakePressure;
      else
        tmp = exp(-(obj.brakeTemperature-(obj.maxBrakeTemperature-100))/100); %Too complicated?
        brakingForce = obj.mass*g/20*obj.brakePressure*tmp;
      end
    end
        
    function engineBrakingForce = GetEngineBrakingForce(obj)
      engineBrakingForce = obj.gearBrakingFactors(obj.gear) * obj.engineBrakingConstant;
    end
    
    function acceleration = GetAcceleration(obj, gravityForce, ...
        brakingForce, engineBrakingForce)
      acceleration = (gravityForce - brakingForce - engineBrakingForce)/obj.mass;
    end
    
    function temperatureDerivative = GetTemperatureDerivative(obj, deltaTemperature)
      if obj.brakePressure < 0.01
        temperatureDerivative =  -deltaTemperature/obj.tau;
      else
        temperatureDerivative = obj.Ch * obj.brakePressure;
      end
    end
    
  end %end methods
  
  
  
  
  
  methods(Static)
    function g = GetGravityConstant
      g = 9.80665;
    end
  end
  
end

