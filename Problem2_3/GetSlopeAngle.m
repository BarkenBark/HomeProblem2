function alpha = GetSlopeAngle(x, iSlope, iDataSet)

%Training set
if (iDataSet == 1)                                
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 2)
   alpha = 2 + e^(-x/10) + sin(x/70);
 elseif (iSlope == 3)
   alpha = 2.3 * cos(ln(x+1)) + 2.3 + x/500;
 elseif (iSlope == 4)
   alpha = 5 * cos(x/100) + 5;
 elseif (iSlope == 5)
   alpha = cos(x/100) + sin(x/50) + 2;
 elseif (iSlope == 6)
   alpha = ln(cos(x/50)+2) + sin(x/100) + 1;
 elseif (iSlope == 7)
   alpha = 9.9*sqrt(exp(-x/100));
 elseif(iSlope == 8)
   alpha = 8 * (x/1000)^2;
 elseif(iSlope == 9)
   alpha = 3*exp(-x/100) + 2*sin(x/20) + x/1000*cos((x/90)^2) + 4;
 elseif (iSlope== 10)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
 end 
 
%Validation set
elseif (iDataSet == 2)                            
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
 elseif (iSlope == 2)
   alpha = 300/(x+200)*(sin(cos(x/12)) + cos(sin(x/15)) + 3);
 elseif (iSlope == 3)
   alpha = 4*sin(x/200) + 5;
 elseif (iSlope == 4)
   alpha = 3*cos(2*sin(1*cos(x/45+1)-1)+1);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
 end 
 
%Test set
elseif (iDataSet == 3)                         
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50); 
 elseif (iSlope == 2)
   alpha = 3*cos(x/70) - sin(x/140) + 4.5;
 elseif (iSlope == 3)
   alpha = -x/200 * cos(x/50) + 5;
 elseif (iSlope == 4)
   alpha = 0.7 * (x/100)^(x/900) * sin(x/100) * cos(x/20);
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end
 
end
