function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                            % Training
    if (iSlope == 1)
        alpha = 2 + (x/200) + 1*sin(x/100) + 1*cos(sqrt(2)*x/50);    
    elseif (iSlope == 2)
        alpha = 7 - (x/400) + 1*sin(x/50) - 2*cos(sqrt(3)*x/100);
    elseif (iSlope == 3)
        alpha = 6 - (x/800) - 3*sin(x/200) + cos(sqrt(2)*x/150);
    elseif (iSlope == 4)
        alpha = 7.5 + 1*sin(x/55) - 1*cos(sqrt(1)*x/120);
    elseif (iSlope == 5)
        alpha = 2.5 + 1*sin(x/110) + 1*cos(sqrt(4)*x/80);
    elseif (iSlope == 6)
        alpha = 3 - 1*sin(x/160) - cos(sqrt(5)*x/200);
    elseif (iSlope == 7)
        alpha = 6 - (x/400) + 1*sin(x/40) + 2*cos(sqrt(6)*x/170);
    elseif (iSlope == 8)
        alpha = 7 - 1*sin(x/100) + 1*cos(sqrt(3)*x/60);
    elseif (iSlope == 9)
        alpha = 3 + 1*sin(x/80) - 1*cos(sqrt(5)*x/40);
    elseif (iSlope== 10)
        alpha = 5 - 2*sin(x/70) - 2.5*cos(sqrt(4)*x/100);
    end
    
elseif (iDataSet == 2)                            % Validation
    if (iSlope == 1)
        alpha = 7 - (x/300) + 2*sin(x/75) + 1*cos(sqrt(1)*x/175);    % You may modify this!
    elseif (iSlope == 2)
        alpha = 3 + (x/300) + 2*sin(x/50) - cos(sqrt(5)*x/200);
    elseif (iSlope == 3)
        alpha = 7.8 - 1*sin(x/75) - 1*cos(sqrt(5)*x/120);
    elseif (iSlope == 4)
        alpha = 2 + 1*sin(x/400) + 1*cos(sqrt(5)*x/50);
    elseif (iSlope == 5)
        alpha = 5 - 2*sin(x/50) + 2.5*cos(sqrt(5)*x/200);    % You may modify this!
    end
    
elseif (iDataSet == 3)                           % Test
    if (iSlope == 1)
        alpha = 6 - sin(x/100) - 3*cos(sqrt(7)*x/50);   % You may modify this!
    elseif (iSlope == 2)
        alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(4)*x/140);
    elseif (iSlope == 3)
        alpha = 4 + 2*(x/800) + sin(x/90) + cos(sqrt(5)*x/120);
    elseif (iSlope == 4)
        alpha = 5 + 3*(x/1200) + sin(x/50) + cos(sqrt(6)*x/100);
    elseif (iSlope == 5)
        alpha = 5 + (x/1400) + 2*sin(x/60) + cos(sqrt(7)*x/80); % You may modify this!
    end
end
