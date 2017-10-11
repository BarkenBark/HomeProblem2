%% TestFit
clf

gNumerator = @(x) x.^3 - x.^2 + 1;
gDenominator = @(x) x.^4 - x.^2 + 1;
g = @(x) gNumerator(x)./gDenominator(x);

dataset = LoadFunctionData;
input = dataset(:,1);
targetOutput = dataset(:,2);
y = g(input);
y = round(y, 8); %targetOutput is rounded to 8 decimals

hold on
plot(input, y, 'LineWidth', 2, 'Color', 'cyan')
plot(input, targetOutput, '.', 'Color', 'black')
set(gca, 'FontSize', 12)
legend({'$\hat{g}(x)$', '$g(x)$'}, 'Interpreter', 'latex', 'FontSize', 14)
title('Original data and best fit', 'FontSize', 18)
xlabel('$x$', 'Interpreter', 'Latex', 'FontSize', 18)
ylabel('$y$', 'Interpreter', 'Latex', 'FontSize', 18)

error = Error(targetOutput, y);
fprintf('Total error of fitted function: %d\n', error);