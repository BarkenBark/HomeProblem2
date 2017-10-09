function	r1 = DecodeChromosome(chromosome, register, CONSTANTS)

variableSet = [register CONSTANTS];
tempChromosome = chromosome;
if length(tempChromosome) == 4
  if tempChromosome(1) == 1
    variableSet(tempChromosome(2)) = variableSet(tempChromosome(3))+variableSet(tempChromosome(4));
  elseif tempChromosome(1) == 2
    variableSet(tempChromosome(2)) = variableSet(tempChromosome(3))-variableSet(tempChromosome(4));
  elseif tempChromosome(1) == 3
    variableSet(tempChromosome(2)) = variableSet(tempChromosome(3))*variableSet(tempChromosome(4));
  else
    if variableSet(tempChromosome(4)) == 0
      variableSet(tempChromosome(2)) = realmax;
    else
      variableSet(tempChromosome(2)) = variableSet(tempChromosome(3))/variableSet(tempChromosome(4));
    end
  end
  disp('decode4')
else
  for i=1:4:(length(tempChromosome)-3)
    if tempChromosome(i) == 1
      variableSet(tempChromosome(i+1)) = variableSet(tempChromosome(i+2))+variableSet(tempChromosome(i+3));
    elseif tempChromosome(i) == 2
      variableSet(tempChromosome(i+1)) = variableSet(tempChromosome(i+2))-variableSet(tempChromosome(i+3));
    elseif tempChromosome(i) == 3
      variableSet(tempChromosome(i+1)) = variableSet(tempChromosome(i+2))*variableSet(tempChromosome(i+3));
    else
      if variableSet(tempChromosome(i+3)) == 0
        variableSet(tempChromosome(i+1)) = realmax;
      else
        variableSet(tempChromosome(i+1)) = variableSet(tempChromosome(i+2))/variableSet(tempChromosome(i+3));
      end
    end
  end
end
r1 = variableSet(1);
