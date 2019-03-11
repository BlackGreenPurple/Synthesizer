function cast = ton (noty, doby, fs, akce, nazvy, barva, pocet)
% vstupy:  noty  [matice po sobe znejicich not]
%          doby  [doby zneni not z matice noty]  
%          fs    [vzorkovaci kmitocet]
%          akce  [poslesh/ulozeni jednotlivych vzorku]
%          nazvy [matice s nazvy not]
%          barva [parametr urcujici barvu tonu]
%          pocet [parametr pro posun uvnitr matice nazvu]
%
% vystupy: cast [plna delka vzorku odpovidajiciho sloupce z .txt dokumentu]
%
% Skript je soucasti bakalarske prace           
% 'Nastroj pro porizovani dat pro wave table syntezu' na FEL CVUT.
% Autor: Aleksandr Kartavykh
% Rok: 2018

tony = zeros(1, round(fs*sum(doby)+1));
posun =1;
celk_delka = 0;
% Cyklus ve kterem se postupne vytvari jednotlive noty
for i = 1:length(noty)   
    if doby(i) ~=0
        zvuk = synteza(noty(i), doby(i), fs, barva);% Synteza
        obalton = obalka(zvuk); % ADSR
    if akce == true % Pripadne ulozeni skladby
        nazev = nazvy(pocet)+".wav";
        filename = convertStringsToChars(nazev);
        audiowrite(filename, obalton, 44100);
        pocet = pocet+1;
    end
        tony(posun:posun+length(obalton)-1) = obalton;
        posun = posun+length(obalton);
        celk_delka =celk_delka + length(obalton);
    end
end
           
cast = tony(1:celk_delka);
end