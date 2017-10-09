function velocity = InitializeVelocities(  numberOfParticles, minRange,...
  maxRange, numberOfDimensions)
% Function that will randomise initial velocities, delta t = 1.
for i = 1:numberOfParticles
  for j = 1:numberOfDimensions
    r = rand;
    v(i,j) = (-(maxRange-minRange)/2+ r*(maxRange - minRange));
  end
end
velocity = v;

end

