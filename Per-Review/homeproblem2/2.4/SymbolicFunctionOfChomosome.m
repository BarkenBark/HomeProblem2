function [ symFun ] = SymbolicFunctionFromChomosome2( xBest )
syms x;
register = [ x 0 0];
constants = [1 3 -1];
variableSet = [register constants];

for i=1:4:(length(xBest)-3)
  if xBest(i) == 1
    variableSet(xBest(i+1)) = variableSet(xBest(i+2))+variableSet(xBest(i+3));
  elseif xBest(i) == 2
    variableSet(xBest(i+1)) = variableSet(xBest(i+2))-variableSet(xBest(i+3));
  elseif xBest(i) == 3
    variableSet(xBest(i+1)) = variableSet(xBest(i+2))*variableSet(xBest(i+3));
  else
    %if variableSet(xBest(i+3)) == 0 && variableSet(xBest(i+2)) == 0
    % Special case when we divide 0 by 0
    %variableSet(xBest(i+1)) = 1;
    if variableSet(xBest(i+3)) == 0
      variableSet(xBest(i+1)) = realmax;
    else
      variableSet(xBest(i+1)) = variableSet(xBest(i+2))/variableSet(xBest(i+3));
    end
  end
end
symFun = simplify(variableSet(1));

end

