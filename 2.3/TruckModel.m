classdef TruckModel < handle
    
  properties
    %Dynamics (external)
    position;
    speed;
    brakeTemperature;
    
    %Dynamics (internal)
    gearRestTime;
    
    %Controllables
    gear; 
    brakePressure;
    
    %Constants
    MASS = 20000;
    MAX_BRAKE_TEMPERATURE = 750;
    AMBIENT_BRAKE_TEMPERATURE = 283;
    ENGINE_BRAKING_CONSTANT = 3000;
    GEAR_BRAKING_FACTORS = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1];
    GEAR_REST_PERIOD = 2;
    TAU = 30;
    HEAT_CONSTANT = 40;
  end
  
  
  
  methods
    %Constructor
    function obj = TruckModel(position, speed, brakeTemperature, gear, brakePressure)
      obj.position = position;
      obj.speed = speed;
      obj.brakeTemperature = brakeTemperature;
      obj.gear = gear;
      obj.brakePressure = brakePressure;
      obj.gearRestTime = realmax; %Truck has not shifted gear before initial state
    end
    
    
    %Mutators
    function ApplyBrakePressure(obj, brakePressure)
      obj.brakePressure = brakePressure;
    end

    function ShiftGear(obj, direction)
      maxGear = length(obj.GEAR_BRAKING_FACTORS);
      minGear = 1;
      if obj.gearRestTime >= obj.GEAR_REST_PERIOD
        if strcmp(direction, 'up')
          if obj.gear < maxGear
            obj.gear = obj.gear + 1;
            obj.gearRestTime = 0;
          end
        elseif strcmp(direction, 'down')
          if obj.gear > minGear
            obj.gear = obj.gear - 1;
            obj.gearRestTime = 0;
          end
        end
      end
    end
    
    function UpdateDynamics(obj, slope, timeStep)
      obj.gearRestTime = obj.gearRestTime + timeStep;
      obj.position = obj.position + cosd(slope)*obj.speed*timeStep;
      
      gravityForce = obj.CalculateGravityForce(slope);
      brakingForce = obj.CalculateBrakingForce;
      engineBrakingForce = obj.CalculateEngineBrakingForce;
      acceleration = obj.CalculateAcceleration(gravityForce, ...
        brakingForce, engineBrakingForce);
      
      obj.speed = obj.speed + acceleration*timeStep;
      
      deltaTemperature = obj.brakeTemperature - obj.AMBIENT_BRAKE_TEMPERATURE;
      temperatureDerivative = obj.CalculateTemperatureDerivative(deltaTemperature);
      obj.brakeTemperature = obj.brakeTemperature + temperatureDerivative*timeStep;
    end
    
    
    %Accessors
    function [position, speed, brakeTemperature] = GetDynamics(obj)
      speed = obj.speed;
      position = obj.position;
      brakeTemperature = obj.brakeTemperature;
    end
    
    function [gear, brakePressure] = GetControllables(obj)
      gear = obj.gear;
      brakePressure = obj.brakePressure;
    end
    
    
    %Physics functions
    function gravityForce = CalculateGravityForce(obj, slope)
      g = obj.GetGravityConstant;
      gravityForce = obj.MASS*g*sind(slope);
    end
    
    function brakingForce = CalculateBrakingForce(obj)
      g = obj.GetGravityConstant;
      if obj.brakeTemperature < obj.MAX_BRAKE_TEMPERATURE - 100
        brakingForce = obj.MASS*g/20 *obj.brakePressure;
      else
        tmp = obj.brakeTemperature - (obj.MAX_BRAKE_TEMPERATURE-100);
        tmp = exp(-tmp/100);
        brakingForce = obj.MASS*g/20 * obj.brakePressure * tmp;
      end
    end
        
    function engineBrakingForce = CalculateEngineBrakingForce(obj)
      engineBrakingForce = obj.GEAR_BRAKING_FACTORS(obj.gear) * obj.ENGINE_BRAKING_CONSTANT;
    end
    
    function acceleration = CalculateAcceleration(obj, gravityForce, ...
        brakingForce, engineBrakingForce)
      acceleration = (gravityForce - brakingForce - engineBrakingForce)/obj.MASS;
    end
    
    function temperatureDerivative = CalculateTemperatureDerivative(obj, deltaTemperature)
      if obj.brakePressure < 0.01
        temperatureDerivative =  -deltaTemperature/obj.TAU;
      else
        temperatureDerivative = obj.HEAT_CONSTANT * obj.brakePressure;
      end
    end
  end %end methods
  
  
  
  
  
  methods(Static)
    function g = GetGravityConstant
      g = 9.81;
    end
  end
  
end

