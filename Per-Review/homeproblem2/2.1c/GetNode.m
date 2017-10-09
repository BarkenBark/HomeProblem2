function nextNode = GetNode(tabuList,pheromoneLevel, visibility, alpha, beta)
% Will decide which city to travel to.

probabilityNextNode = zeros(length(pheromoneLevel),length(pheromoneLevel));
for i =1:length(pheromoneLevel)
  for j=1:length(pheromoneLevel)
    if ismember(j, tabuList) || i == j % If the city has been visited it wont be able to revisit.
      probabilityNextNode(i,j) = 0;
    else
      probabilityNextNode(i) = (pheromoneLevel(i,j)^alpha)*(visibility(i,j)^beta);
    end
  end
end
sumDenominator = sum(probabilityNextNode);

probabilityNextNode = probabilityNextNode/sumDenominator;

r =rand;
index = 0;
% Will sum probability over all remaining edges. If one sum them all up
% the probability will equal 1.
while index == 0
  k=1;
  sumProbability = sum(probabilityNextNode(1:k));
  if r < sumProbability
    nextNode=k;
    break
  else
    k=k+1;
  end
end
end

