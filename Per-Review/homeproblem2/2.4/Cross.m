function newChromosomePair = Cross(chromosome1, chromosome2)

nGenesChromosome1 = length(chromosome1);
nGenesChromosome2 = length(chromosome2);

crossoverPoint1A = 4*(1 + fix(rand*(nGenesChromosome1/4-1)));
crossoverPoint1B = 4*(1 + fix(rand*(nGenesChromosome1/4-1)));
if crossoverPoint1A < crossoverPoint1B
  part1A = chromosome1(1:crossoverPoint1A);
  part1B = chromosome1(crossoverPoint1B+1:end);
  exchangePart1 = chromosome1(crossoverPoint1A+1:crossoverPoint1B);
elseif crossoverPoint1A == crossoverPoint1B
  part1A = chromosome1(1:crossoverPoint1A);
  part1B = chromosome1(crossoverPoint1B+1:end);
  if length(crossoverPoint1A) <= 8
    exchangePart1 = [];
  else
    exchangePart1 =chromosome1((crossoverPoint1A+1):(crossoverPoint1B));
  end
else
  part1A = chromosome1(1:crossoverPoint1B);
  part1B = chromosome1(crossoverPoint1A+1:end);
  exchangePart1 =chromosome1(crossoverPoint1B+1:(crossoverPoint1A));
end
crossoverPoint2A = 4*(1 + fix(rand*(nGenesChromosome2/4-1)));
crossoverPoint2B = 4*(1 + fix(rand*(nGenesChromosome2/4-1)));
if crossoverPoint2A < crossoverPoint2B
  part2A = chromosome2(1:crossoverPoint2A);
  part2B = chromosome2(crossoverPoint2B+1:end);
  exchangePart2 = chromosome2((crossoverPoint2A+1):(crossoverPoint2B));
elseif crossoverPoint2A == crossoverPoint2B
  part2A = chromosome2(1:crossoverPoint2A);
  part2B = chromosome2(crossoverPoint2B+1:end);
  if length(crossoverPoint2A) <= 8
    exchangePart2 = [];
  else
    exchangePart2 = chromosome2((crossoverPoint2A+1):(crossoverPoint2B));
  end
else
  part2A = chromosome2(1:crossoverPoint2B);
  part2B = chromosome2(crossoverPoint2A+1:end);
  exchangePart2 = chromosome2(crossoverPoint2B+1:(crossoverPoint2A));
end
newChromosomePair = [];

% Carrying out the crossover
newChromosome1 = [part1A exchangePart2 part1B];

tmpNewCromosome = struct('NewChromosome',newChromosome1);
newChromosomePair = [newChromosomePair tmpNewCromosome];
newChromosome2 = [part2A exchangePart1 part2B];
tmpNewCromosome = struct('NewChromosome',newChromosome2);
newChromosomePair = [newChromosomePair tmpNewCromosome];

end

