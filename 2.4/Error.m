function val = Error(targetOutput, output)

  K = length(targetOutput);
  tmp = sum((targetOutput - output).^2);
  val = sqrt(1/K*tmp);

end

