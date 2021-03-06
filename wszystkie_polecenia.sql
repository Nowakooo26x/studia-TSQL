/*
Deklaracja bazydanych
*/
USE master;
GO
IF DB_ID (N'projekt') IS NOT NULL
DROP DATABASE projekt;
CREATE DATABASE projekt

USE [projekt]

CREATE TABLE [Klient](
    [ID]        [int]          PRIMARY KEY IDENTITY,
    [imie]      nvarchar(50)   NOT NULL,
    [nazwisko]  nvarchar(100)  NOT NULL,
    [email]     nvarchar(300)  NOT NULL,
    [telefon]   nvarchar(20)   NOT NULL,
    [adres]     nvarchar(500)  NOT NULL
)

CREATE TABLE [Marka](
    [ID]            [int]               PRIMARY KEY IDENTITY,
    [producent]     nvarchar(250)       NOT NULL,
    [logo_Url]      nvarchar(600)       NOT NULL,
    [website_Url]   nvarchar(150)       NOT NULL
)

CREATE TABLE [Produkt](
    [ID]                [int]           PRIMARY KEY IDENTITY,
    [ID_Marka]          [int]           NOT NULL FOREIGN KEY REFERENCES Marka(ID),
    [kategoria]         nvarchar(100)   NOT NULL,
    [nazwa]             nvarchar(250)   NOT NULL,
    [opis]              text            NOT NULL,
    [cena]              decimal (8,2)   NOT NULL,
    [specyfikacja]      text            NOT NULL
)

CREATE TABLE [Magazyn](
    [ID]            [int]           PRIMARY KEY IDENTITY,
    [ID_Produkt]    [int]           NOT NULL FOREIGN KEY REFERENCES Produkt(ID),
    [ilosc_sztuk]   [int]           NOT NULL,
)

CREATE TABLE [StatusZamowienia](
    [ID]           [int]          PRIMARY KEY IDENTITY,
    [nazwa]        nvarchar(50)   NOT NULL
)

CREATE TABLE [Zamowienia](
    [ID]                    [int]           PRIMARY KEY IDENTITY,
    [ID_Klient]             [int]           NOT NULL FOREIGN KEY REFERENCES Klient(ID),
    [ID_Produkt]            [int]           NOT NULL FOREIGN KEY REFERENCES Produkt(ID),
    [ID_StatusZamowienia]   [int]           NOT NULL FOREIGN KEY REFERENCES StatusZamowienia(ID),
    [data_zamowienia]       datetime        NOT NULL
)

CREATE TABLE [Sprzedaz](
    [ID]                [int]           PRIMARY KEY IDENTITY,
    [ID_Zamowienia]     [int]           NOT NULL FOREIGN KEY REFERENCES Zamowienia(ID),
    [data_realizacji]   [datetime]      NOT NULL
)

CREATE TABLE [Opinia](
    [ID]                [int]       PRIMARY KEY IDENTITY,
    [ID_Produkt]        [int]       NOT NULL FOREIGN KEY REFERENCES Produkt(ID),
    [ID_Klient]         [int]       NOT NULL FOREIGN KEY REFERENCES Klient(ID),
    [ocena]             [int]       NOT NULL,
    [opis]              text        NOT NULL
    
)

INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Kamil', 'Nowakowski', 'nowakooo321@gmail.com', '519343242', 'ul. Sk??adowa 134 61-888 Pozna??')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Ewa', 'Dudek', 'EwaDudek@dayrep.com', '534301046', 'ul. Kanarkowa 2 11-041 Olsztyn')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Wac??aw', 'Piotrowski', 'WaclawPiotrowski@armyspy.com', '675255051', 'ul. Ku??nicy Ko??????tajowskiej 126 31-234 Krak??w')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Justyna', 'Justyna', 'JustynaSawicka@armyspy.com', '889851999', 'ul. Wadowicka 58 30-444 Krak??w')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Zosia', 'Wojciechowska', 'ZosiaWojciechowska@dayrep.com', '693871262', 'ul. Rapackiego Mariana 109 53-021 Wroc??aw')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Gertruda', 'Adamczyk', 'GertrudaAdamczyk@rhyta.com', '603693325', 'ul. Gierzy??skiego 14 09-407 P??ock')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Bo??ena', 'Symanska', 'RoscislawJablonski@armyspy.com', '539962645', 'ul. Mi??ska 133 03-828 Warszawa')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Ro??cis??aw', 'Jab??o??ski', 'BozenaSymanska@teleworm.us', '607857767', 'ul. Altanki 107 80-732 Gda??sk')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Ruta ', 'Kalinowska', 'RutaKalinowska@dayrep.com', '667338523', 'Pl. Bramy Wroc??awskiej 96 49-306 Brzeg')
INSERT INTO Klient (imie, nazwisko, email, telefon, adres) 
VALUES ('Justyna', 'Wojciechowska', 'JustynaWojciechowska@teleworm.us', '727298476', 'ul. Ko??odziejska 63 81-164 Gdynia')

INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('Intel', 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Intel_logo_%282020%2C_light_blue%29.svg', 'https://www.intel.pl/')
INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('AMD', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/AMD_Logo.svg/2560px-AMD_Logo.svg.png', 'https://www.amd.com/')
INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('Kingston Fury', 'https://media.kingston.com/europe/press-release/2021/05/Kingston-Fury-Image-1.png', 'https://www.kingston.com/')
INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('G.Skill', 'https://upload.wikimedia.org/wikipedia/en/7/78/G.Skill.gif', 'https://www.gskill.com/')
INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('Kingston', 'https://logos-world.net/wp-content/uploads/2020/11/Kingston-Logo.png', 'https://www.kingston.com/')
INSERT INTO Marka (producent, logo_Url, website_Url) 
VALUES ('Crucial', 'https://www.crucial.com/content/dam/crucial/archive/logos/crucial/web/crucial-logo-w-tag-image.png.transform/medium-png/img.png', 'https://www.crucial.com/')


INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (1, 'procesor', 'Procesor Intel Core i3-10100F', 379.00, 'Procesor Intel Core i3-10100F zosta?? stworzony z my??l?? o ka??dym u??ytkowniku komputera osobistego. Jego niewyg??rowana cena oraz bardzo dobre osi??gi powoduj??, ??e idealnie sprawdzi si?? jako sprz??t do gier, pracy, nauki czy rozrywki. Producent zdecydowa?? si?? na zastosowanie 4-rdzeniowej konstrukcji, dzi??ki czemu masz pewno????, ??e ka??da prosta gra komputerowa czy program multimedialny b??dzie dzia??a?? na Twoim komputerze bez najmniejszego zaci??cia.', 'PRODUKT Producent Intel Kod producenta BX8070110100F EAN Cz????ci modyfikowane P??yta g????wna P??yta g????wna Us??ugi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Core i3 Wersja opakowania BOX Za????czone ch??odzenie Tak DANE TECHNICZNE Typ gniazda Socket 1200 Liczba rdzeni 4 Liczba w??tk??w 8 Cz??stotliwo???? taktowania procesora [GHz] 3.6 Cz??stotliwo???? maksymalna Turbo [GHz] 4.3 Zintegrowany uk??ad graficzny Nie posiada Odblokowany mno??nik Nie Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Comet Lake TDP [W] 65 Maksymalna temperatura pracy [st. C] 100 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-2666 Pami???? podr??czna L1 4 x 32 KB (D) 4 x 32 KB (I) Pami???? podr??czna L2 1 MB Pami???? podr??czna L3 6 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (1, 'procesor', 'Procesor Intel Core i5-11600K', 1043.13, 'Potrzebujesz wydajnego procesora, kt??ry jednocze??nie jest idealny do gamingu i do pracy? Chcesz, aby Tw??j komputer bardzo dobrze funkcjonowa?? nawet przy maksymalnym obci????eniu? W takim wypadku Intel Core i5-11600K zosta?? stworzony dla Ciebie. Zaprojektowany zosta?? w taki spos??b, aby zapewni?? komfort u??ytkowania ka??demu graczowi i osobom wykorzystuj??cym komputer do wykonywania codziennych czynno??ci. Ciesz si?? niezwyk???? wydajno??ci?? oraz moc?? niezale??nie od tego, co robisz przy swoim stanowisku.', 'PRODUKT Producent Intel Kod producenta BX8070811600K EAN 0675901933711 Cz????ci modyfikowane P??yta g????wna P??yta g????wna Us??ugi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Core i5 Wersja opakowania BOX Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket 1200 (Rocket Lake) Liczba rdzeni 6 Liczba w??tk??w 12 Cz??stotliwo???? taktowania procesora [GHz] 3.9 Cz??stotliwo???? maksymalna Turbo [GHz] 4.9 Zintegrowany uk??ad graficzny Intel UHD Graphics 750 Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Rocket Lake TDP [W] 125 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-3200 Pami???? podr??czna L1 64 x 32 KB (D) 64 x 32 KB (I) Pami???? podr??czna L2 3 MB Pami???? podr??czna L3 12 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (1, 'procesor', 'Procesor Intel Core i7-9700K', 2089.17, 'Linia procesor??w Intel Core i7 jest polecana do szczeg??lnie wymagaj??cych zastosowa??. Procesory z tej linii mog?? by?? wyposa??one w cztery, sze???? lub nawet osiem rdzeni, a modele i7 Extreme nawet w dziesi???? rdzeni. Jednostki te dysponuj?? najcz????ciej spor?? pojemno??ci?? pami??ci podr??cznej i doskona??ymi parametrami u??ytkowymi, co czyni je odpowiednim wyborem do komputer??w biznesowych, gamingowych, a tak??e do urz??dze?? s??u????cych do projektowania i obr??bki multimedi??w.', 'PRODUKT Producent Intel Kod producenta BX80684I79700K EAN 0735858394635 INFORMACJE PODSTAWOWE Linia Core i7 Wersja opakowania BOX Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket 1151 (Coffee Lake) Liczba rdzeni 8 Liczba w??tk??w 8 Cz??stotliwo???? taktowania procesora [GHz] 3.6 Cz??stotliwo???? maksymalna Turbo [GHz] 4.9 Zintegrowany uk??ad graficzny Intel UHD Graphics 630 Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Coffee Lake TDP [W] 95 Maksymalna temperatura pracy [st. C] 100 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-2666 Pami???? podr??czna L1 8 x 32 KB (D) 8 x 32 KB (I) Pami???? podr??czna L2 2 MB Pami???? podr??czna L3 12 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (1, 'procesor', 'Procesor Intel Core i9-10850K', 2199.00, 'Obs??uga specjalistycznych program??w do obr??bki grafiki i wideo, oprogramowania projektowanie i najnowszych gier przestanie by?? wyzwaniem! Procesor Intel Core i9-10850K zosta?? dostosowany do zada?? specjalnych. Jego bazowa cz??stotliwo???? taktowania wynosi 3600 MHz, natomiast w trybie Turbo mo??e zosta?? podbita do poziomu nawet 5200 MHz. Wszystko to pozwoli Ci na wykorzystanie ogromnej mocy obliczeniowej w??wczas, gdy b??dzie to najbardziej potrzebne.', 'PRODUKT Producent Intel Kod producenta BX8070110850K EAN 5032037198851 INFORMACJE PODSTAWOWE Linia Core i9 Wersja opakowania BOX Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket 1200 Liczba rdzeni 10 Liczba w??tk??w 20 Cz??stotliwo???? taktowania procesora [GHz] 3.6 Cz??stotliwo???? maksymalna Turbo [GHz] 5.2 Zintegrowany uk??ad graficzny Intel UHD Graphics 630 Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Comet Lake TDP [W] 125 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-2933 Pami???? podr??czna L1 10 x 32 KB (D) 10 x 32 KB (I) Pami???? podr??czna L2 2.5 MB Pami???? podr??czna L3 20 MB')


INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (2, 'procesor', 'Procesor AMD Ryzen 7 5800X', 1679.00, 'Elitarny procesor gamingowy AMD Ryzen 7 5800X przeniesie rozgrywk?? na zupe??nie nowy poziom. Wykorzystaj moc o??miu rdzeni, kt??rych parametry zoptymalizowano w??a??nie pod k??tem najbardziej wymagaj??cych zastosowa??.', 'PRODUKT Producent AMD Kod producenta 100-100000063WOF Cz????ci modyfikowane P??yta g????wna P??yta g????wna Us??ugi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Ryzen 7 Wersja opakowania BOX Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 8 Liczba w??tk??w 16 Cz??stotliwo???? taktowania procesora [GHz] 3.8 Cz??stotliwo???? maksymalna Turbo [GHz] 4.7 Zintegrowany uk??ad graficzny Nie posiada Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 3 TDP [W] 105 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-3200 Pami???? podr??czna L1 8 x 32 KB (D) 8 x 32 KB (I) Pami???? podr??czna L2 4 MB Pami???? podr??czna L3 32 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (2, 'procesor', 'Procesor AMD Ryzen 9 5900X', 2349.00, 'Procesor AMD Ryzen 9 5900X to sprz??t najnowszej generacji stworzony na mikroarchitekturze Zen 3. Dzi??ki 12 rdzeniom i 24 w??tkom mo??esz pracowa?? i gra?? nawet na najwi??kszym obci????eniu sprz??tu. Zosta??a tu zastosowana taka technologia, dzi??ki kt??rej mo??esz wykorzysta?? rzeczywisto???? wirtualn?? VR. Taktowanie rdzeni okre??la si?? na 3.70 GHz, co daje dobr?? wydajno???? i sprawn?? prac??. Sprz??t posiada r??wnie?? technologi?? AMD StoreMI oraz AMD Ryzen Master.', 'PRODUKT Producent AMD Kod producenta 100-100000061WOF INFORMACJE PODSTAWOWE Linia Ryzen 9 Wersja opakowania BOX Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 12 Liczba w??tk??w 24 Cz??stotliwo???? taktowania procesora [GHz] 3.7 Cz??stotliwo???? maksymalna Turbo [GHz] 4.8 Zintegrowany uk??ad graficzny Nie posiada Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 3 TDP [W] 105 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-3200 Pami???? podr??czna L1 12 x 32 KB (D) 12 x 32 KB (I) Pami???? podr??czna L2 6 MB Pami???? podr??czna L3 64 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (2, 'procesor', 'Procesor AMD Ryzen 7 4700G', 1129.90, 'Wiele rdzeni, wiele w??tk??w i bardzo wysokie taktowanie ??? wszystko to gwarantuje jeszcze wy??sz?? wydajno???? AMD Ryzen, dostosowan?? do obs??ugi wszystkich najnowszych gier z segmentu AAA.', 'PRODUKT Producent AMD Kod producenta 100-000000146 INFORMACJE PODSTAWOWE Linia Ryzen 7 Wersja opakowania OEM Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 8 Liczba w??tk??w 16 Cz??stotliwo???? taktowania procesora [GHz] 3.6 Cz??stotliwo???? maksymalna Turbo [GHz] 4.4 Zintegrowany uk??ad graficzny AMD Radeon Vega 8 Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 2 TDP [W] 65 Maksymalna temperatura pracy [st. C] 95 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-3200 Pami???? podr??czna L1 8 x 32 KB (D) 8 x 32 KB (I) Pami???? podr??czna L2 4 MB Pami???? podr??czna L3 8 MB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (2, 'procesor', 'Procesor AMD Ryzen 3 1200 AF', 345.00, 'Szybkie jak b??yskawica procesory AMD Ryzen??? to najlepszy wyb??r. Dzi??ki technologii AMD SenseMI procesory Ryzen wykorzystuj?? inteligencj?? maszynow?? do zwi??kszenia swojej mocy obliczeniowej. Procesory Ryzen 3 posiadaj?? a?? do 4 rdzeni i 4 w??tk??w, aby zadowoli?? najbardziej ambitnych u??ytkownik??w oraz umo??liwi?? im granie, transmitowanie i tworzenie tre??ci cyfrowych bez spadku wydajno??ci.', 'PRODUKT Producent AMD Kod producenta YD1200BBM4KAF INFORMACJE PODSTAWOWE Linia Ryzen 3 Wersja opakowania OEM Za????czone ch??odzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 4 Liczba w??tk??w 4 Cz??stotliwo???? taktowania procesora [GHz] 3.1 Cz??stotliwo???? maksymalna Turbo [GHz] 3.4 Zintegrowany uk??ad graficzny Nie posiada Odblokowany mno??nik Tak Architektura [bit] 64 Proces technologiczny [nm] 12 Mikroarchitektura procesora Zen TDP [W] 65 Maksymalna temperatura pracy [st. C] 95 PAMI???? Rodzaje obs??ugiwanej pami??ci DDR4-2933 Pami???? podr??czna L1 4 x 32 KB (D) 4 x 64 KB (I) Pami???? podr??czna L2 2 MB Pami???? podr??czna L3 8 MB')


INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (3, 'ram', 'Pami???? Kingston Fury Beast 8 GB', 159.00, 'Pami???? Kingston FURY??? Beast DDR4 o cz??stotliwo??ci taktowania do 3733MHz to pot????ny ??adunek wydajno??ci w grach, edycji materia????w wideo i renderowaniu grafiki. Pami???? o cz??stotliwo??ci taktowania od 2666MHz do 3733MHz i op????nieniu od CL15 do CL19 to niedrogi spos??b na modernizacj?? komputera. Pojemno???? pojedynczego modu??u wynosi od 4GB do 32GB, a pojemno???? zestaw??w od 8GB do 128GB. Pami???? jest wyposa??ona w funkcj?? automatycznego przetaktowania Plug N Play do cz??stotliwo??ci 2666MHz, a tak??e zgodna z technologi?? Intel XMP i procesorami AMD Ryzen. Ch??odzenie pami??ci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Ka??dy modu?? pami??ci przechodzi testy przy pe??nej szybko??ci i jest obj??ty wieczyst?? gwarancj??. To bezproblemowe i przyst??pne cenowo rozwi??zanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', 'PRODUKT Producent Kingston Fury Kod producenta KF426C16BB/8 EAN 0740617320183 PODSTAWOWE Linia Beast MODEL Typ z????cza UDIMM Konfiguracja Pojedyncza ko???? TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Tak Pojemno???? ????czna 8 GB Liczba modu????w 1 Cz??stotliwo???? pracy [MHz] 2666 Op????nienie CL16 Napi??cie [V] 1.2 FIZYCZNE Kolor Czarny Pod??wietlenie Nie')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (3, 'ram', 'Pami???? Kingston Fury Beast 16 GB', 365.00, 'Pami???? Kingston FURY??? Beast DDR4 o cz??stotliwo??ci taktowania do 3733MHz to pot????ny ??adunek wydajno??ci w grach, edycji materia????w wideo i renderowaniu grafiki. Pami???? o cz??stotliwo??ci taktowania od 2666MHz do 3733MHz i op????nieniu od CL15 do CL19 to niedrogi spos??b na modernizacj?? komputera. Pojemno???? pojedynczego modu??u wynosi od 4GB do 32GB, a pojemno???? zestaw??w od 8GB do 128GB. Pami???? jest wyposa??ona w funkcj?? automatycznego przetaktowania Plug N Play do cz??stotliwo??ci 2666MHz, a tak??e zgodna z technologi?? Intel XMP i procesorami AMD Ryzen. Ch??odzenie pami??ci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Ka??dy modu?? pami??ci przechodzi testy przy pe??nej szybko??ci i jest obj??ty wieczyst?? gwarancj??. To bezproblemowe i przyst??pne cenowo rozwi??zanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', 'PRODUKT Producent Kingston Fury Kod producenta KF436C17BBK2/16 EAN 0740617319781 PODSTAWOWE Linia Beast MODEL Typ z????cza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Tak Pojemno???? ????czna 16 GB Liczba modu????w 2 Cz??stotliwo???? pracy [MHz] 3600 Op????nienie CL17 Napi??cie [V] 1.35 FIZYCZNE Kolor Czarny Pod??wietlenie Nie')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (3, 'ram', 'Pami???? Kingston Fury Beast 32 GB', 719.00, 'Pami???? Kingston FURY??? Beast DDR4 o cz??stotliwo??ci taktowania do 3733MHz to pot????ny ??adunek wydajno??ci w grach, edycji materia????w wideo i renderowaniu grafiki. Pami???? o cz??stotliwo??ci taktowania od 2666MHz do 3733MHz i op????nieniu od CL15 do CL19 to niedrogi spos??b na modernizacj?? komputera. Pojemno???? pojedynczego modu??u wynosi od 4GB do 32GB, a pojemno???? zestaw??w od 8GB do 128GB. Pami???? jest wyposa??ona w funkcj?? automatycznego przetaktowania Plug N Play do cz??stotliwo??ci 2666MHz, a tak??e zgodna z technologi?? Intel XMP i procesorami AMD Ryzen. Ch??odzenie pami??ci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Ka??dy modu?? pami??ci przechodzi testy przy pe??nej szybko??ci i jest obj??ty wieczyst?? gwarancj??. To bezproblemowe i przyst??pne cenowo rozwi??zanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', 'PRODUKT Producent Kingston Fury Kod producenta KF432C16BBK2/32 EAN 0740617319842 PODSTAWOWE Linia Beast MODEL Typ z????cza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Tak Pojemno???? ????czna 32 GB Liczba modu????w 2 Cz??stotliwo???? pracy [MHz] 3200 Op????nienie CL16 Napi??cie [V] 1.35 FIZYCZNE Kolor Czarny Pod??wietlenie Nie')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (4, 'ram', 'Pami???? G.Skill Ripjaws V 16 G', 309.00, 'Pami???? RAM G.Skill Ripjaws V wyr????nia si?? wysok?? cz??stotliwo??ci?? dzia??ania i to przy standardowych ustawieniach, a wynik ten mo??na jeszcze nieznacznie podkr??ci?? ??? przy op????nieniach rz??du CL16 mo??na liczy?? na naprawd?? wysok?? wydajno????. Takie parametry zdecydowanie przyspiesz?? dzia??anie komputera i doskonale sprawdz?? si?? zar??wno w codziennej edycji zaawansowanych plik??w, jak i w grach o wysokich wymaganiach sprz??towych.', 'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-16GVKB EAN PODSTAWOWE Linia Ripjaws V MODEL Typ z????cza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Nie Pojemno???? ????czna 16 GB Liczba modu????w 2 Cz??stotliwo???? pracy [MHz] 3200 Op????nienie CL16 Napi??cie [V] 1.35 FIZYCZNE Kolor Czarny Pod??wietlenie Nie')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (4, 'ram', 'Pami???? G.Skill Trident Z RGB 16 GB', 439.00, 'Zaprojektowany i zoptymalizowany pod k??tem pe??nej kompatybilno??ci z najnowszymi procesorami AMD Ryzen 3000 na p??ytach g????wnych z chipsetem AMD X570, Trident Z Neo zapewnia niezr??wnan?? wydajno???? pami??ci i ??ywe o??wietlenie RGB na ka??dym komputerze do gier lub stacji roboczej z procesorami AMD Ryzen 3000 i p??ytami g????wnymi AMD X570', 'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-16GTZR EAN PODSTAWOWE Linia Trident Z RGB MODEL Typ z????cza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Nie Pojemno???? ????czna 16 GB Liczba modu????w 2 Cz??stotliwo???? pracy [MHz] 3200 Op????nienie CL16 Napi??cie [V] 1.35 FIZYCZNE Kolor Czarny Pod??wietlenie RGB')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (4, 'ram', 'Pami???? G.Skill Trident Z RGB 16 GB', 799.00, 'Pami???? G.Skill Trident Z RGB przeznaczone dla entuzjast??w PC i ekstremalnych graczy. Dzi??ki pod??wietelniu LED, zapewniaj?? rewelacyjny wygl??d. Trident Z oznacza jedn?? z najwydajniejszych na ??wiecie pami??ci DDR4. Pami??ci ????cz?? wydajno???? i pi??kno.', 'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-32GTZR EAN 4719692015396 PODSTAWOWE Linia Trident Z RGB MODEL Typ z????cza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pami??ci DDR4 Ch??odzenie Radiator Niskoprofilowe Nie Pojemno???? ????czna 32 GB Liczba modu????w 2 Cz??stotliwo???? pracy [MHz] 3200 Op????nienie CL16 Napi??cie [V] 1.35 FIZYCZNE Kolor Czarny Pod??wietlenie RGB')


INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (5, 'dysk', 'Dysk SSD Kingston A400 480 GB', 214.00, 'Ten dysk poszerzy przestrze?? na kluczowe dane o 480 GB ??? to do????, by pomie??ci?? spor?? kolekcj?? fotografii, filmy, a tak??e gry i podstawowe kopie zapasowe. Postaw na por??czny, lekki dysk o optymalnej pojemno??ci.', 'PRODUKT Producent Kingston Kod producenta SA400S37/480G EAN 0718929127943 INFORMACJE PODSTAWOWE Model A400 PARAMETRY FIZYCZNE Format dysku 2.5" Grubo???? [mm] 7 TECHNICZNE Pojemno???? dysku 480 GB Interfejs SATA III Pami???? podr??czna Brak danych Rodzaj ko??ci pami??ci TLC Szybko???? odczytu 500 MB/s Szybko???? zapisu 450 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1 mln godzin TBW (Total Bytes Written) 160 TB Klucz Nie dotyczy Szyfrowanie sprz??towe Nie Kontroler Phison S11 Series')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (5, 'dysk', 'Dysk SSD Kingston A400 960 GB', 419.00, 'Dysk na kt??rym zmie??cisz wiele rzeczy - 480 GB Dyski SSD zdecydowanie przewy??szaj?? no??niki HDD, je??li chodzi o tempo dzia??ania, dzi??ki czemu dost??p do danych jest b??yskawiczny. Ten dysk zapewnia optymaln?? pr??dko???? odczytu danych, dzi??ki czemu jest tak popularnym wyborem do codziennych zastosowa??.', 'PRODUKT Producent Kingston Kod producenta SA400S37/960G EAN 0740617277357 INFORMACJE PODSTAWOWE Model A400 PARAMETRY FIZYCZNE Format dysku 2.5" Grubo???? [mm] 7 TECHNICZNE Pojemno???? dysku 960 GB Interfejs SATA III Pami???? podr??czna Brak danych Rodzaj ko??ci pami??ci TLC Szybko???? odczytu 500 MB/s Szybko???? zapisu 450 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1 mln godzin TBW (Total Bytes Written) 300 TB Klucz Nie dotyczy Szyfrowanie sprz??towe Nie Kontroler Phison S11 Series')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (6, 'dysk', 'Dysk SSD Crucial MX500 500 GB', 259.0, 'Szybki zapis danych na poziomie 510 MB/s Tempo zapisu danych mo??e zadecydowa?? o wygodzie korzystania z dysku SSD. Im jest ono wy??sze, tym lepiej. Ten no??nik oferuje ju?? ca??kiem wysokie pr??dko??ci zapisu danych. B??dzie to wi??c ??wietny wyb??r do komputer??w domowych, firmowych i gamingowych. Dysk o tych parametrach zapewni wysoki komfort podczas pracy i rozrywki przy komputerze.', 'PRODUKT Producent Crucial Kod producenta CT500MX500SSD1 INFORMACJE PODSTAWOWE Model MX500 PARAMETRY FIZYCZNE Format dysku 2.5" Grubo???? [mm] 7 TECHNICZNE Pojemno???? dysku 500 GB Interfejs SATA III Pami???? podr??czna Brak danych Rodzaj ko??ci pami??ci TLC Szybko???? odczytu 560 MB/s Szybko???? zapisu 510 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1.8 mln godzin TBW (Total Bytes Written) 180 TB Klucz Nie dotyczy Szyfrowanie sprz??towe Tak Kontroler Silicon Motion SM2258')

INSERT INTO Produkt (ID_Marka, kategoria, nazwa, cena, opis, specyfikacja) 
VALUES (6, 'dysk', 'Dysk SSD Crucial MX500 2 TB', 919.00, 'Zapisuj na swoim no??niku ogromn?? ilo???? zdj????, muzyki i film??w, nie martwi??c si?? o bezpiecze??stwo i komfort ich przegl??dania. Dzi??ki szybkiemu dost??powi do zgromadzonych tre??ci i materia????w, mo??esz dzieli?? si?? wszystkim z najwy??sz?? pr??dko??ci??.', 'PRODUKT Producent Crucial Kod producenta CT2000MX500SSD1 INFORMACJE PODSTAWOWE Model MX500 PARAMETRY FIZYCZNE Format dysku 2.5" Grubo???? [mm] 7 TECHNICZNE Pojemno???? dysku 2 TB Interfejs SATA III Pami???? podr??czna Brak danych Rodzaj ko??ci pami??ci TLC Szybko???? odczytu 560 MB/s Szybko???? zapisu 510 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1.8 mln godzin TBW (Total Bytes Written) 700 TB Klucz Nie dotyczy Szyfrowanie sprz??towe Tak Kontroler Silicon Motion SM2258')


INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (1, 2, 5, 'Procesor ok, bustuje spokojnie do 4.3, na stockowym ch??odzeniu w testach syntetycznych max 70 stopni, 4 rdzienie 8 w??tk??w idealne do bud??etowego kompa')
INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (1, 4, 5, 'Tani procesor o wydajno???? zbli??onej a nawet o lepszej do i7 7700k. Za cen?? u??ywanej i7 7700k mamy procesor i p??yt?? g????wn?? z mo??liwo??ci?? przysz??ego rozwoju. Podczas u??ytkowania nie spotka??em si?? z sytuacj?? w kt??rej ten procesor nie daje sobie rady. U??ytkuje t?? i3 wraz z Radeonem RX 560 i na spokojnie daje sobie rad?? w takich tytu??ach jak: Battlefield 1 40-70 klatek/s Wied??min 3 45-65 klatek/s Farming simulator 50-80 klatek/s')
INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (1, 5, 3, 'Daje rad??')
INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (1, 7, 4, 'Dobry bud??etowy procesor daje rad?? nawet w najnowszych grach')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (2, 1, 5, 'Lepszy wydajnosciowo niz ryzen 5 3600 w grach. Warto dokupic p??yte b560 kt??ra nied??ugo wyjdzie, albo z490 (jak???? najta??sz??) ??eby podkr??cic ramy do 3600. Wtedy jest bajka! Boxowe chlodzenie w zupelnosci mu wystarczy, nie przeszkadzaj?? mi wy??sze temperatury, bo i tak procek sie nie zu??yje. Pr??dzej komp pojdzie na smietnik. Ani to ??e jest troche glosniej niz jakbym dokupil lepszy cooler :) Dla mnie najlepszy i najbardziej oplacalny. Kiedys bylem za ryzen 5 3600 ale nie dzisiaj przy ich cenach.')
INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (2, 3, 2, '')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (6, 5, 5, '??wietny procesor. Mam ch??odznenie Dark rock 4 pro . Temperatury w Cinebench 66-67 stopni. W grach zale??y, ale w RDR2 mam 60~ Oczywi??cie zosta?? zastosowany overvolting, ale wyniki w cinebenchu wzros??y a temperatura drastycznie spad??a. Bez ??adnej konfiguracji w Bios mia??em 90 stopni w Cinebenchu. Jak kto?? nie potrafi pos??ugiwa?? si?? Biosem to nie polecam. Po przesiadce z Ryzena 2600 Wydajno???? w aplikacjach wzros??a drastycznie, do programowania, kompilowania dos??ownie 200% lepiej.')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (5, 8, 5, 'C????, po przesiadce ze starego i7-4790k ten Ryzen wgniata w ziemi??. Nawet przegl??darka internetowa dzia??a odczuwalnie szybciej. Procesor sparowany z ch??odzeniem Scythe Mugen 5, pasta TG Kryonaut. W????czony Precision Boost Override (tryb auto), napi??cia nie dotyka??em, zegary utrzymuj?? si?? w okolicach 4780MHz na wszystkich rdzeniach. Temperatury przy du??ym obci????eniu dochodz?? do 84st. Procesor dziwnie wyceniony, m??g??by by?? troch?? ta??szy, ??eby lepiej si?? wpasowa?? pomi??dzy 5600X a 5900X.')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (8, 9, 4, 'Super procesor ale liczy??em na troch?? wi??cej w tej cenie.')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (10, 9, 4, 'Spoko aczkolwiek trzeba r??cznie trzeba prze????czy?? na taktowanie 3200MHz i czasem to taktowanie lekko spada')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (14, 10, 5, 'polecam')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (16, 10, 4, 'Spe??nia swoje zadanie.')

INSERT INTO Opinia (ID_Produkt, ID_Klient, ocena, opis ) 
VALUES (16, 3, 5, 'Wszystko gites 5/5.')

INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk) 
VALUES ( 1, 16 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 2, 6 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 3, 14 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 4, 2 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 5, 3 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 6, 8 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 7, 11 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 8, 12 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 9, 3 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 10, 41 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 11, 26 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 12, 5 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 13, 16 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 14, 11 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 15, 36 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 16, 26 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 17, 19 )
INSERT INTO Magazyn (ID_Produkt, ilosc_sztuk ) 
VALUES ( 18, 3 )


INSERT INTO StatusZamowienia (nazwa) 
VALUES ( 'W trakcie realizacji' )
INSERT INTO StatusZamowienia (nazwa) 
VALUES ( 'Anulowane' )
INSERT INTO StatusZamowienia (nazwa) 
VALUES ( 'Zrealizowane' )


INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 2, 1, 3, '2022-01-01 11:33:23' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 4, 1, 3, '2022-01-01 17:41:03' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 5, 1, 3, '2021-02-12 11:10:03' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 7, 1, 3, '2021-07-17 15:23:10' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 1, 2, 3, '2021-10-17 08:13:33' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 3, 2, 3, '2021-12-03  12:33:01' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 5, 6, 3, '2021-11-03 17:56:11' )

INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 8, 5, 3, '2021-08-19 7:13:23' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 9, 8, 3, '2021-02-21 13:21:21' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 9, 10, 3, '2021-03-30 12:40:01' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 10, 14, 3, '2021-04-29 19:56:12' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 10, 16, 3, '2021-07-11 11:12:31' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 3, 16, 3, '2021-10-08 17:51:38' )

INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 2, 3, 1, '2021-03-30 12:40:01' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 2, 10, 1, '2021-04-29 12:40:02' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 5, 17, 2, '2021-07-11 11:12:31' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 7, 17, 1, '2021-10-08 17:51:38' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 5, 17, 1, '2021-07-11 12:12:31' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 9, 14, 1, '2021-10-08 17:51:38' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 10, 13, 1, '2021-10-08 17:31:38' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 10, 13, 1, '2021-10-08 17:32:32' )
INSERT INTO Zamowienia (ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia) 
VALUES ( 4, 11, 1, '2021-10-08 19:51:38' )


INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 1, '2022-01-01 12:53:23')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 2, '2022-01-01 19:30:03')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 3, '2021-02-12 12:10:03')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 4, '2021-07-17 17:24:11')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 5, '2021-10-18 10:13:33')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 6, '2021-1-04  15:43:01')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 7, '2021-11-03 18:16:11')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 8, '2021-08-19 8:23:43')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 9, '2021-02-21 15:11:31')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 10, '2021-02-21 16:11:31')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 11, '2021-04-29 20:16:10')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 12, '2021-07-11 12:11:31')
INSERT INTO Sprzedaz ( ID_Zamowienia, data_realizacji ) 
VALUES ( 13, '2021-10-09 10:11:32')
/*
Widok 1
*/
CREATE VIEW view_ZamowieniaWTrakcieRealizacji AS
SELECT *
FROM Zamowienia
WHERE Zamowienia.ID_StatusZamowienia = 1;

SELECT *
FROM view_ZamowieniaWTrakcieRealizacji


/*
Widok 2
*/
CREATE VIEW view_ProduktOpinieSrednia AS
SELECT Opinia.ID_Produkt, COUNT(Opinia.ID_Produkt) AS Ilosc_opini, AVG(Opinia.ocena) AS srednia_ocen
FROM Opinia
GROUP BY Opinia.ID_Produkt

SELECT *
FROM view_ProduktOpinieSrednia

/*
Widok 3
*/
CREATE VIEW view_Sprzedaz
AS
SELECT Sprzedaz.[data_realizacji], Klient.imie AS klient, Klient.email AS email_klienta, Produkt.nazwa AS nazwa_towaru, Produkt.cena AS cena_towaru
FROM Sprzedaz
INNER JOIN Zamowienia
ON Sprzedaz.ID_Zamowienia = Zamowienia.ID
INNER JOIN Produkt
ON Zamowienia.ID_Produkt = Produkt.ID
INNER JOIN Klient
ON Zamowienia.ID_Klient = Klient.ID;

SELECT * FROM  view_Sprzedaz


/*
Procedura 1
*/
CREATE PROCEDURE DodajKlienta
	(
    @Imie nvarchar (50),
	@Nazwisko nvarchar (100),
	@Email nvarchar (300),
	@Telefon nvarchar (20),
	@Adres nvarchar (500)
    )
AS
BEGIN
	INSERT INTO dbo.Klient (imie, nazwisko, email, telefon, adres) 
	VALUES ( @Imie, @Nazwisko, @Email, @Telefon, @Adres)
END

EXECUTE DodajKlienta 'Agnieszka', 'Szczepa??ska', 'Szczepanska@jourrapide.com', '675747906', 'ul. Dobra 130 42-400 Zawiercie'


/*
Procedura 2
*/
CREATE PROCEDURE DodajZamowienie
	(
    @ID_Klient              int,
	@ID_Produkt             int
    )
AS
BEGIN
	INSERT INTO dbo.Zamowienia ( ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia ) 
	VALUES ( @ID_Klient, @ID_Produkt, 1, CURRENT_TIMESTAMP )
END

EXECUTE DodajZamowienie 1, 10


/*
Procedura 3
*/
CREATE PROCEDURE DodajSprzedaz
	(
    @ID_Zamowienia      int
    )
AS
BEGIN
	INSERT INTO dbo.Sprzedaz ( ID_Zamowienia, data_realizacji ) 
	VALUES ( @ID_Zamowienia, CURRENT_TIMESTAMP )

    UPDATE Zamowienia
    SET ID_StatusZamowienia = 3
    WHERE iD = @ID_Zamowienia;

    UPDATE Magazyn 
    SET Magazyn.ilosc_sztuk = Magazyn.ilosc_sztuk - 1
    FROM Magazyn
    INNER JOIN Produkt
        ON Magazyn.ID_Produkt = Produkt.ID
    WHERE Magazyn.ID_Produkt = Produkt.ID 
    AND Produkt.ID = (SELECT ID_Produkt FROM Zamowienia WHERE Zamowienia.ID = @ID_Zamowienia)
END

EXECUTE DodajSprzedaz 15


/*
Funkcja 1
*/
CREATE FUNCTION SumaKupionychTowarowDanegoKlienta
    (@KlientID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Wynik INT
    SET @Wynik = (
        SELECT SUM(Produkt.cena)
        FROM Zamowienia
        INNER JOIN Produkt
        ON Zamowienia.ID_Produkt = Produkt.ID
        WHERE ID_Klient = @KlientID AND ID_StatusZamowienia = 3
    )
    RETURN @Wynik
END

SELECT [dbo].[SumaKupionychTowarowDanegoKlienta] (10)


/*
Funkcja 2
*/
CREATE FUNCTION SredniaWartoscDanejKategoriiWMagazynie
    (@KategoriaName nvarchar(100))
RETURNS FLOAT
AS
BEGIN
    DECLARE @Suma FLOAT
    SET @Suma = (
            SELECT SUM(Produkt.cena)
            FROM Produkt
            WHERE Produkt.kategoria = @KategoriaName
            GROUP BY Produkt.kategoria
    )
    DECLARE @Ilosc FLOAT
    SET @Ilosc = (
            SELECT COUNT(Produkt.ID)
            FROM Produkt
            WHERE Produkt.kategoria = @KategoriaName
            GROUP BY Produkt.kategoria
    )
    DECLARE @Wynik FLOAT
    SET @Wynik = (@Suma / @Ilosc)
    RETURN @Wynik
END

SELECT [dbo].[SredniaWartoscDanejKategoriiWMagazynie] ('procesor')


/*
Funkcja 3
*/
CREATE FUNCTION WyswietlTowarTanszyNiz
    (@MaxCena FLOAT)
RETURNS TABLE
AS
RETURN
    SELECT *
    FROM Produkt
    WHERE Produkt.cena < @MaxCena;

SELECT *
FROM WyswietlTowarTanszyNiz(900.00)


/*
Instrukcja 1
*/
SELECT *
FROM Klient
WHERE Klient.imie LIKE '%a';
/*
Instrukcja 2
*/
SELECT *
FROM Klient
WHERE Klient.adres LIKE '%Krak??w%'
/*
Instrukcja 3
*/
SELECT * 
FROM Opinia
WHERE ocena IN (4, 3, 2);
/*
Instrukcja 4
*/
SELECT Produkt.ID, Produkt.nazwa, Produkt.cena
FROM Produkt
WHERE Produkt.cena BETWEEN 400.00 AND 900.00;
/*
Instrukcja 5
*/
SELECT Produkt.nazwa FROM Produkt
UNION
SELECT Marka.producent FROM Marka
/*
Instrukcja 6
*/
SELECT Produkt.kategoria, COUNT(Produkt.ID) AS ilosc_modeli
FROM Produkt
GROUP BY Produkt.kategoria
ORDER BY ilosc_modeli ASC
/*
Instrukcja 7
*/
SELECT Marka.producent, Produkt.cena, Magazyn.ilosc_sztuk, ( Magazyn.ilosc_sztuk * Produkt.cena ) AS SUMA
FROM Marka
INNER JOIN Produkt
ON Marka.ID = Produkt.ID_Marka
INNER JOIN Magazyn
ON Produkt.ID = Magazyn.ID_Produkt
GROUP BY Marka.producent
/*
Instrukcja 8
*/
SELECT Klient.ID, Klient.imie, Klient.email, COUNT(Produkt.ID) AS ilosc_zamowien, SUM(Produkt.cena) AS suma_pieniedzy
FROM Zamowienia
INNER JOIN Klient
ON Zamowienia.ID_Klient = Klient.ID
INNER JOIN Produkt
ON Zamowienia.ID_Produkt = Produkt.ID
WHERE Zamowienia.ID_StatusZamowienia = 1 OR Zamowienia.ID_StatusZamowienia = 3
GROUP BY  Klient.ID, Klient.imie, Klient.email
/*
Instrukcja 9
*/
SELECT SUM(Magazyn.ilosc_sztuk) AS ilosc_towaru
FROM Magazyn
/*
Instrukcja 10
*/
SELECT TOP 5 Klient.ID, Zamowienia.data_zamowienia,Klient.imie + ' '+ Klient.nazwisko  as imie_nazwisko, Klient.email, StatusZamowienia.nazwa
FROM Zamowienia
INNER JOIN StatusZamowienia
ON Zamowienia.ID_StatusZamowienia = StatusZamowienia.ID
INNER JOIN Klient
ON Zamowienia.ID_Klient = Klient.ID
WHERE Zamowienia.ID_StatusZamowienia = 1;