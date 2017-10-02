function acceleration = GetAcceleration(mass, gravityForce, brakingForce, engineBrakingForce)

  acceleration = (gravityForce - brakingForce - engineBrakingForce)/mass;

end

