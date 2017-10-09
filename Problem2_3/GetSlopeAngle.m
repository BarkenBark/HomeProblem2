function alpha = GetSlopeAngle(x, iSlope, iDataSet)

%Training set
if (iDataSet == 1)                                
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
 elseif (iSlope == 2)
   alpha = 3 - sin(sqrt(2)*x/150) + cos(sqrt(10)*x/30);
 elseif (iSlope == 3)
   alpha = 4 - sin(x/120) + 2*cos(x/200);
 elseif (iSlope == 4)
   alpha = 5 + sin(sqrt(3)*x/80) - cos(x/50);
 elseif (iSlope == 5)
   alpha = 6 + 0.5*cos(x/100) + 1.5*sin(sqrt(12)*x/50);
 elseif (iSlope == 6)
   alpha = 3.5 + 0.5*sin(x/20) + 1.5*cos(sqrt(9)*x/400);
 elseif (iSlope == 7)
   alpha = 5.5 + 0.8*sin(x/90) - 1.2*cos(sqrt(2)*x/150);
 elseif(iSlope == 8)
   alpha = 7 - cos(x/200) - (x/500);
 elseif(iSlope == 9)
   alpha = 2 + sin(x/150) + (x/500);
 elseif (iSlope== 10)
   alpha = 4 + 1.5*sin(x/300) - 1.5*cos(sqrt(2)*x/200);
 end 
 
%Validation set
elseif (iDataSet == 2)                            
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
 elseif (iSlope == 2)
   alpha = 2 + (x/1000) + 0.5*sin(x/100) - 1.5*cos(sqrt(6)*x/30);
 elseif (iSlope == 3)
   alpha = 4 + sin(x/250) + cos(sqrt(13)*x/70);
 elseif (iSlope == 4)
   alpha = 6 - 1.2*sin(x/60) - 0.8*cos(x/400) - (x/500);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
 end 
 
%Test set
elseif (iDataSet == 3)                         
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/100); 
 elseif (iSlope == 2)
   alpha = 3 + cos(x/40) - sin(sqrt(3)*x/160);
 elseif (iSlope == 3)
   alpha = 5.5 + 1.5*sin(sqrt(20)*x/100) - cos(x/80);
 elseif (iSlope == 4)
   alpha = 1 + (x/500) + sin(x/200);
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end
 
end
