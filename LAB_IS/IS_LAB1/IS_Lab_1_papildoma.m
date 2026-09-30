%% Classification using Naive Bayes Classifier

clear;
clc;


A1 = imread('apple_04.jpg');
A2 = imread('apple_05.jpg');
A3 = imread('apple_06.jpg');
A4 = imread('apple_07.jpg');
A5 = imread('apple_11.jpg');
A6 = imread('apple_12.jpg');
A7 = imread('apple_13.jpg');
A8 = imread('apple_17.jpg');
A9 = imread('apple_19.jpg');



P1 = imread('pear_01.jpg');
P2 = imread('pear_02.jpg');
P3 = imread('pear_03.jpg');
P4 = imread('pear_09.jpg');




hsv_value_A1 = spalva_color(A1);
metric_A1 = apvalumas_roundness(A1);

hsv_value_A2 = spalva_color(A2);
metric_A2 = apvalumas_roundness(A2);

hsv_value_A3 = spalva_color(A3);
metric_A3 = apvalumas_roundness(A3);

hsv_value_A4 = spalva_color(A4);
metric_A4 = apvalumas_roundness(A4);

hsv_value_A5 = spalva_color(A5);
metric_A5 = apvalumas_roundness(A5);

hsv_value_A6 = spalva_color(A6);
metric_A6 = apvalumas_roundness(A6);

hsv_value_A7 = spalva_color(A7);
metric_A7 = apvalumas_roundness(A7);

hsv_value_A8 = spalva_color(A8);
metric_A8 = apvalumas_roundness(A8);

hsv_value_A9 = spalva_color(A9);
metric_A9 = apvalumas_roundness(A9);



hsv_value_P1 = spalva_color(P1);
metric_P1 = apvalumas_roundness(P1);

hsv_value_P2 = spalva_color(P2);
metric_P2 = apvalumas_roundness(P2);

hsv_value_P3 = spalva_color(P3);
metric_P3 = apvalumas_roundness(P3);

hsv_value_P4 = spalva_color(P4);
metric_P4 = apvalumas_roundness(P4);



% Feature 1 - colour
x1 = [hsv_value_A1 hsv_value_A2 hsv_value_A3 ...
      hsv_value_P1 hsv_value_P2];

% Feature 2 - roundness
x2 = [metric_A1 metric_A2 metric_A3 ...
      metric_P1 metric_P2];

T = [1 1 1 -1 -1];



apple_x1 = x1(T == 1);
apple_x2 = x2(T == 1);

pear_x1 = x1(T == -1);
pear_x2 = x2(T == -1);



mean_A_x1 = mean(apple_x1);
mean_A_x2 = mean(apple_x2);

mean_P_x1 = mean(pear_x1);
mean_P_x2 = mean(pear_x2);


% Apples
std_A_x1 = std(apple_x1);
std_A_x2 = std(apple_x2);

% Pears
std_P_x1 = std(pear_x1);
std_P_x2 = std(pear_x2);



P_apple = length(apple_x1) / length(T);

P_pear = length(pear_x1) / length(T);



fprintf('\n----- NAIVE BAYES TRAINING -----\n');

fprintf('\nAPPLE:\n');
fprintf('Mean colour      = %.6f\n', mean_A_x1);
fprintf('Std colour       = %.6f\n', std_A_x1);
fprintf('Mean roundness   = %.6f\n', mean_A_x2);
fprintf('Std roundness    = %.6f\n', std_A_x2);
fprintf('Prior probability = %.2f\n', P_apple);

fprintf('\nPEAR:\n');
fprintf('Mean colour      = %.6f\n', mean_P_x1);
fprintf('Std colour       = %.6f\n', std_P_x1);
fprintf('Mean roundness   = %.6f\n', mean_P_x2);
fprintf('Std roundness    = %.6f\n', std_P_x2);
fprintf('Prior probability = %.2f\n', P_pear);



test_x1 = [hsv_value_A4 hsv_value_A5 hsv_value_A6 ...
           hsv_value_A7 hsv_value_A8 hsv_value_A9 ...
           hsv_value_P3 hsv_value_P4];

test_x2 = [metric_A4 metric_A5 metric_A6 ...
           metric_A7 metric_A8 metric_A9 ...
           metric_P3 metric_P4];

test_T = [1 1 1 1 1 1 -1 -1];

object_names = {'A4','A5','A6','A7','A8','A9','P3','P4'};



test_errors = 0;

fprintf('\n----- TESTING -----\n\n');

for n = 1:length(test_T)

    p_x1_apple = gaussianProbability( ...
        test_x1(n), mean_A_x1, std_A_x1);

    p_x2_apple = gaussianProbability( ...
        test_x2(n), mean_A_x2, std_A_x2);

    probability_apple = ...
        P_apple * p_x1_apple * p_x2_apple;



    p_x1_pear = gaussianProbability( ...
        test_x1(n), mean_P_x1, std_P_x1);

    p_x2_pear = gaussianProbability( ...
        test_x2(n), mean_P_x2, std_P_x2);

    probability_pear = ...
        P_pear * p_x1_pear * p_x2_pear;



    if probability_apple > probability_pear
        y = 1;
    else
        y = -1;
    end



    fprintf('%s: P(apple) = %.6e, P(pear) = %.6e --> ', ...
        object_names{n}, probability_apple, probability_pear);

    if y == 1
        fprintf('APPLE');
    else
        fprintf('PEAR');
    end



    if y ~= test_T(n)

        test_errors = test_errors + 1;
        fprintf('  ERROR\n');

    else

        fprintf('  correct\n');

    end

end



accuracy = ...
    (length(test_T) - test_errors) / length(test_T) * 100;

fprintf('\n-------------------------------\n');
fprintf('Number of errors: %d out of %d\n', ...
    test_errors, length(test_T));

fprintf('Classification accuracy: %.2f %%\n', accuracy);
fprintf('-------------------------------\n');



function p = gaussianProbability(x, mu, sigma)

    if sigma == 0
        sigma = 1e-6;
    end

    p = (1 / (sqrt(2*pi) * sigma)) * ...
        exp(-((x - mu)^2) / (2 * sigma^2));

end