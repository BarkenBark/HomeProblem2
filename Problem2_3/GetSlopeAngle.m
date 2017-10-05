function alpha = GetSlopeAngle(x, iSlope, iDataSet)

%Training set
if (iDataSet == 1)                                
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 2)
   alpha = 3 + 2*sin(x/100) - cos(sqrt(16)*x/50);
 elseif (iSlope == 3)
   alpha = x/500 - sin(x/100) + cos(x/200) + 5;
 elseif (iSlope == 4)
   alpha = 8 + sin(sqrt(3)*x/80) - cos(x/50) - x/200;
 elseif (iSlope == 5)
   alpha = cos(x/100) + sin(x/50) + 2;
 elseif (iSlope == 6)
   alpha = 5 + 3*sin(x/20) + 2*cos(sqrt(9)*x/400);
 elseif (iSlope == 7)
   alpha = 1 + 0.5*sin(x/90) - 0.3*cos(sqrt(2)*x/150);
 elseif(iSlope == 8)
   alpha = 7 - 3*cos(x/30);
 elseif(iSlope == 9)
   alpha = 2 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope== 10)
   alpha = 4 + 2*sin(x/300) - 2*cos(sqrt(2)*x/200)^2;
 end 
 
%Validation set
elseif (iDataSet == 2)                            
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
 elseif (iSlope == 2)
   alpha = 4 + 0.5*sin(x/100) - cos(sqrt(6)*x/30);
 elseif (iSlope == 3)
   alpha = 2*sin(x/250) + 5;
 elseif (iSlope == 4)
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50) - x/500;
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
   alpha = 3 + sin(x/200) + 2*cos(sqrt(0.5)*x/50);
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end
 
end
