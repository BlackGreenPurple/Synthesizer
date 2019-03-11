%==============================BAKALARSKA_PRACE============================%
% Nastroj pro porizovani dat pro wavetable syntezu 
% FEL CVUT
% Letni semestr, Akademicky rok: 2017/2018 
% Autor: Aleksandr Kartavykh
%===========================================================================% 

 close all
 clear all
 clc
 
 %% Synteza vzorku
 clc
 % Nastaveni parametru syntezy
 dokument ='nota.txt'; % Volba .txt souboru
 akce = false; % False - poslech, True - ulozeni
 barva = 2; % 0 - Puvodni barva tonu, 1 - teplejsi ton, 2 - studenejsi ton
 tempo = 68; % Cim je vetsi, tim jsou vzorky kratsi
 
 % Spousteni syntezy
 sample = hlavni(dokument,akce,barva,tempo);
 
 %% Vlastnosti tonu
 clc
 vlastnosti(sample);