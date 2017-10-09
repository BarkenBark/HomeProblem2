function alpha = GetSlopeAngle(x, iSlope, iDataSet)
% Function that will give slope angle depening on distance

if (iDataSet == 1)    % Training set
  if (iSlope == 1)
    alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
  elseif (iSlope == 2)
    alpha = 5 + 2*sin(pi*x/250) + cos(x/500);
  elseif (iSlope == 3)
    alpha = 4 + sin(7*x/230) + 2*cos(x/333);
  elseif (iSlope == 4)
    alpha = 5 + sin(x/70) + 2*cos(x/120);
  elseif (iSlope == 5)
    alpha = 6 + sin(x/100) + 2*cos(x/80);
  elseif (iSlope == 6)
    alpha = 4 + 2*sin(x/200) + cos(x/300);
  elseif (iSlope == 7)
    alpha = 5 - 2*sin(pi/2*x/100) +2*cos(pi*x/200);
  elseif (iSlope == 8)
    alpha = 4 + 2*sin(x/43) - 2*cos(sqrt(973)*x/879);
  elseif (iSlope == 9)
    alpha = 5.5 + 1.5*sin(x/100) - cos(x/80);
  elseif (iSlope== 10)
    alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
  end
elseif (iDataSet == 2) % Validation set
  if (iSlope == 1)
    alpha = 5 - sin(x/328) + cos(sqrt(3)*x/845);
  elseif (iSlope == 2)
    alpha = 6 - sin(x/189) + cos(x/510);
  elseif (iSlope == 3)
    alpha = 4 + 2*sin(x/501) - 2*cos(sqrt(7)*x/79);
  elseif (iSlope == 4)
    alpha = 3 - 2*sin(x/897) + cos(sqrt(13)*x/743);
  elseif (iSlope == 5)
    alpha = 4 + 1*sin(x/687) - 2*cos(sqrt(19)*x/129);
  end
elseif (iDataSet == 3) % Test set
  if (iSlope == 1)
    alpha = 5 - sin(x/100) - 2*cos(sqrt(7)*x/50);
  elseif (iSlope == 2)
    alpha = 4 + 2*sin(x/43) - 2*cos(sqrt(973)*x/879);
  elseif (iSlope == 3)
    alpha = 3 + 2*sin(x/123) - cos(sqrt(182)*x/95);
  elseif (iSlope == 4)
    alpha = 4 + 2*sin(x/687) -2*cos(sqrt(19)*x/129);
  elseif (iSlope == 5)
    alpha = 3 + sin(x/70) + 2*cos(sqrt(7)*x/100);
  end
end