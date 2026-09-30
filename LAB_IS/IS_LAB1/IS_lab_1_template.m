% Classification using perceptron
clear all
clc
% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
x2=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2];
% estimated features are stored in matrix P:
P=[x1;x2];

%Desired output vector
T=[1;1;1;-1;-1]; % <- ČIA ANKSČIAU BUVO KLAIDA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);
eta = 0.1;
e=1;


% write training algorithm
while e ~= 0 % executes while the total error is not 0
    
    e=0;

    for n= 1:length(T)
        v = x1(n)*w1 + x2(n)*w2 + b;
        if v > 0
        	y = 1;
        else
        	y = -1;
        end
        en = T(n) - y;

        w1 = w1 + eta*en*x1(n);
        w2 = w2 + eta*en*x2(n);
        b = b + eta*en;

        e = e + abs(en);
    end
        
    


  fprintf('The error amount %d\n', e)
end


fprintf('Final w1 = %.6f\n', w1);
fprintf('Final w2 = %.6f\n', w2);
fprintf('Final b  = %.6f\n', b);


% % Testing features
 test_x1 = [hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P3 hsv_value_P4];
% 
test_x2 = [metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P3 metric_P4];
% 
% % Desired outputs
% % A4-A9 = apples = 1
% % P3-P4 = pears = -1
test_T = [1 1 1 1 1 1 -1 -1];
% 
% % Number of errors
 test_errors = 0;
 for n = 1:length(test_T)
     % Calculate Perceptron output
     v = test_x1(n)*w1 + test_x2(n)*w2 + b;
     if v > 0
         y = 1;
     else
         y = -1;
     end
     % Check classification
     if y ~= test_T(n)
         test_errors = test_errors + 1;
         fprintf('Object %d: ERROR (desired = %d, received = %d)\n', ...
             n, test_T(n), y);
     else
         fprintf('Object %d: correct (class = %d)\n', n, y);
     end
 
 end