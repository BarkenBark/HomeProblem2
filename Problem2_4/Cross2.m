function [newChromosome1, newChromosome2] = Cross2(chromosome1, chromosome2)
%Cross Returna a pair of chromosomes after two-point crossover

  m = length(chromosome1);
  CrossoverPoints1 = randi(m/4, 2, 1);
  CrossoverPoints1 = sort(CrossoverPoints1);
  CrossoverPoints1 = CrossoverPoints1 + [0; 1];
  CrossoverPoints1 = (CrossoverPoints1-1)*4;
  chunk1 = chromosome1(CrossoverPoints1(1)+1:CrossoverPoints1(2));
  
  m = length(chromosome2);
  CrossoverPoints2 = randi(m/4, 2, 1);
  CrossoverPoints2 = sort(CrossoverPoints2);
  CrossoverPoints2 = CrossoverPoints2 + [0; 1];
  CrossoverPoints2 = (CrossoverPoints2-1)*4;
  chunk2 = chromosome2(CrossoverPoints2(1)+1:CrossoverPoints2(2));
  
  newChromosome1 = [chromosome1(1:CrossoverPoints1(1)) chunk2 chromosome1(CrossoverPoints1(2)+1:end)];
  newChromosome2 = [chromosome2(1:CrossoverPoints2(1)) chunk1 chromosome2(CrossoverPoints2(2)+1:end)];
  
end
