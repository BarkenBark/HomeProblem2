function val = ObjectiveFunction(x)

  val = (x(1).^2 + x(2) - 11).^2 + (x(1) + x(2).^2 -7).^2;

end

