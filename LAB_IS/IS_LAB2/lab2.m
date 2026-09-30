%%
clc
clear all
close all

%% Iejimo duomenys

x = 0.1:1/22:1;

% Norimas atsakas
d = ((1 + 0.6*sin(2*pi*x/0.7)) + ...
     0.3*sin(2*pi*x))/2;

% Pradinis grafikas
figure
plot(x,d,'*');
grid on
xlabel('x');
ylabel('d');
title('Norimas atsakas');

%% Tinklo inicializavimas

% Pirmas sluoksnis
% 1 iejimas -> 6 paslepti neuronai

w11_1 = rand(1);
w21_1 = rand(1);
w31_1 = rand(1);
w41_1 = rand(1);
w51_1 = rand(1);
w61_1 = rand(1);

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

%% Tinklo mokymas

for iter = 1:5000

    for i = 1:length(x)

        %% Pirmas pasleptasis sluoksnis

        % Pasvertos sumos
        v1_1 = x(i) * w11_1 + b1_1;
        v2_1 = x(i) * w21_1 + b2_1;
        v3_1 = x(i) * w31_1 + b3_1;
        v4_1 = x(i) * w41_1 + b4_1;
        v5_1 = x(i) * w51_1 + b5_1;
        v6_1 = x(i) * w61_1 + b6_1;

        % Aktyvacijos funkcijos
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);

        %% Antras sluoksnis

        % Pasverta suma
        v1_2 = y1_1 * w11_2 + ...
               y2_1 * w12_2 + ...
               y3_1 * w13_2 + ...
               y4_1 * w14_2 + ...
               y5_1 * w15_2 + ...
               y6_1 * w16_2 + ...
               b1_2;

        % Tiesine aktyvacijos funkcija
        y1_2 = v1_2;

        % Tinklo isejimas
        y = y1_2;

        %% Klaida

        e = d(i) - y;

        %% Backpropagation

        % Isejimo sluoksnio delta
        delta1_2 = e;

        % Pasleptojo sluoksnio delta
        delta1_1 = (1 - tanh(v1_1)^2) * delta1_2 * w11_2;
        delta2_1 = (1 - tanh(v2_1)^2) * delta1_2 * w12_2;
        delta3_1 = (1 - tanh(v3_1)^2) * delta1_2 * w13_2;
        delta4_1 = (1 - tanh(v4_1)^2) * delta1_2 * w14_2;
        delta5_1 = (1 - tanh(v5_1)^2) * delta1_2 * w15_2;
        delta6_1 = (1 - tanh(v6_1)^2) * delta1_2 * w16_2;

        %% Svoriu atnaujinimas

        % Isejimo sluoksnio svoriai
        w11_2 = w11_2 + eta * delta1_2 * y1_1;
        w12_2 = w12_2 + eta * delta1_2 * y2_1;
        w13_2 = w13_2 + eta * delta1_2 * y3_1;
        w14_2 = w14_2 + eta * delta1_2 * y4_1;
        w15_2 = w15_2 + eta * delta1_2 * y5_1;
        w16_2 = w16_2 + eta * delta1_2 * y6_1;

        b1_2 = b1_2 + eta * delta1_2;

        % Pasleptojo sluoksnio svoriai
        w11_1 = w11_1 + eta * delta1_1 * x(i);
        w21_1 = w21_1 + eta * delta2_1 * x(i);
        w31_1 = w31_1 + eta * delta3_1 * x(i);
        w41_1 = w41_1 + eta * delta4_1 * x(i);
        w51_1 = w51_1 + eta * delta5_1 * x(i);
        w61_1 = w61_1 + eta * delta6_1 * x(i);

        % Pasleptojo sluoksnio poslinkiai
        b1_1 = b1_1 + eta * delta1_1;
        b2_1 = b2_1 + eta * delta2_1;
        b3_1 = b3_1 + eta * delta3_1;
        b4_1 = b4_1 + eta * delta4_1;
        b5_1 = b5_1 + eta * delta5_1;
        b6_1 = b6_1 + eta * delta6_1;

    end

end

%% Tinklo patikrinimas po mokymo

x_new = 0.1:1/22:1;

Y = zeros(1, length(x_new));

for i = 1:length(x_new)

    %% Pirmas sluoksnis

    v1_1 = x_new(i) * w11_1 + b1_1;
    v2_1 = x_new(i) * w21_1 + b2_1;
    v3_1 = x_new(i) * w31_1 + b3_1;
    v4_1 = x_new(i) * w41_1 + b4_1;
    v5_1 = x_new(i) * w51_1 + b5_1;
    v6_1 = x_new(i) * w61_1 + b6_1;

    y1_1 = tanh(v1_1);
    y2_1 = tanh(v2_1);
    y3_1 = tanh(v3_1);
    y4_1 = tanh(v4_1);
    y5_1 = tanh(v5_1);
    y6_1 = tanh(v6_1);

    %% Antras sluoksnis

    v1_2 = y1_1 * w11_2 + ...
           y2_1 * w12_2 + ...
           y3_1 * w13_2 + ...
           y4_1 * w14_2 + ...
           y5_1 * w15_2 + ...
           y6_1 * w16_2 + ...
           b1_2;

    % Tiesine aktyvacijos funkcija
    y1_2 = v1_2;

    % Tinklo atsakas
    Y(i) = y1_2;

end

%% Galutinis grafikas

hold on
plot(x_new,Y,'r','LineWidth',2);

grid on
xlabel('x');
ylabel('y');
title('Daugiasluoksnio perceptrono aproksimacija');

legend('Norimas atsakas', 'Tinklo atsakas');