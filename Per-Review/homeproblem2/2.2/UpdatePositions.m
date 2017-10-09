function xPositions = UpdatePositions( xPositions, velocity)

numberOfParticles = size(xPositions,1);
numberOfDimensions = size(xPositions,2);

newPositions = zeros(numberOfParticles, numberOfDimensions);
for i = 1:numberOfParticles
  for j = 1:numberOfDimensions
    newPositions(i,j) = xPositions(i,j) + velocity(i,j);
  end
end
xPositions = newPositions;

end

