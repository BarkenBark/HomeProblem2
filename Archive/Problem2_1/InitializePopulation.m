function population = InitializePopulation(populationSize, cityLocations)

  nbrOfCities = size(cityLocations, 1);
  population = zeros(populationSize, nbrOfCities);

  for iChromosome = 1:populationSize
    
    chromosome = population(iChromosome,:);
    nodes = 1:nbrOfCities;
    [node, index] = datasample(nodes, 1);
    chromosome(1) = node;
    
    for iGene = 2:nbrOfCities
      currentCity = cityLocations(node,:);
      nodes(index) = [];
      distances = zeros(nbrOfCities-iGene+1, 1);
      for i = 1:nbrOfCities-iGene+1
        nextNode = nodes(i);
        nextCity = cityLocations(nextNode,:);
        distances(i) = norm(nextCity - currentCity);
      end
      [~,index] = min(distances);
      node = nodes(index);
      chromosome(iGene) = node;
    end
    
    population(iChromosome,:) = chromosome;
    
  end

end

