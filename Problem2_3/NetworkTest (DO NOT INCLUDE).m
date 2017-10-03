%% networkTest
weightInterval = [-2, 2];
thresholdInterval = weightInterval;

iterations = 10000;
hurr = zeros(2, iterations);
for i = 1:iterations
net = FeedForwardNetwork([3 4 2]);
net.RandomlyInitializeWeights(weightInterval, thresholdInterval);
hurr(:,i) = net.ForwardPropagate([20/25; 5/10; 500/750]);
end
histogram(hurr(1,:))