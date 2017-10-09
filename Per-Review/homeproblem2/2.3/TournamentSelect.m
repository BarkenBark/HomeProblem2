function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)
populationSize = size(fitness,1);
iTmp = zeros(1, tournamentSize);
for i = 1:tournamentSize
  iTmp(i) = 1 + fix(rand*populationSize);
  iTmpFitness(i) = fitness(iTmp(i));
end

tempList = [iTmpFitness; iTmp]';
sortedList = sortrows(tempList, -1); % Will sort fitness-value
index = 1;
iSelected = 0;
while iSelected == 0
  r = rand;
  if (r < pTournament)
    iSelected = sortedList(index,2);
  end
  
  if index == size(tempList,1)
    iSelected = sortedList(index,2);
  end
  index = index+1;
end