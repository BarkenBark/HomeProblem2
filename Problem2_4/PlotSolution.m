function PlotSolution(chromosome, nbrOfVariableRegisters, constantRegisters, dataset)

  clf

  X = dataset(:,1);
  YTarget = dataset(:,2);
  Y = zeros(length(YTarget), 1);
  
  i = 0;
  for x = X'
    i = i+1;
    r = zeros(1, nbrOfVariableRegisters);
    r(1) = x;
    r = ExecuteInstructions(chromosome, r, constantRegisters);
    Y(i) = r(1);
  end
  
  hold on
  plot(X,YTarget)
  plot(X,Y)
  drawnow
  
end

