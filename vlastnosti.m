function sample = vlastnosti(vzorek)
% vstupy: vzorek  [zkoumany ton]
%
% vystupy: sample [zkoumany ton]
%          Grafy pro znazorneni vlastnosti tonu
%
% Skript je soucasti bakalarske prace           
% 'Nastroj pro porizovani dat pro wave table syntezu' na FEL CVUT.
% Autor: Aleksandr Kartavykh
% Rok: 2018


L = length(vzorek); %delka matice hodnot vzorku
fs = 44100; %vzorkovaci frekvence
t = 0:1/fs:(L-1)/fs; %delka tonu v sekundach
f = fs*(1:L)/L; %definice rozsahu frekvenci
f1 = f(1:(L-3)/20);
F = fft(vzorek); %vypocet FFT pro zobrazeni spektra vzorku
P2 = abs(F/L); %oboustranne spektrum vzorku
P1 = P2(1:(L-3)/20); %jednostranne spektrum
P1(2:end-1) = 2*P1(2:end-1);
figure;
plot(t,vzorek);
title('Casova zavislost')
xlabel('t [s]')
ylabel('S(t)')
figure;
plot(f1,P1) 
title('Jednostranne amplitudove spectrum')
xlabel('f [Hz]')
ylabel('|P1(f)|')
figure;
spectrogram(vzorek,128,120,128,1e3);
title('Spektrogram')
end