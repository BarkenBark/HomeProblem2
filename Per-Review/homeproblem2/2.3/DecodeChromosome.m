function [weights1, weights2, bias1, bias2] = DecodeChromosome(chromosome,variableRange)

nGenes = size(chromosome,2);
x(1) = 0.0;
for j = 1:nGenes
  x(j) = -variableRange + 2*variableRange*chromosome(j);
end

% Randomising weights and biases so that the crossover exchange different
% parts of the chromosome.
weights1 = [x(1) x(2) x(3); x(10) x(11) x(12); x(19) x(20) x(21); x(23) x(24) x(25)];
bias1 = [x(4); x(13); x(22); x(26)];
weights2 = [x(5) x(6) x(7) x(8); x(14) x(15) x(16) x(17)];
bias2 = [x(9); x(18)];
end