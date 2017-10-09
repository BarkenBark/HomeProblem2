function mutatedChromosome = Mutate(chromosome,mutationProbability)

nGenes = length(chromosome);
mutatedChromosome = chromosome;
if nGenes == 4
  r = rand; q= rand; w = rand; e =rand;
  if (r < mutationProbability)
    indexOperator = mutatedChromosome(1,1);
    mutatedChromosome(1,1) = randi(4);
    while mutatedChromosome(1,1) == indexOperator
      mutatedChromosome(1,1) = randi(4);
    end
  end
  
  if (q < mutationProbability)
    indexRegister = mutatedChromosome(1,2);
    mutatedChromosome(1,2) = randi(3);
    while mutatedChromosome(1,2) == indexRegister
      mutatedChromosome(1,2) = randi(3);
    end
  end
  
  if (w < mutationProbability)
    indexVarSet1 = mutatedChromosome(1,3);
    mutatedChromosome(1,3) = randi(6);
    while mutatedChromosome(1,3) == indexVarSet1
      mutatedChromosome(1,3) = randi(6);
    end
  end
  
  if (e < mutationProbability)
    indexVarSet2 =  mutatedChromosome(1,4);
    mutatedChromosome(1,4) = randi(6);
    while mutatedChromosome(1,4) == indexVarSet2
      mutatedChromosome(1,4) = randi(6);
    end
  end
  disp('4mut')
else
  for j = 1:4:(nGenes-3)
    r = rand; q= rand; w = rand; e =rand;
    if (r < mutationProbability)
      indexOperator = mutatedChromosome(1,j);
      mutatedChromosome(1,j) = randi(4);
      while mutatedChromosome(1,j) == indexOperator
        mutatedChromosome(1,j) = randi(4);
      end
    end
    
    if (q < mutationProbability)
      indexRegister = mutatedChromosome(1,j+1);
      mutatedChromosome(1,j+1) = randi(3);
      while mutatedChromosome(1,j+1) == indexRegister
        mutatedChromosome(1,j+1) = randi(3);
      end
    end
    
    if (w < mutationProbability)
      indexVarSet1 = mutatedChromosome(1,j+2);
      mutatedChromosome(1,j+2) = randi(6);
      while mutatedChromosome(1,j+2) == indexVarSet1
        mutatedChromosome(1,j+2) = randi(6);
      end
    end
    
    if (e < mutationProbability)
      indexVarSet2 =  mutatedChromosome(1,j+3);
      mutatedChromosome(1,j+3) = randi(6);
      while mutatedChromosome(1,j+3) == indexVarSet2
        mutatedChromosome(1,j+3) = randi(6);
      end
    end
  end
end

