function gravityForce = GetGravityForce(mass, slope)

  g = GetGravityConstant;
  gravityForce = mass*g*sind(slope);

end

