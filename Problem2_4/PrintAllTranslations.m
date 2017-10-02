%% Test symbolically
x = sym('x');

for i = 1:populationSize
c = population(i).Chromosome;
TranslateChromosome(c, nbrOfVariableRegisters, constantRegisters);
end