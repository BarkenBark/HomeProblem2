function f = EvaluateIndividual(yHat,functionData)

k = length(yHat);
difference = (yHat(1,:)' - functionData(:,2)).^2;

rms = sqrt(mean(difference));

f = 1/rms;
end

