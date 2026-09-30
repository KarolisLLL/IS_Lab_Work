%%
clc
clear all
close all

%% Iejimo duomenys

x1 = 0.1:1/22:1;
x2 = 0.1:1/22:1;

[X1, X2] = meshgrid(x1, x2);

D = ((1 + 0.6*sin(2*pi*X1/0.7)) + 0.3*sin(2*pi*X2))/2;

%% Pradinis pavirsiaus grafikas

figure
surf(X1, X2, D);

grid on
xlabel('x1');
ylabel('x2');
zlabel('d');
title('Norimas aproksimuoti pavirsius');


%% 

% Pirmas sluoksnis
% 2 iejimai -> 6 paslepti neuronai

% 1 neuronas
w11_1 = rand(1);
w12_1 = rand(1);

% 2 neuronas
w21_1 = rand(1);
w22_1 = rand(1);

% 3 neuronas
w31_1 = rand(1);
w32_1 = rand(1);

% 4 neuronas
w41_1 = rand(1);
w42_1 = rand(1);

% 5 neuronas
w51_1 = rand(1);
w52_1 = rand(1);

% 6 neuronas
w61_1 = rand(1);
w62_1 = rand(1);


% Pirmo sluoksnio poslinkiai

b1_1 = rand(1);
b2_1 = rand(1);
b3_1 = rand(1);
b4_1 = rand(1);
b5_1 = rand(1);
b6_1 = rand(1);


% Antras sluoksnis
% 6 paslepti neuronai -> 1 isejimo neuronas

w11_2 = rand(1);
w12_2 = rand(1);
w13_2 = rand(1);
w14_2 = rand(1);
w15_2 = rand(1);
w16_2 = rand(1);

% Isejimo neurono poslinkis

b1_2 = rand(1);


% Mokymosi koeficientas

eta = 0.1;


%% 


for iter = 1:5000

    for i = 1:length(x1)

        for j = 1:length(x2)

            %% 
            % PIRMAS PASLEPTAS SLUOKSNIS
            % Pasvertos sumos

            v1_1 = x1(i)*w11_1 + x2(j)*w12_1 + b1_1;
            v2_1 = x1(i)*w21_1 + x2(j)*w22_1 + b2_1;
            v3_1 = x1(i)*w31_1 + x2(j)*w32_1 + b3_1;
            v4_1 = x1(i)*w41_1 + x2(j)*w42_1 + b4_1;
            v5_1 = x1(i)*w51_1 + x2(j)*w52_1 + b5_1;
            v6_1 = x1(i)*w61_1 + x2(j)*w62_1 + b6_1;

            % Aktyvacijos funkcijos

            y1_1 = tanh(v1_1);
            y2_1 = tanh(v2_1);
            y3_1 = tanh(v3_1);
            y4_1 = tanh(v4_1);
            y5_1 = tanh(v5_1);
            y6_1 = tanh(v6_1);


            %
            % ANTRAS SLUOKSNIS
    

            % Pasverta suma

            v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2 + b1_2;


            % Tiesine aktyvacijos funkcija

            y1_2 = v1_2;


            % Tinklo isejimas

            y = y1_2;


            %% 
            % KLAIDA


            e = D(j,i) - y;


            %%
            % BACKPROPAGATION

            % Isejimo sluoksnio delta

            delta1_2 = e;


            % Pasleptojo sluoksnio delta

            delta1_1 = (1 - tanh(v1_1)^2) * delta1_2 * w11_2;

            delta2_1 = (1 - tanh(v2_1)^2) * delta1_2 * w12_2;

            delta3_1 = (1 - tanh(v3_1)^2) * delta1_2 * w13_2;

            delta4_1 = (1 - tanh(v4_1)^2) *  delta1_2 * w14_2;

            delta5_1 = (1 - tanh(v5_1)^2) * delta1_2 * w15_2;

            delta6_1 = (1 - tanh(v6_1)^2) * delta1_2 * w16_2;


            %% 
            % ISEJIMO SLUOKSNIO SVORIU ATNAUJINIMAS

            w11_2 = w11_2 + eta*delta1_2*y1_1;
            w12_2 = w12_2 + eta*delta1_2*y2_1;
            w13_2 = w13_2 + eta*delta1_2*y3_1;
            w14_2 = w14_2 + eta*delta1_2*y4_1;
            w15_2 = w15_2 + eta*delta1_2*y5_1;
            w16_2 = w16_2 + eta*delta1_2*y6_1;

            b1_2 = b1_2 + eta*delta1_2;


            %% 
            % PASLEPTOJO SLUOKSNIO SVORIU ATNAUJINIMAS

            % 1 neuronas

            w11_1 = w11_1 + eta*delta1_1*x1(i);
            w12_1 = w12_1 + eta*delta1_1*x2(j);

            % 2 neuronas

            w21_1 = w21_1 + eta*delta2_1*x1(i);
            w22_1 = w22_1 + eta*delta2_1*x2(j);

            % 3 neuronas

            w31_1 = w31_1 + eta*delta3_1*x1(i);
            w32_1 = w32_1 + eta*delta3_1*x2(j);

            % 4 neuronas

            w41_1 = w41_1 + eta*delta4_1*x1(i);
            w42_1 = w42_1 + eta*delta4_1*x2(j);

            % 5 neuronas

            w51_1 = w51_1 + eta*delta5_1*x1(i);
            w52_1 = w52_1 + eta*delta5_1*x2(j);

            % 6 neuronas

            w61_1 = w61_1 + eta*delta6_1*x1(i);
            w62_1 = w62_1 + eta*delta6_1*x2(j);


            %% Poslinkiu atnaujinimas

            b1_1 = b1_1 + eta*delta1_1;
            b2_1 = b2_1 + eta*delta2_1;
            b3_1 = b3_1 + eta*delta3_1;
            b4_1 = b4_1 + eta*delta4_1;
            b5_1 = b5_1 + eta*delta5_1;
            b6_1 = b6_1 + eta*delta6_1;

        end

    end

end


%% 
% TINKLO PATIKRINIMAS PO MOKYMO


Y = zeros(length(x2), length(x1));

for i = 1:length(x1)

    for j = 1:length(x2)

        %% Pirmas sluoksnis

        v1_1 = x1(i)*w11_1 + x2(j)*w12_1 + b1_1;
        v2_1 = x1(i)*w21_1 + x2(j)*w22_1 + b2_1;
        v3_1 = x1(i)*w31_1 + x2(j)*w32_1 + b3_1;
        v4_1 = x1(i)*w41_1 + x2(j)*w42_1 + b4_1;
        v5_1 = x1(i)*w51_1 + x2(j)*w52_1 + b5_1;
        v6_1 = x1(i)*w61_1 + x2(j)*w62_1 + b6_1;


        %% Aktyvacijos funkcijos

        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);


        %% Antras sluoksnis

        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2 + b1_2;


        % Tiesine aktyvacijos funkcija

        y1_2 = v1_2;


        % Tinklo atsakas

        Y(j,i) = y1_2;

    end

end


%%
% APMOKYTO TINKLO PAVIRSIUS

figure
surf(X1, X2, Y);

grid on
xlabel('x1');
ylabel('x2');
zlabel('Y');

title('Neuroninio tinklo aproksimuotas pavirsius');


