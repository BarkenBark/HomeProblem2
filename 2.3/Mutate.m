function mutatedChromosome = Mutate(chromosome, mutationProbability, ...
  creepRate, creepProbability)
%Assumes real-encoded chromosome with gene range g=[0,1].

  nbrOfGenes = length(chromosome);
  mutatedChromosome = chromosome;
  for j = 1:nbrOfGenes
    if (rand < mutationProbability)
      
      if (rand < creepProbability)
        gPrim = chromosome(j) + creepRate*(rand - 1/2);
        if gPrim < 0
          mutatedChromosome(j) = 0;
        elseif gPrim > 1
          mutatedChromosome(j) = 1;
        else
          mutatedChromosome(j) = gPrim;
        end
        
      else
        mutatedChromosome(j) = rand;
      end
      
    end
  end

end

