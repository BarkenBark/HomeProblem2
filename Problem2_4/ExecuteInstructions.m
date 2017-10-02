function r = ExecuteInstructions(chromosome, variableRegisters, constantRegisters)

  c_max = realmax;

  chromosomeLength = length(chromosome);
  r = variableRegisters;
  c = constantRegisters;
  op = [r c];
  
  for iGene = 1:4:chromosomeLength
    
    iVar = chromosome(iGene+1);
    iOp1 = chromosome(iGene+2);
    iOp2 = chromosome(iGene+3);
    
    if chromosome(iGene) == 1
      r(iVar) = op(iOp1) + op(iOp2);
    elseif chromosome(iGene) == 2
      r(iVar) = op(iOp1) - op(iOp2);
    elseif chromosome(iGene) == 3
      r(iVar) = op(iOp1) * op(iOp2);
    elseif chromosome(iGene) == 4
      if op(iOp2) ~= 0
        r(iVar) = op(iOp1) / op(iOp2);
      else
        r(iVar) = c_max * sign(op(iOp1)*op(iOp2));
      end
    end
    
    op = [r c];

  end

end

