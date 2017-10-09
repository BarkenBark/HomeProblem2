function modifiedPopulation = InsertBestIndividual(population, bestIndividual,numberOfCopies)

for n = 1:numberOfCopies
  population(n, :) = bestIndividual;
end
modifiedPopulation = population;

end

