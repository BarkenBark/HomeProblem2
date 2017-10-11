function iSelection = TournamentSelect(fitnessValues, pTournament, tournamentSize)

  populationSize = length(fitnessValues);
  
  %Pick tournemntSize random individuals, and sort them according to fitness
  iContestants = randi(populationSize, tournamentSize, 1);
  contestantFitness = fitnessValues(iContestants);
  [~,I] = sort(contestantFitness, 'descend');
  iContestants = iContestants(I);
  
  while length(iContestants)>=2
    if rand < pTournament
      break
    else
      iContestants(1) = [];
    end
  end

  iSelection = iContestants(1);

end

