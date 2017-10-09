function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

tabuList = zeros(1,50);
path = zeros(1, length(visibility));
startingPoint = randi(length(visibility));
path(1) = startingPoint;
tabuList(1) = startingPoint;

for i = 2:length(visibility)
  nextNode = GetNode(tabuList,pheromoneLevel, visibility, alpha, beta);
  path(i) = nextNode;
  tabuList(i) = nextNode;
end

