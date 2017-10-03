function newChromosomePair = Cross(chromosome1, chromosome2)

  nbrOfGenes = length(chromosome1);
  crossoverPoint = randi(nbrOfGenes);
  
  newChromosomePair = zeros(2,nbrOfGenes);
  for j = 1:nbrOfGenes
    if (j <= crossoverPoint)
      newChromosomePair(1,j) = chromosome2(j);
      newChromosomePair(2,j) = chromosome1(j);
    else
      newChromosomePair(1,j) = chromosome1(j);
      newChromosomePair(2,j) = chromosome2(j);
    end
  end

end

