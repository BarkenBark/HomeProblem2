classdef TruckModel < handle
    
  properties
    position;
    speed;
    brakeTemperature;
    
    gear; 
    brakePressure;
    
    mass = 20000;
    maxBrakeTemperature = 750;
    ambientBrakeTemperature = 283;
    engineBrakingConstant = 3000;
    tau = 30;
    Ch = 40;
    maxSpeed = 25;
    minSpeed = 1;
    maxSlope = 10;
  end
  
  
  
  methods
    
    %Constructor
    function obj = TruckModel(position, speed, brakeTemperature, gear, brakePressure)
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
      gravityForce = GetGravityForce(obj.mass, slope);
      brakingForce = GetBrakingForce(obj.mass, obj.brakePressure, ...
        obj.brakeTemperature, obj.maxBrakeTemperature);
      engineBrakingForce = GetEngineBrakingForce(obj.gear, obj.engineBrakingConstant);
      
      acceleration = GetAcceleration(obj.mass, gravityForce, ...
        brakingForce, engineBrakingForce);
      
      deltaTemperature = obj.brakeTemperature - obj.ambientBrakeTemperature;
      temperatureDerivative = GetTemperatureDerivative( ...
        deltaTemperature, obj.brakePressure, obj.tau, obj.Ch);
      
      obj.brakeTemperature = obj.brakeTemperature + temperatureDerivative*deltaT;
      obj.speed = obj.speed + acceleration*deltaT;
      obj.position = obj.position + cosd(slope)*obj.speed*deltaT;
    end
    
    %Physics functions
    function gravityForce = GetGravityForce(mass, slope)
      g = GetGravityConstant;
      gravityForce = mass*g*sind(slope);
    end
    
    
    
  end
  
end

