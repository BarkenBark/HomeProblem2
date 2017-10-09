function [ gear, gearRestriction ] = ChangeGear( desiredGearChange, gear, gearRestriction )
% Function to see if we want to change gear, lower gear or increase gear
oldGear = gear;
if gearRestriction <= 0;
  if desiredGearChange >= 0.67
    gear = gear +1;
    if gear >= 10
      gear = 10;
    end
  elseif desiredGearChange <= 0.33
    gear = gear - 1;
    if gear <= 1
      gear = 1;
    end
  else
    gear = gear;
  end
end
% Implement gear change restriction.
% If gear change has happened, it will set cooldown timer to 2 second.

if oldGear ~= gear
  gearRestriction = 2;
end


end

