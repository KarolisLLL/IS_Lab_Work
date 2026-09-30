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

% Pradines Gauso funkciju centru reiksmes
c1 = 0.25;
c2 = 0.75;

% Pradines Gauso funkciju spinduliu reiksmes
r1 = 0.2;
r2 = 0.2;

% Isejimo sluoksnio svoriai
w1 = rand(1);
w2 = rand(1);

% Poslinkis
w0 = rand(1);

% Issaugomos pradines reiksmes palyginimui
c1_prad = c1;
c2_prad = c2;
r1_prad = r1;
r2_prad = r2;

%% Mokymosi koeficientai

% Svoriams
eta_w = 0.05;

% Centrams
eta_c = 0.001;

% Spinduliams
eta_r = 0.001;

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


        %% =================================================
        % PARAMETRU POKYCIAI
        % ==================================================

        % Isejimo svoriu pokyciai

        dw1 = eta_w * e * F1;
        dw2 = eta_w * e * F2;
        dw0 = eta_w * e;


        % Centru pokyciai

        dc1 = eta_c * e * w1 * F1 * ...
              (x(i)-c1)/(r1^2);

        dc2 = eta_c * e * w2 * F2 * ...
              (x(i)-c2)/(r2^2);


        % Spinduliu pokyciai

        dr1 = eta_r * e * w1 * F1 * ...
              ((x(i)-c1)^2)/(r1^3);

        dr2 = eta_r * e * w2 * F2 * ...
              ((x(i)-c2)^2)/(r2^3);


        %% =================================================
        % PARAMETRU ATNAUJINIMAS
        % ==================================================

        % Svoriai
        w1 = w1 + dw1;
        w2 = w2 + dw2;
        w0 = w0 + dw0;

        % Centrai
        c1 = c1 + dc1;
        c2 = c2 + dc2;

        % Spinduliai
        r1 = r1 + dr1;
        r2 = r2 + dr2;


        %% Spindulys negali buti 0 arba neigiamas

        if r1 < 0.05
            r1 = 0.05;
        end

        if r2 < 0.05
            r2 = 0.05;
        end

    end

end

%% =========================================================
% TINKLO PATIKRINIMAS PO MOKYMO
% ==========================================================

x_new = 0.1:1/22:1;

Y = zeros(1,length(x_new));

for i = 1:length(x_new)

    % Gauso funkcijos
    F1 = exp(-(x_new(i)-c1)^2/(2*r1^2));

    F2 = exp(-(x_new(i)-c2)^2/(2*r2^2));

    % Tinklo atsakas
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
% REZULTATAI
% ==========================================================

fprintf('\nPRADINES REIKSMES:\n\n');

fprintf('c1 = %.6f\n',c1_prad);
fprintf('c2 = %.6f\n',c2_prad);
fprintf('r1 = %.6f\n',r1_prad);
fprintf('r2 = %.6f\n',r2_prad);


fprintf('\nAPMOKYTO TINKLO PARAMETRAI:\n\n');

fprintf('c1 = %.6f\n',c1);
fprintf('c2 = %.6f\n',c2);

fprintf('r1 = %.6f\n',r1);
fprintf('r2 = %.6f\n',r2);

fprintf('\nw1 = %.6f\n',w1);
fprintf('w2 = %.6f\n',w2);
fprintf('w0 = %.6f\n',w0);


%% =========================================================
% VIDUTINE KVADRATINE KLAIDA
% ==========================================================

E = mean((d-Y).^2);

fprintf('\nVidutine kvadratine klaida E = %.8f\n',E);