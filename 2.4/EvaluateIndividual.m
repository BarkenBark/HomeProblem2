function fitness = EvaluateIndividual(chromosome, dataset, ...
  nbrOfVariableRegisters, constantRegisters, maxNbrOfInstructions)

  if isempty(chromosome)
    fitness = -realmax;
    return
  end
  
  penaltyFactor = 1;
  if length(chromosome) > maxNbrOfInstructions*4
    instructionsOverMax = length(chromosome)/4 - maxNbrOfInstructions;
    penaltyRate = 3;
    penaltyFactor = 1 - exp(-1/(penaltyRate*instructionsOverMax));
  end
  
  input = dataset(:,1);
  targetOutput = dataset(:,2);
  
  output = zeros(length(input), 1);
  i = 0;
  for x = input'
    i = i+1;
    r = zeros(1, nbrOfVariableRegisters);
    r(1) = x;
    r = ExecuteInstructions(chromosome, r, constantRegisters);
    output(i) = r(1);
  end

  error = Error(targetOutput, output);
  if error ~= 0
    fitness = penaltyFactor*1/error;
  else
    fitness = realmax;
  end
  
end

