function sample = hlavni(dokument,akce,barva,tempo)
% vstupy:  dokument [textovy soubor s informacemi pro vytvoreni vzorku]
%          akce     [poslesh/ulozeni jednotlivych vzorku]  
%          barva    [puvodni/teplejsi/studenejsi ton]
%
% vystupy: sample   [vysledny ton/tony]
%
% Skript je soucasti bakalarske prace           
% 'Nastroj pro porizovani dat pro wave table syntezu' na FEL CVUT.
% Autor: Aleksandr Kartavykh
% Rok: 2018

% Deklarace not pro nasledujici prepocet na frekvenci
c1=16; d1=18; e1=20; f1=21; g1=23; a1=25; b1=27;
c2=28; d2=30; e2=32; f2=33; g2=35; a2=37; b2=39;
c3=40; d3=42; e3=44; f3=45; g3=47; a3=49; b3=51; 
c4=52; d4=54; e4=56; f4=57; g4=59; a4=61; b4=63;
c5=64; d5=66; e5=68; f5=69; g5=71; a5=73; b5=75; 
c6=76; O=12; B=21;

file = textread(dokument, '%s', 'delimiter', '\n', 'whitespace', ''); 
fs = 44100; % vzorkovaci frekvence pro vytvareny zvuk
pocet = 1;
koef_doby =(60/tempo)/(1/4); %urceni koeficientu doby

tonu_najednou = zeros(1, length(file));% Urceni maximalniho poctu tonu znejicich najednou

CELK_DOBA = 0;
for i=1:length(file)
    radek = char(file(i));
    data = strread(radek,'%s','delimiter','// ');
    tonu_najednou(i)=length(data)/3;   
    if tonu_najednou(i)>1
    fprintf('Nalezen akord, ulozeni neni povoleno \n') % Oznameni, ze ulozeni neni povoleno
    akce = false;
    end
end

nejvic_tonu_najednou = round(max(tonu_najednou));
% Vytvoreni vzorku
vzorek = [];
for j=1:nejvic_tonu_najednou
    posun = 1;% Promenna pro posun uvnitr matice
    nazvy = strings;
    noty = [];
    doby = [];
    % Cteni jednotlivych not a jejich delek v prislusnem sloupci
    for i=1:length(file)
        radek = char(file(i));
        data = strread(radek,'%s','delimiter','// ');
        if length(data) == 1 % Kvuli radkum neobsahujicim pozadovana data
            continue
        end 
        % Naplneni matic "noty", "nazvy" a "doby" udaji z .txt souboru
        if length(data)/3>=j   
           nota = char(data(3*j-2));
           nazev = string(nota);
           if nota ~='x'
                noty(posun) = eval(nota);
                nazvy(posun) = nazev;
            else
                noty(posun) = 0; 
           end
           doba=str2double(char(data(3*j-1)));
           doby(posun) = koef_doby.*1/(doba);
        end
        posun = posun+1;
    end
    % Volani funkce ton,ktera generuje ton
    vzorek = ton(noty, doby, fs, akce, nazvy, barva, pocet);
    if j == 1% Vsechny tony jsou shromazdeny v jedne spolecne matici pro prehravani
        tony = zeros(nejvic_tonu_najednou, length(vzorek));
    end
    for i=1:length(vzorek)
    tony(j,i) = vzorek(i);
    end
end
% Pokud mame tony znejici najednou, sectou se jednoltive tony
if size(tony, 1) == 1
   vzorek = tony(1, :);
else
   vzorek = sum(tony); 
end
vzorek=vzorek/max(abs(vzorek));
sample = vzorek;
if akce == false
    fprintf('Prehravam %s \n',dokument(1:end-4)) % Prehravani 
    soundsc((sample), fs);
end 

