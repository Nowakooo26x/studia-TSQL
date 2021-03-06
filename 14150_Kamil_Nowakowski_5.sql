USE [master]
GO
/****** Object:  Database [projekt]    Script Date: 02.02.2022 16:46:10 ******/
CREATE DATABASE [projekt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'projekt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\projekt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'projekt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\projekt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [projekt] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [projekt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [projekt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [projekt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [projekt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [projekt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [projekt] SET ARITHABORT OFF 
GO
ALTER DATABASE [projekt] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [projekt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [projekt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [projekt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [projekt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [projekt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [projekt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [projekt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [projekt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [projekt] SET  ENABLE_BROKER 
GO
ALTER DATABASE [projekt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [projekt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [projekt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [projekt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [projekt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [projekt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [projekt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [projekt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [projekt] SET  MULTI_USER 
GO
ALTER DATABASE [projekt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [projekt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [projekt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [projekt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [projekt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [projekt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [projekt] SET QUERY_STORE = OFF
GO
USE [projekt]
GO
/****** Object:  UserDefinedFunction [dbo].[SredniaWartoscDanejKategoriiWMagazynie]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SredniaWartoscDanejKategoriiWMagazynie]
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
GO
/****** Object:  UserDefinedFunction [dbo].[SumaKupionychTowarowDanegoKlienta]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumaKupionychTowarowDanegoKlienta]
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
GO
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Klient] [int] NOT NULL,
	[ID_Produkt] [int] NOT NULL,
	[ID_StatusZamowienia] [int] NOT NULL,
	[data_zamowienia] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_ZamowieniaWTrakcieRealizacji]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_ZamowieniaWTrakcieRealizacji] AS
SELECT *
FROM Zamowienia
WHERE Zamowienia.ID_StatusZamowienia = 1;
GO
/****** Object:  Table [dbo].[Opinia]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opinia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Produkt] [int] NOT NULL,
	[ID_Klient] [int] NOT NULL,
	[ocena] [int] NOT NULL,
	[opis] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_ProduktOpinieSrednia]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_ProduktOpinieSrednia] AS
SELECT Opinia.ID_Produkt, COUNT(Opinia.ID_Produkt) AS Ilosc_opini, AVG(Opinia.ocena) AS srednia_ocen
FROM Opinia
GROUP BY Opinia.ID_Produkt
GO
/****** Object:  Table [dbo].[Klient]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[imie] [nvarchar](50) NOT NULL,
	[nazwisko] [nvarchar](100) NOT NULL,
	[email] [nvarchar](300) NOT NULL,
	[telefon] [nvarchar](20) NOT NULL,
	[adres] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produkt]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produkt](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Marka] [int] NOT NULL,
	[kategoria] [nvarchar](100) NOT NULL,
	[nazwa] [nvarchar](250) NOT NULL,
	[opis] [text] NOT NULL,
	[cena] [decimal](8, 2) NOT NULL,
	[specyfikacja] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sprzedaz]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sprzedaz](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Zamowienia] [int] NOT NULL,
	[data_realizacji] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_Sprzedaz]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sprzedaz]
AS
SELECT Sprzedaz.[data_realizacji], Klient.imie AS klient, Klient.email AS email_klienta, Produkt.nazwa AS nazwa_towaru, Produkt.cena AS cena_towaru
FROM Sprzedaz
INNER JOIN Zamowienia
ON Sprzedaz.ID_Zamowienia = Zamowienia.ID
INNER JOIN Produkt
ON Zamowienia.ID_Produkt = Produkt.ID
INNER JOIN Klient
ON Zamowienia.ID_Klient = Klient.ID;
GO
/****** Object:  UserDefinedFunction [dbo].[WyswietlTowarTanszyNiz]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[WyswietlTowarTanszyNiz]
    (@MaxCena FLOAT)
RETURNS TABLE
AS
RETURN
    SELECT *
    FROM Produkt
    WHERE Produkt.cena < @MaxCena;
GO
/****** Object:  Table [dbo].[Magazyn]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Magazyn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Produkt] [int] NOT NULL,
	[ilosc_sztuk] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marka]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marka](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[producent] [nvarchar](250) NOT NULL,
	[logo_Url] [nvarchar](600) NOT NULL,
	[website_Url] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusZamowienia]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusZamowienia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Klient] ON 

INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (1, N'Kamil', N'Nowakowski', N'nowakooo321@gmail.com', N'519343242', N'ul. Składowa 134 61-888 Poznań')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (2, N'Ewa', N'Dudek', N'EwaDudek@dayrep.com', N'534301046', N'ul. Kanarkowa 2 11-041 Olsztyn')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (3, N'Wacław', N'Piotrowski', N'WaclawPiotrowski@armyspy.com', N'675255051', N'ul. Kuźnicy Kołłątajowskiej 126 31-234 Kraków')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (4, N'Justyna', N'Justyna', N'JustynaSawicka@armyspy.com', N'889851999', N'ul. Wadowicka 58 30-444 Kraków')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (5, N'Zosia', N'Wojciechowska', N'ZosiaWojciechowska@dayrep.com', N'693871262', N'ul. Rapackiego Mariana 109 53-021 Wrocław')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (6, N'Gertruda', N'Adamczyk', N'GertrudaAdamczyk@rhyta.com', N'603693325', N'ul. Gierzyńskiego 14 09-407 Płock')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (7, N'Bożena', N'Symanska', N'RoscislawJablonski@armyspy.com', N'539962645', N'ul. Mińska 133 03-828 Warszawa')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (8, N'Rościsław', N'Jabłoński', N'BozenaSymanska@teleworm.us', N'607857767', N'ul. Altanki 107 80-732 Gdańsk')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (9, N'Ruta ', N'Kalinowska', N'RutaKalinowska@dayrep.com', N'667338523', N'Pl. Bramy Wrocławskiej 96 49-306 Brzeg')
INSERT [dbo].[Klient] ([ID], [imie], [nazwisko], [email], [telefon], [adres]) VALUES (10, N'Justyna', N'Wojciechowska', N'JustynaWojciechowska@teleworm.us', N'727298476', N'ul. Kołodziejska 63 81-164 Gdynia')
SET IDENTITY_INSERT [dbo].[Klient] OFF
GO
SET IDENTITY_INSERT [dbo].[Magazyn] ON 

INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (1, 1, 16)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (2, 2, 6)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (3, 3, 14)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (4, 4, 2)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (5, 5, 3)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (6, 6, 8)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (7, 7, 11)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (8, 8, 12)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (9, 9, 3)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (10, 10, 41)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (11, 11, 26)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (12, 12, 5)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (13, 13, 16)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (14, 14, 11)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (15, 15, 36)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (16, 16, 26)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (17, 17, 19)
INSERT [dbo].[Magazyn] ([ID], [ID_Produkt], [ilosc_sztuk]) VALUES (18, 18, 3)
SET IDENTITY_INSERT [dbo].[Magazyn] OFF
GO
SET IDENTITY_INSERT [dbo].[Marka] ON 

INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (1, N'Intel', N'https://upload.wikimedia.org/wikipedia/commons/0/0e/Intel_logo_%282020%2C_light_blue%29.svg', N'https://www.intel.pl/')
INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (2, N'AMD', N'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/AMD_Logo.svg/2560px-AMD_Logo.svg.png', N'https://www.amd.com/')
INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (3, N'Kingston Fury', N'https://media.kingston.com/europe/press-release/2021/05/Kingston-Fury-Image-1.png', N'https://www.kingston.com/')
INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (4, N'G.Skill', N'https://upload.wikimedia.org/wikipedia/en/7/78/G.Skill.gif', N'https://www.gskill.com/')
INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (5, N'Kingston', N'https://logos-world.net/wp-content/uploads/2020/11/Kingston-Logo.png', N'https://www.kingston.com/')
INSERT [dbo].[Marka] ([ID], [producent], [logo_Url], [website_Url]) VALUES (6, N'Crucial', N'https://www.crucial.com/content/dam/crucial/archive/logos/crucial/web/crucial-logo-w-tag-image.png.transform/medium-png/img.png', N'https://www.crucial.com/')
SET IDENTITY_INSERT [dbo].[Marka] OFF
GO
SET IDENTITY_INSERT [dbo].[Opinia] ON 

INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (1, 1, 2, 5, N'Procesor ok, bustuje spokojnie do 4.3, na stockowym chłodzeniu w testach syntetycznych max 70 stopni, 4 rdzienie 8 wątków idealne do budżetowego kompa')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (2, 1, 4, 5, N'Tani procesor o wydajność zbliżonej a nawet o lepszej do i7 7700k. Za cenę używanej i7 7700k mamy procesor i płytę główną z możliwością przyszłego rozwoju. Podczas użytkowania nie spotkałem się z sytuacją w której ten procesor nie daje sobie rady. Użytkuje tą i3 wraz z Radeonem RX 560 i na spokojnie daje sobie radę w takich tytułach jak: Battlefield 1 40-70 klatek/s Wiedźmin 3 45-65 klatek/s Farming simulator 50-80 klatek/s')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (3, 1, 5, 3, N'Daje radę')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (4, 1, 7, 4, N'Dobry budżetowy procesor daje radę nawet w najnowszych grach')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (5, 2, 1, 5, N'Lepszy wydajnosciowo niz ryzen 5 3600 w grach. Warto dokupic płyte b560 która niedługo wyjdzie, albo z490 (jakąś najtańszą) żeby podkręcic ramy do 3600. Wtedy jest bajka! Boxowe chlodzenie w zupelnosci mu wystarczy, nie przeszkadzają mi wyższe temperatury, bo i tak procek sie nie zużyje. Prędzej komp pojdzie na smietnik. Ani to że jest troche glosniej niz jakbym dokupil lepszy cooler :) Dla mnie najlepszy i najbardziej oplacalny. Kiedys bylem za ryzen 5 3600 ale nie dzisiaj przy ich cenach.')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (6, 2, 3, 2, N'')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (7, 6, 5, 5, N'Świetny procesor. Mam chłodznenie Dark rock 4 pro . Temperatury w Cinebench 66-67 stopni. W grach zależy, ale w RDR2 mam 60~ Oczywiście został zastosowany overvolting, ale wyniki w cinebenchu wzrosły a temperatura drastycznie spadła. Bez żadnej konfiguracji w Bios miałem 90 stopni w Cinebenchu. Jak ktoś nie potrafi posługiwać się Biosem to nie polecam. Po przesiadce z Ryzena 2600 Wydajność w aplikacjach wzrosła drastycznie, do programowania, kompilowania dosłownie 200% lepiej.')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (8, 5, 8, 5, N'Cóż, po przesiadce ze starego i7-4790k ten Ryzen wgniata w ziemię. Nawet przeglądarka internetowa działa odczuwalnie szybciej. Procesor sparowany z chłodzeniem Scythe Mugen 5, pasta TG Kryonaut. Włączony Precision Boost Override (tryb auto), napięcia nie dotykałem, zegary utrzymują się w okolicach 4780MHz na wszystkich rdzeniach. Temperatury przy dużym obciążeniu dochodzą do 84st. Procesor dziwnie wyceniony, mógłby być trochę tańszy, żeby lepiej się wpasować pomiędzy 5600X a 5900X.')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (9, 8, 9, 4, N'Super procesor ale liczyłem na trochę więcej w tej cenie.')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (10, 10, 9, 4, N'Spoko aczkolwiek trzeba ręcznie trzeba przełączyć na taktowanie 3200MHz i czasem to taktowanie lekko spada')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (11, 14, 10, 5, N'polecam')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (12, 16, 10, 4, N'Spełnia swoje zadanie.')
INSERT [dbo].[Opinia] ([ID], [ID_Produkt], [ID_Klient], [ocena], [opis]) VALUES (13, 16, 3, 5, N'Wszystko gites 5/5.')
SET IDENTITY_INSERT [dbo].[Opinia] OFF
GO
SET IDENTITY_INSERT [dbo].[Produkt] ON 

INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (1, 1, N'procesor', N'Procesor Intel Core i3-10100F', N'Procesor Intel Core i3-10100F został stworzony z myślą o każdym użytkowniku komputera osobistego. Jego niewygórowana cena oraz bardzo dobre osiągi powodują, że idealnie sprawdzi się jako sprzęt do gier, pracy, nauki czy rozrywki. Producent zdecydował się na zastosowanie 4-rdzeniowej konstrukcji, dzięki czemu masz pewność, że każda prosta gra komputerowa czy program multimedialny będzie działał na Twoim komputerze bez najmniejszego zacięcia.', CAST(379.00 AS Decimal(8, 2)), N'PRODUKT Producent Intel Kod producenta BX8070110100F EAN Części modyfikowane Płyta główna Płyta główna Usługi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Core i3 Wersja opakowania BOX Załączone chłodzenie Tak DANE TECHNICZNE Typ gniazda Socket 1200 Liczba rdzeni 4 Liczba wątków 8 Częstotliwość taktowania procesora [GHz] 3.6 Częstotliwość maksymalna Turbo [GHz] 4.3 Zintegrowany układ graficzny Nie posiada Odblokowany mnożnik Nie Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Comet Lake TDP [W] 65 Maksymalna temperatura pracy [st. C] 100 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-2666 Pamięć podręczna L1 4 x 32 KB (D) 4 x 32 KB (I) Pamięć podręczna L2 1 MB Pamięć podręczna L3 6 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (2, 1, N'procesor', N'Procesor Intel Core i5-11600K', N'Potrzebujesz wydajnego procesora, który jednocześnie jest idealny do gamingu i do pracy? Chcesz, aby Twój komputer bardzo dobrze funkcjonował nawet przy maksymalnym obciążeniu? W takim wypadku Intel Core i5-11600K został stworzony dla Ciebie. Zaprojektowany został w taki sposób, aby zapewnić komfort użytkowania każdemu graczowi i osobom wykorzystującym komputer do wykonywania codziennych czynności. Ciesz się niezwykłą wydajnością oraz mocą niezależnie od tego, co robisz przy swoim stanowisku.', CAST(1043.13 AS Decimal(8, 2)), N'PRODUKT Producent Intel Kod producenta BX8070811600K EAN 0675901933711 Części modyfikowane Płyta główna Płyta główna Usługi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Core i5 Wersja opakowania BOX Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket 1200 (Rocket Lake) Liczba rdzeni 6 Liczba wątków 12 Częstotliwość taktowania procesora [GHz] 3.9 Częstotliwość maksymalna Turbo [GHz] 4.9 Zintegrowany układ graficzny Intel UHD Graphics 750 Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Rocket Lake TDP [W] 125 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-3200 Pamięć podręczna L1 64 x 32 KB (D) 64 x 32 KB (I) Pamięć podręczna L2 3 MB Pamięć podręczna L3 12 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (3, 1, N'procesor', N'Procesor Intel Core i7-9700K', N'Linia procesorów Intel Core i7 jest polecana do szczególnie wymagających zastosowań. Procesory z tej linii mogą być wyposażone w cztery, sześć lub nawet osiem rdzeni, a modele i7 Extreme nawet w dziesięć rdzeni. Jednostki te dysponują najczęściej sporą pojemnością pamięci podręcznej i doskonałymi parametrami użytkowymi, co czyni je odpowiednim wyborem do komputerów biznesowych, gamingowych, a także do urządzeń służących do projektowania i obróbki multimediów.', CAST(2089.17 AS Decimal(8, 2)), N'PRODUKT Producent Intel Kod producenta BX80684I79700K EAN 0735858394635 INFORMACJE PODSTAWOWE Linia Core i7 Wersja opakowania BOX Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket 1151 (Coffee Lake) Liczba rdzeni 8 Liczba wątków 8 Częstotliwość taktowania procesora [GHz] 3.6 Częstotliwość maksymalna Turbo [GHz] 4.9 Zintegrowany układ graficzny Intel UHD Graphics 630 Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Coffee Lake TDP [W] 95 Maksymalna temperatura pracy [st. C] 100 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-2666 Pamięć podręczna L1 8 x 32 KB (D) 8 x 32 KB (I) Pamięć podręczna L2 2 MB Pamięć podręczna L3 12 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (4, 1, N'procesor', N'Procesor Intel Core i9-10850K', N'Obsługa specjalistycznych programów do obróbki grafiki i wideo, oprogramowania projektowanie i najnowszych gier przestanie być wyzwaniem! Procesor Intel Core i9-10850K został dostosowany do zadań specjalnych. Jego bazowa częstotliwość taktowania wynosi 3600 MHz, natomiast w trybie Turbo może zostać podbita do poziomu nawet 5200 MHz. Wszystko to pozwoli Ci na wykorzystanie ogromnej mocy obliczeniowej wówczas, gdy będzie to najbardziej potrzebne.', CAST(2199.00 AS Decimal(8, 2)), N'PRODUKT Producent Intel Kod producenta BX8070110850K EAN 5032037198851 INFORMACJE PODSTAWOWE Linia Core i9 Wersja opakowania BOX Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket 1200 Liczba rdzeni 10 Liczba wątków 20 Częstotliwość taktowania procesora [GHz] 3.6 Częstotliwość maksymalna Turbo [GHz] 5.2 Zintegrowany układ graficzny Intel UHD Graphics 630 Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 14 Mikroarchitektura procesora Comet Lake TDP [W] 125 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-2933 Pamięć podręczna L1 10 x 32 KB (D) 10 x 32 KB (I) Pamięć podręczna L2 2.5 MB Pamięć podręczna L3 20 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (5, 2, N'procesor', N'Procesor AMD Ryzen 7 5800X', N'Elitarny procesor gamingowy AMD Ryzen 7 5800X przeniesie rozgrywkę na zupełnie nowy poziom. Wykorzystaj moc ośmiu rdzeni, których parametry zoptymalizowano właśnie pod kątem najbardziej wymagających zastosowań.', CAST(1679.00 AS Decimal(8, 2)), N'PRODUKT Producent AMD Kod producenta 100-100000063WOF Części modyfikowane Płyta główna Płyta główna Usługi komputerowe Produkt modyfikowany przez sklep Nie INFORMACJE PODSTAWOWE Linia Ryzen 7 Wersja opakowania BOX Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 8 Liczba wątków 16 Częstotliwość taktowania procesora [GHz] 3.8 Częstotliwość maksymalna Turbo [GHz] 4.7 Zintegrowany układ graficzny Nie posiada Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 3 TDP [W] 105 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-3200 Pamięć podręczna L1 8 x 32 KB (D) 8 x 32 KB (I) Pamięć podręczna L2 4 MB Pamięć podręczna L3 32 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (6, 2, N'procesor', N'Procesor AMD Ryzen 9 5900X', N'Procesor AMD Ryzen 9 5900X to sprzęt najnowszej generacji stworzony na mikroarchitekturze Zen 3. Dzięki 12 rdzeniom i 24 wątkom możesz pracować i grać nawet na największym obciążeniu sprzętu. Została tu zastosowana taka technologia, dzięki której możesz wykorzystać rzeczywistość wirtualną VR. Taktowanie rdzeni określa się na 3.70 GHz, co daje dobrą wydajność i sprawną pracę. Sprzęt posiada również technologię AMD StoreMI oraz AMD Ryzen Master.', CAST(2349.00 AS Decimal(8, 2)), N'PRODUKT Producent AMD Kod producenta 100-100000061WOF INFORMACJE PODSTAWOWE Linia Ryzen 9 Wersja opakowania BOX Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 12 Liczba wątków 24 Częstotliwość taktowania procesora [GHz] 3.7 Częstotliwość maksymalna Turbo [GHz] 4.8 Zintegrowany układ graficzny Nie posiada Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 3 TDP [W] 105 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-3200 Pamięć podręczna L1 12 x 32 KB (D) 12 x 32 KB (I) Pamięć podręczna L2 6 MB Pamięć podręczna L3 64 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (7, 2, N'procesor', N'Procesor AMD Ryzen 7 4700G', N'Wiele rdzeni, wiele wątków i bardzo wysokie taktowanie – wszystko to gwarantuje jeszcze wyższą wydajność AMD Ryzen, dostosowaną do obsługi wszystkich najnowszych gier z segmentu AAA.', CAST(1129.90 AS Decimal(8, 2)), N'PRODUKT Producent AMD Kod producenta 100-000000146 INFORMACJE PODSTAWOWE Linia Ryzen 7 Wersja opakowania OEM Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 8 Liczba wątków 16 Częstotliwość taktowania procesora [GHz] 3.6 Częstotliwość maksymalna Turbo [GHz] 4.4 Zintegrowany układ graficzny AMD Radeon Vega 8 Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 7 Mikroarchitektura procesora Zen 2 TDP [W] 65 Maksymalna temperatura pracy [st. C] 95 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-3200 Pamięć podręczna L1 8 x 32 KB (D) 8 x 32 KB (I) Pamięć podręczna L2 4 MB Pamięć podręczna L3 8 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (8, 2, N'procesor', N'Procesor AMD Ryzen 3 1200 AF', N'Szybkie jak błyskawica procesory AMD Ryzen™ to najlepszy wybór. Dzięki technologii AMD SenseMI procesory Ryzen wykorzystują inteligencję maszynową do zwiększenia swojej mocy obliczeniowej. Procesory Ryzen 3 posiadają aż do 4 rdzeni i 4 wątków, aby zadowolić najbardziej ambitnych użytkowników oraz umożliwić im granie, transmitowanie i tworzenie treści cyfrowych bez spadku wydajności.', CAST(345.00 AS Decimal(8, 2)), N'PRODUKT Producent AMD Kod producenta YD1200BBM4KAF INFORMACJE PODSTAWOWE Linia Ryzen 3 Wersja opakowania OEM Załączone chłodzenie Nie DANE TECHNICZNE Typ gniazda Socket AM4 Liczba rdzeni 4 Liczba wątków 4 Częstotliwość taktowania procesora [GHz] 3.1 Częstotliwość maksymalna Turbo [GHz] 3.4 Zintegrowany układ graficzny Nie posiada Odblokowany mnożnik Tak Architektura [bit] 64 Proces technologiczny [nm] 12 Mikroarchitektura procesora Zen TDP [W] 65 Maksymalna temperatura pracy [st. C] 95 PAMIĘĆ Rodzaje obsługiwanej pamięci DDR4-2933 Pamięć podręczna L1 4 x 32 KB (D) 4 x 64 KB (I) Pamięć podręczna L2 2 MB Pamięć podręczna L3 8 MB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (9, 3, N'ram', N'Pamięć Kingston Fury Beast 8 GB', N'Pamięć Kingston FURY™ Beast DDR4 o częstotliwości taktowania do 3733MHz to potężny ładunek wydajności w grach, edycji materiałów wideo i renderowaniu grafiki. Pamięć o częstotliwości taktowania od 2666MHz do 3733MHz i opóźnieniu od CL15 do CL19 to niedrogi sposób na modernizację komputera. Pojemność pojedynczego modułu wynosi od 4GB do 32GB, a pojemność zestawów od 8GB do 128GB. Pamięć jest wyposażona w funkcję automatycznego przetaktowania Plug N Play do częstotliwości 2666MHz, a także zgodna z technologią Intel XMP i procesorami AMD Ryzen. Chłodzenie pamięci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Każdy moduł pamięci przechodzi testy przy pełnej szybkości i jest objęty wieczystą gwarancją. To bezproblemowe i przystępne cenowo rozwiązanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', CAST(159.00 AS Decimal(8, 2)), N'PRODUKT Producent Kingston Fury Kod producenta KF426C16BB/8 EAN 0740617320183 PODSTAWOWE Linia Beast MODEL Typ złącza UDIMM Konfiguracja Pojedyncza kość TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Tak Pojemność łączna 8 GB Liczba modułów 1 Częstotliwość pracy [MHz] 2666 Opóźnienie CL16 Napięcie [V] 1.2 FIZYCZNE Kolor Czarny Podświetlenie Nie')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (10, 3, N'ram', N'Pamięć Kingston Fury Beast 16 GB', N'Pamięć Kingston FURY™ Beast DDR4 o częstotliwości taktowania do 3733MHz to potężny ładunek wydajności w grach, edycji materiałów wideo i renderowaniu grafiki. Pamięć o częstotliwości taktowania od 2666MHz do 3733MHz i opóźnieniu od CL15 do CL19 to niedrogi sposób na modernizację komputera. Pojemność pojedynczego modułu wynosi od 4GB do 32GB, a pojemność zestawów od 8GB do 128GB. Pamięć jest wyposażona w funkcję automatycznego przetaktowania Plug N Play do częstotliwości 2666MHz, a także zgodna z technologią Intel XMP i procesorami AMD Ryzen. Chłodzenie pamięci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Każdy moduł pamięci przechodzi testy przy pełnej szybkości i jest objęty wieczystą gwarancją. To bezproblemowe i przystępne cenowo rozwiązanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', CAST(365.00 AS Decimal(8, 2)), N'PRODUKT Producent Kingston Fury Kod producenta KF436C17BBK2/16 EAN 0740617319781 PODSTAWOWE Linia Beast MODEL Typ złącza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Tak Pojemność łączna 16 GB Liczba modułów 2 Częstotliwość pracy [MHz] 3600 Opóźnienie CL17 Napięcie [V] 1.35 FIZYCZNE Kolor Czarny Podświetlenie Nie')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (11, 3, N'ram', N'Pamięć Kingston Fury Beast 32 GB', N'Pamięć Kingston FURY™ Beast DDR4 o częstotliwości taktowania do 3733MHz to potężny ładunek wydajności w grach, edycji materiałów wideo i renderowaniu grafiki. Pamięć o częstotliwości taktowania od 2666MHz do 3733MHz i opóźnieniu od CL15 do CL19 to niedrogi sposób na modernizację komputera. Pojemność pojedynczego modułu wynosi od 4GB do 32GB, a pojemność zestawów od 8GB do 128GB. Pamięć jest wyposażona w funkcję automatycznego przetaktowania Plug N Play do częstotliwości 2666MHz, a także zgodna z technologią Intel XMP i procesorami AMD Ryzen. Chłodzenie pamięci FURY Beast DDR4 zapewnia stylowy, niskoprofilowy radiator. Każdy moduł pamięci przechodzi testy przy pełnej szybkości i jest objęty wieczystą gwarancją. To bezproblemowe i przystępne cenowo rozwiązanie przeznaczone do modernizacji systemu z procesorem Intel lub AMD.', CAST(719.00 AS Decimal(8, 2)), N'PRODUKT Producent Kingston Fury Kod producenta KF432C16BBK2/32 EAN 0740617319842 PODSTAWOWE Linia Beast MODEL Typ złącza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Tak Pojemność łączna 32 GB Liczba modułów 2 Częstotliwość pracy [MHz] 3200 Opóźnienie CL16 Napięcie [V] 1.35 FIZYCZNE Kolor Czarny Podświetlenie Nie')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (12, 4, N'ram', N'Pamięć G.Skill Ripjaws V 16 G', N'Pamięć RAM G.Skill Ripjaws V wyróżnia się wysoką częstotliwością działania i to przy standardowych ustawieniach, a wynik ten można jeszcze nieznacznie podkręcić – przy opóźnieniach rzędu CL16 można liczyć na naprawdę wysoką wydajność. Takie parametry zdecydowanie przyspieszą działanie komputera i doskonale sprawdzą się zarówno w codziennej edycji zaawansowanych plików, jak i w grach o wysokich wymaganiach sprzętowych.', CAST(309.00 AS Decimal(8, 2)), N'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-16GVKB EAN PODSTAWOWE Linia Ripjaws V MODEL Typ złącza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Nie Pojemność łączna 16 GB Liczba modułów 2 Częstotliwość pracy [MHz] 3200 Opóźnienie CL16 Napięcie [V] 1.35 FIZYCZNE Kolor Czarny Podświetlenie Nie')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (13, 4, N'ram', N'Pamięć G.Skill Trident Z RGB 16 GB', N'Zaprojektowany i zoptymalizowany pod kątem pełnej kompatybilności z najnowszymi procesorami AMD Ryzen 3000 na płytach głównych z chipsetem AMD X570, Trident Z Neo zapewnia niezrównaną wydajność pamięci i żywe oświetlenie RGB na każdym komputerze do gier lub stacji roboczej z procesorami AMD Ryzen 3000 i płytami głównymi AMD X570', CAST(439.00 AS Decimal(8, 2)), N'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-16GTZR EAN PODSTAWOWE Linia Trident Z RGB MODEL Typ złącza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Nie Pojemność łączna 16 GB Liczba modułów 2 Częstotliwość pracy [MHz] 3200 Opóźnienie CL16 Napięcie [V] 1.35 FIZYCZNE Kolor Czarny Podświetlenie RGB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (14, 4, N'ram', N'Pamięć G.Skill Trident Z RGB 16 GB', N'Pamięć G.Skill Trident Z RGB przeznaczone dla entuzjastów PC i ekstremalnych graczy. Dzięki podświetelniu LED, zapewniają rewelacyjny wygląd. Trident Z oznacza jedną z najwydajniejszych na świecie pamięci DDR4. Pamięci łączą wydajność i piękno.', CAST(799.00 AS Decimal(8, 2)), N'PRODUKT Producent G.Skill Kod producenta F4-3200C16D-32GTZR EAN 4719692015396 PODSTAWOWE Linia Trident Z RGB MODEL Typ złącza UDIMM Konfiguracja Zestaw TECHNICZNE Typ pamięci DDR4 Chłodzenie Radiator Niskoprofilowe Nie Pojemność łączna 32 GB Liczba modułów 2 Częstotliwość pracy [MHz] 3200 Opóźnienie CL16 Napięcie [V] 1.35 FIZYCZNE Kolor Czarny Podświetlenie RGB')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (15, 5, N'dysk', N'Dysk SSD Kingston A400 480 GB', N'Ten dysk poszerzy przestrzeń na kluczowe dane o 480 GB – to dość, by pomieścić sporą kolekcję fotografii, filmy, a także gry i podstawowe kopie zapasowe. Postaw na poręczny, lekki dysk o optymalnej pojemności.', CAST(214.00 AS Decimal(8, 2)), N'PRODUKT Producent Kingston Kod producenta SA400S37/480G EAN 0718929127943 INFORMACJE PODSTAWOWE Model A400 PARAMETRY FIZYCZNE Format dysku 2.5" Grubość [mm] 7 TECHNICZNE Pojemność dysku 480 GB Interfejs SATA III Pamięć podręczna Brak danych Rodzaj kości pamięci TLC Szybkość odczytu 500 MB/s Szybkość zapisu 450 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1 mln godzin TBW (Total Bytes Written) 160 TB Klucz Nie dotyczy Szyfrowanie sprzętowe Nie Kontroler Phison S11 Series')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (16, 5, N'dysk', N'Dysk SSD Kingston A400 960 GB', N'Dysk na którym zmieścisz wiele rzeczy - 480 GB Dyski SSD zdecydowanie przewyższają nośniki HDD, jeśli chodzi o tempo działania, dzięki czemu dostęp do danych jest błyskawiczny. Ten dysk zapewnia optymalną prędkość odczytu danych, dzięki czemu jest tak popularnym wyborem do codziennych zastosowań.', CAST(419.00 AS Decimal(8, 2)), N'PRODUKT Producent Kingston Kod producenta SA400S37/960G EAN 0740617277357 INFORMACJE PODSTAWOWE Model A400 PARAMETRY FIZYCZNE Format dysku 2.5" Grubość [mm] 7 TECHNICZNE Pojemność dysku 960 GB Interfejs SATA III Pamięć podręczna Brak danych Rodzaj kości pamięci TLC Szybkość odczytu 500 MB/s Szybkość zapisu 450 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1 mln godzin TBW (Total Bytes Written) 300 TB Klucz Nie dotyczy Szyfrowanie sprzętowe Nie Kontroler Phison S11 Series')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (17, 6, N'dysk', N'Dysk SSD Crucial MX500 500 GB', N'Szybki zapis danych na poziomie 510 MB/s Tempo zapisu danych może zadecydować o wygodzie korzystania z dysku SSD. Im jest ono wyższe, tym lepiej. Ten nośnik oferuje już całkiem wysokie prędkości zapisu danych. Będzie to więc świetny wybór do komputerów domowych, firmowych i gamingowych. Dysk o tych parametrach zapewni wysoki komfort podczas pracy i rozrywki przy komputerze.', CAST(259.00 AS Decimal(8, 2)), N'PRODUKT Producent Crucial Kod producenta CT500MX500SSD1 INFORMACJE PODSTAWOWE Model MX500 PARAMETRY FIZYCZNE Format dysku 2.5" Grubość [mm] 7 TECHNICZNE Pojemność dysku 500 GB Interfejs SATA III Pamięć podręczna Brak danych Rodzaj kości pamięci TLC Szybkość odczytu 560 MB/s Szybkość zapisu 510 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1.8 mln godzin TBW (Total Bytes Written) 180 TB Klucz Nie dotyczy Szyfrowanie sprzętowe Tak Kontroler Silicon Motion SM2258')
INSERT [dbo].[Produkt] ([ID], [ID_Marka], [kategoria], [nazwa], [opis], [cena], [specyfikacja]) VALUES (18, 6, N'dysk', N'Dysk SSD Crucial MX500 2 TB', N'Zapisuj na swoim nośniku ogromną ilość zdjęć, muzyki i filmów, nie martwiąc się o bezpieczeństwo i komfort ich przeglądania. Dzięki szybkiemu dostępowi do zgromadzonych treści i materiałów, możesz dzielić się wszystkim z najwyższą prędkością.', CAST(919.00 AS Decimal(8, 2)), N'PRODUKT Producent Crucial Kod producenta CT2000MX500SSD1 INFORMACJE PODSTAWOWE Model MX500 PARAMETRY FIZYCZNE Format dysku 2.5" Grubość [mm] 7 TECHNICZNE Pojemność dysku 2 TB Interfejs SATA III Pamięć podręczna Brak danych Rodzaj kości pamięci TLC Szybkość odczytu 560 MB/s Szybkość zapisu 510 MB/s Odczyt Losowy Brak danych Zapis Losowy Brak danych Nominalny czas pracy 1.8 mln godzin TBW (Total Bytes Written) 700 TB Klucz Nie dotyczy Szyfrowanie sprzętowe Tak Kontroler Silicon Motion SM2258')
SET IDENTITY_INSERT [dbo].[Produkt] OFF
GO
SET IDENTITY_INSERT [dbo].[Sprzedaz] ON 

INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (1, 1, CAST(N'2022-01-01T12:53:23.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (2, 2, CAST(N'2022-01-01T19:30:03.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (3, 3, CAST(N'2021-02-12T12:10:03.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (4, 4, CAST(N'2021-07-17T17:24:11.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (5, 5, CAST(N'2021-10-18T10:13:33.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (6, 6, CAST(N'2021-01-04T15:43:01.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (7, 7, CAST(N'2021-11-03T18:16:11.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (8, 8, CAST(N'2021-08-19T08:23:43.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (9, 9, CAST(N'2021-02-21T15:11:31.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (10, 10, CAST(N'2021-02-21T16:11:31.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (11, 11, CAST(N'2021-04-29T20:16:10.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (12, 12, CAST(N'2021-07-11T12:11:31.000' AS DateTime))
INSERT [dbo].[Sprzedaz] ([ID], [ID_Zamowienia], [data_realizacji]) VALUES (13, 13, CAST(N'2021-10-09T10:11:32.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Sprzedaz] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusZamowienia] ON 

INSERT [dbo].[StatusZamowienia] ([ID], [nazwa]) VALUES (1, N'W trakcie realizacji')
INSERT [dbo].[StatusZamowienia] ([ID], [nazwa]) VALUES (2, N'Anulowane')
INSERT [dbo].[StatusZamowienia] ([ID], [nazwa]) VALUES (3, N'Zrealizowane')
SET IDENTITY_INSERT [dbo].[StatusZamowienia] OFF
GO
SET IDENTITY_INSERT [dbo].[Zamowienia] ON 

INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (1, 2, 1, 3, CAST(N'2022-01-01T11:33:23.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (2, 4, 1, 3, CAST(N'2022-01-01T17:41:03.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (3, 5, 1, 3, CAST(N'2021-02-12T11:10:03.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (4, 7, 1, 3, CAST(N'2021-07-17T15:23:10.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (5, 1, 2, 3, CAST(N'2021-10-17T08:13:33.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (6, 3, 2, 3, CAST(N'2021-12-03T12:33:01.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (7, 5, 6, 3, CAST(N'2021-11-03T17:56:11.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (8, 8, 5, 3, CAST(N'2021-08-19T07:13:23.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (9, 9, 8, 3, CAST(N'2021-02-21T13:21:21.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (10, 9, 10, 3, CAST(N'2021-03-30T12:40:01.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (11, 10, 14, 3, CAST(N'2021-04-29T19:56:12.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (12, 10, 16, 3, CAST(N'2021-07-11T11:12:31.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (13, 3, 16, 3, CAST(N'2021-10-08T17:51:38.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (14, 2, 3, 1, CAST(N'2021-03-30T12:40:01.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (15, 2, 10, 1, CAST(N'2021-04-29T12:40:02.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (16, 5, 17, 2, CAST(N'2021-07-11T11:12:31.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (17, 7, 17, 1, CAST(N'2021-10-08T17:51:38.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (18, 5, 17, 1, CAST(N'2021-07-11T12:12:31.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (19, 9, 14, 1, CAST(N'2021-10-08T17:51:38.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (20, 10, 13, 1, CAST(N'2021-10-08T17:31:38.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (21, 10, 13, 1, CAST(N'2021-10-08T17:32:32.000' AS DateTime))
INSERT [dbo].[Zamowienia] ([ID], [ID_Klient], [ID_Produkt], [ID_StatusZamowienia], [data_zamowienia]) VALUES (22, 4, 11, 1, CAST(N'2021-10-08T19:51:38.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Zamowienia] OFF
GO
ALTER TABLE [dbo].[Magazyn]  WITH CHECK ADD FOREIGN KEY([ID_Produkt])
REFERENCES [dbo].[Produkt] ([ID])
GO
ALTER TABLE [dbo].[Opinia]  WITH CHECK ADD FOREIGN KEY([ID_Klient])
REFERENCES [dbo].[Klient] ([ID])
GO
ALTER TABLE [dbo].[Opinia]  WITH CHECK ADD FOREIGN KEY([ID_Produkt])
REFERENCES [dbo].[Produkt] ([ID])
GO
ALTER TABLE [dbo].[Produkt]  WITH CHECK ADD FOREIGN KEY([ID_Marka])
REFERENCES [dbo].[Marka] ([ID])
GO
ALTER TABLE [dbo].[Sprzedaz]  WITH CHECK ADD FOREIGN KEY([ID_Zamowienia])
REFERENCES [dbo].[Zamowienia] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([ID_Klient])
REFERENCES [dbo].[Klient] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([ID_Produkt])
REFERENCES [dbo].[Produkt] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([ID_StatusZamowienia])
REFERENCES [dbo].[StatusZamowienia] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[DodajKlienta]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajKlienta]
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
GO
/****** Object:  StoredProcedure [dbo].[DodajSprzedaz]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajSprzedaz]
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
GO
/****** Object:  StoredProcedure [dbo].[DodajZamowienie]    Script Date: 02.02.2022 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajZamowienie]
	(
    @ID_Klient              int,
	@ID_Produkt             int
    )
AS
BEGIN
	INSERT INTO dbo.Zamowienia ( ID_Klient, ID_Produkt, ID_StatusZamowienia, data_zamowienia ) 
	VALUES ( @ID_Klient, @ID_Produkt, 1, CURRENT_TIMESTAMP )
END
GO
USE [master]
GO
ALTER DATABASE [projekt] SET  READ_WRITE 
GO
