close all
clear all
clc

%% Mokymo duomenu nuskaitymas

pavadinimas = 'train_data.png';

pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 5);

%% Pozymiu perkelimas i matrica

P = cell2mat(pozymiai_tinklo_mokymui);

%% Patikriname matricos dydi

disp('P matricos dydis:')
disp(size(P))

%% Teisingu atsakymu matrica
% 5 eilutes po skaicius 1 2 3 4 5 6 7 8 9

T = [eye(9), eye(9), eye(9), eye(9), eye(9)];

%% RBF tinklo mokymas
% 8 neuronai vietoje 13

tinklas = newrb(P,T,0,1,8);

%% Mokymo duomenu patikrinimas

Y = sim(tinklas, P);

[~, atpazinti] = max(Y);

disp('Atpazinti mokymo skaiciai:')
disp(atpazinti)

%% Testavimo duomenu nuskaitymas

pavadinimas = 'test_data.png';

pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

P2 = cell2mat(pozymiai_patikrai);

%% Testavimo skaiciu atpazinimas

Y2 = sim(tinklas, P2);

[~, atpazinti_testo] = max(Y2);

disp('Atpazinti testo skaiciai:')
disp(atpazinti_testo)

%% Teisingi testo atsakymai

teisingi_testo = [5 1 1 8 6 2 9];

%% Testavimo tikslumas

teisingu_sk = sum(atpazinti_testo == teisingi_testo);

tikslumas = teisingu_sk / length(teisingi_testo) * 100;

disp('Teisingi testo skaiciai:')
disp(teisingi_testo)

fprintf('Teisingai atpazinta: %d is %d\n', teisingu_sk, length(teisingi_testo));
fprintf('Testavimo tikslumas: %.2f %%\n', tikslumas);