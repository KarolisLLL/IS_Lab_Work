%%
clc
clear all
close all

%% Iejimo duomenys

x = 0.1:1/22:1;

% Norimas atsakas
d = ((1 + 0.6*sin(2*pi*x/0.7)) + ...
     0.3*sin(2*pi*x))/2;

%% Pradinis grafikas

figure
plot(x,d,'*');
grid on
xlabel('x');
ylabel('d');
title('Norimas atsakas');

%% =========================================================
% SBF TINKLO INICIALIZAVIMAS
% ==========================================================

% Gauso funkciju centrai
c1 = 0.2;
c2 = 0.9;

% Gauso funkciju spinduliai
r1 = 0.2;
r2 = 0.2;

% Isejimo sluoksnio svoriai
w1 = rand(1);
w2 = rand(1);

% Poslinkis
w0 = rand(1);

% Mokymosi koeficientas
eta = 0.05;

%% =========================================================
% TINKLO MOKYMAS
% ==========================================================

for iter = 1:5000

    for i = 1:length(x)

        %% Gauso bazines funkcijos

        F1 = exp(-(x(i)-c1)^2/(2*r1^2));

        F2 = exp(-(x(i)-c2)^2/(2*r2^2));

        %% Isejimo neuronas

        % Tiesine aktyvacijos funkcija
        y = F1*w1 + F2*w2 + w0;

        %% Klaida

        e = d(i) - y;

        %% Svoriu atnaujinimas

        w1 = w1 + eta * e * F1;

        w2 = w2 + eta * e * F2;

        w0 = w0 + eta * e;

    end

end

%% =========================================================
% TINKLO PATIKRINIMAS PO MOKYMO
% ==========================================================

x_new = 0.1:1/22:1;

Y = zeros(1,length(x_new));

for i = 1:length(x_new)

    %% Gauso funkcijos

    F1 = exp(-(x_new(i)-c1)^2/(2*r1^2));

    F2 = exp(-(x_new(i)-c2)^2/(2*r2^2));

    %% Tinklo atsakas

    Y(i) = F1*w1 + F2*w2 + w0;

end

%% =========================================================
% GALUTINIS GRAFIKAS
% ==========================================================

hold on

plot(x_new,Y,'r','LineWidth',2);

grid on
xlabel('x');
ylabel('y');

title('SBF tinklo aproksimacija');

legend('Norimas atsakas', ...
       'SBF tinklo atsakas');

%% =========================================================
% GALUTINIAI PARAMETRAI
% ==========================================================

fprintf('\nSBF tinklo parametrai:\n\n');

fprintf('c1 = %.4f\n',c1);
fprintf('c2 = %.4f\n',c2);

fprintf('r1 = %.4f\n',r1);
fprintf('r2 = %.4f\n',r2);

fprintf('\nApmokyti svoriai:\n');

fprintf('w1 = %.6f\n',w1);
fprintf('w2 = %.6f\n',w2);
fprintf('w0 = %.6f\n',w0);

%% =========================================================
% VIDUTINE KVADRATINE KLAIDA
% ==========================================================

E = mean((d-Y).^2);

fprintf('\nVidutine kvadratine klaida E = %.8f\n',E);