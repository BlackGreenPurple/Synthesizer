function ton = synteza (nota, doba, fs, barva)
% vstupy:  nota  [hodnota z matice not]
%          doba  [hodnota z matice dob]  
%          fs    [vzorkovaci kmitocet]
%          barva [parametr urcujici barvu tonu]
%
% vystupy: ton   [zvuk odpovidajici noty s odpovidajicj delkou]
%
% Skript je soucasti bakalarske prace           
% 'Nastroj pro porizovani dat pro wave table syntezu' na FEL CVUT.
% Autor: Aleksandr Kartavykh
% Rok: 2018

lownote = 440 * 2.^((nota-49)/12);
% Alikvotni tony, vzdalenost od hlavniho tonu v pultonech
envharmonics = [0 7 12 16 19 24];
% Zisk kazdeho alikvotniho tonu v dB
envgainsdB = [-8 -16 -20 -900 -75 -36];
if barva == 1
envgainsdB = envgainsdB/8;
elseif barva == 2
        envgainsdB = envgainsdB*2;
end
% Vypocet vysky tonu a alikvotnich tonu
envfreqs = lownote * 2.^(envharmonics/12);
time = 0:1/fs:doba-1/fs;

waves = [];
for it = 1:length(envfreqs)
    waves(it,:) = 10^(envgainsdB(it)/20)*sin(2*pi*envfreqs(it)*time);
end

ton = waves(1,:);
for it = 2:size(waves,1)
    ton = ton + waves(it,:);
end
end