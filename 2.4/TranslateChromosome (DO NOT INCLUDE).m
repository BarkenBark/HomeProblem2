function TranslateChromosome(chromosome, nbrOfVariableRegisters, constantRegisters)
%TranslateChromosome Takes a chromosome as input and prints the function
%g(x) in the form given by Eq. (8) in Home Problem 2 formulation

  x = sym('x');
  r = [x, zeros(1, nbrOfVariableRegisters-1)];
  
  r = ExecuteInstructions(chromosome, r, constantRegisters);
  r(1) = simplify(r(1));
  disp(r(1))

end

