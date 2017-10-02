%% TestFit
% Hard code best function found
% Output both original data and my best fist
% Produce Error as text in console

dataset = LoadFunctionData;
input = dataset(:,1);
targetOutput = dataset(:,2);

fNumerator = @(x) 54*x + 36;
fDenominator = @(x) 36*x.^2 + 45*x + 32;

f = @(x) fNumerator(x)/fDenominator(x);

y = f(input);

hold on
plot(input, targetOutput)
plot(input, y)

error = Error(targetOutput, y)