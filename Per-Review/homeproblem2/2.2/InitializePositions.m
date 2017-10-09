function positions = InitializePositions( numberOfParticles, minRange,...
  maxRange, numberOfDimensions )
% Function that will randomise initial positions within min and max range.

p = zeros(numberOfParticles, numberOfDimensions);
for i = 1:numberOfParticles
  for j = 1:numberOfDimensions
    r = rand;
    p(i,j) = minRange + r*(maxRange - minRange);
  end
end

positions = p;


end

