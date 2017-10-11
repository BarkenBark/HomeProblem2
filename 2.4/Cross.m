function [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2)

  m = length(chromosome1);
  CrossoverPoints1 = randi(m/4+1, 2, 1);
  CrossoverPoints1 = sort(CrossoverPoints1);
  CrossoverPoints1 = (CrossoverPoints1-1)*4;
  
  if CrossoverPoints1(1) == CrossoverPoints1(2)
    chunk1 = [];
  else
    chunk1 = chromosome1(CrossoverPoints1(1)+1:CrossoverPoints1(2));
  end
  
  m = length(chromosome2);
  CrossoverPoints2 = randi(m/4+1, 2, 1);
  CrossoverPoints2 = sort(CrossoverPoints2);
  CrossoverPoints2 = (CrossoverPoints2-1)*4;
  
  if CrossoverPoints2(1) == CrossoverPoints2(2)
    chunk2 = [];
  else
    chunk2 = chromosome2(CrossoverPoints2(1)+1:CrossoverPoints2(2));
  end
  
  newChromosome1 = [chromosome1(1:CrossoverPoints1(1)) chunk2 chromosome1(CrossoverPoints1(2)+1:end)];
  newChromosome2 = [chromosome2(1:CrossoverPoints2(1)) chunk1 chromosome2(CrossoverPoints2(2)+1:end)];
  
end

