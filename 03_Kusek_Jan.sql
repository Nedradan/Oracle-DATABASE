------------------------------------------------------
-- BAZY DANYCH I
--
-- SQL
--
-- DB server: Oracle 12c
--
-- Lab 03
--
-- Kusek Jan 12K1
------------------------------------------------------
-- Wywolanie skryptu w SQLPlus:
-- @"D:\bazy\skrypty\Lk_03_Kusek_Jan.sql"
CLEAR SCREEN;
CLEAR SCREEN;
PROMPT ;
PROMPT logowanie
PROMPT ;
--
--connect ####
--
--
PROMPT ;
PROMPT Kasowanie tabel;
PROMPT ;

DELETE FROM TROFEA;
DROP TABLE TROFEA;

DELETE FROM ROZEGRANE_MECZE;
DROP TABLE ROZEGRANE_MECZE;

DELETE FROM TURNIEJE;
DROP TABLE TURNIEJE;

DELETE FROM MIEJSCA;
DROP TABLE MIEJSCA;

DELETE FROM DRUZYNY;
DROP TABLE DRUZYNY;

DELETE FROM SZACHOWE_LICENCJE;
DROP TABLE SZACHOWE_LICENCJE;

DELETE FROM ZWIAZKI;
DROP TABLE ZWIAZKI;

DELETE FROM OSOBY;
DROP TABLE OSOBY;

DELETE FROM ADRESY;
DROP TABLE ADRESY;

DELETE FROM KATEGORIE;
DROP TABLE KATEGORIE;

DELETE FROM SEZON;
DROP TABLE SEZON;



PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE SEZON;
PROMPT----------------------------------------;
PROMPT ;

create table SEZON
(
SEZ_ID number(4) NOT NULL,
SEZ_ROK_ROZPOCZECIA date NOT NULL,
SEZ_ROK_ZAKOŃCZENIA date NOT NULL,
SEZ_RODZAJ varchar2(20)
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key SEZON;
PROMPT----------------------------------------;
PROMPT ;

alter table SEZON
add constraint PK_SEZON
primary key (SEZ_ID);






PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE KATEGORIE;
PROMPT----------------------------------------;
PROMPT ;

create table KATEGORIE
(
KAT_ID number(4) NOT NULL,
KAT_TYP varchar2(20) NOT NULL,
KAT_RANGA varchar2(20) NOT NULL
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key KATEGORIE;
PROMPT----------------------------------------;
PROMPT ;

alter table KATEGORIE
add constraint PK_KATEGORIE
primary key (KAT_ID);



PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE ADRESY;
PROMPT----------------------------------------;
PROMPT ;

create table ADRESY
(
ADR_ID number(4) NOT NULL,
ADR_MIEJSCOWOSC varchar2(80) NOT NULL,
ADR_KOD_POCZTOWY varchar2(20) NOT NULL,
ADR_ULICA varchar2(80),
ADR_NR_DOMU varchar2(10) NOT NULL,
ADR_NR_MIESZKANIA varchar2(10)
);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key;
PROMPT----------------------------------------;
PROMPT ;

alter table ADRESY
add constraint PK_ADRESY
primary key (ADR_ID);




PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE OSOBY;
PROMPT----------------------------------------;
PROMPT ;

create table OSOBY
(
OSO_ID number(4) NOT NULL,
OSO_IMIE1 varchar2(80) NOT NULL,
OSO_NAZWISKO varchar2(20) NOT NULL,
OSO_PESEL char(11) NOT NULL,
ADR_ID number(4) NOT NULL
);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key OSOBY;
PROMPT----------------------------------------;
PROMPT ;

alter table OSOBY
add constraint PK_OSOBY
primary key (OSO_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Unique Key OSOBY;
PROMPT----------------------------------------;
PROMPT ;
alter table OSOBY
add constraint UQ_OSOBY
unique (OSO_PESEL);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key OSOBY;
PROMPT----------------------------------------;
PROMPT ;
alter table OSOBY add constraint FK_OSOBY_ADR_ID
foreign key (ADR_ID)
references ADRESY (ADR_ID); 


PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE ZWIAZKI;
PROMPT----------------------------------------;
PROMPT ;
create table ZWIAZKI
(
ZWI_ID number(4) NOT NULL,
ZWI_NAZWA varchar2(20) NOT NULL,
ADR_ID number(4) NOT NULL
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key ZWIAZKI;
PROMPT----------------------------------------;
PROMPT ;

alter table ZWIAZKI
add constraint PK_ZWIAZKI
primary key (ZWI_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key ZWIAZKI;
PROMPT----------------------------------------;
PROMPT ;
alter table ZWIAZKI add constraint FK_ZWIAZKI_ADR_ID
foreign key (ADR_ID)
references ADRESY (ADR_ID); 





PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE SZACHOWE_LICENCJE;
PROMPT----------------------------------------;
PROMPT ;
create table SZACHOWE_LICENCJE
(
SZA_ID number(4) NOT NULL,
SZA_DATA_UZYSKANIA date NOT NULL,
OSO_ID number(4) NOT NULL,
KAT_ID number(4) NOT NULL,
ZWI_ID number(4) NOT NULL
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key SZACHOWE_LICENCJE;
PROMPT----------------------------------------;
PROMPT ;

alter table SZACHOWE_LICENCJE
add constraint PK_SZACHOWE_LICENCJE
primary key (SZA_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key SZACHOWE_LICENCJE1;
PROMPT----------------------------------------;
PROMPT ;
alter table SZACHOWE_LICENCJE add constraint FK_SZACHOWE_LICENCJE_OSO_ID
foreign key (OSO_ID)
references OSOBY (OSO_ID)
on delete cascade; 

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key SZACHOWE_LICENCJE2;
PROMPT----------------------------------------;
PROMPT ;
alter table SZACHOWE_LICENCJE add constraint FK_SZACHOWE_LICENCJE_KAT_ID
foreign key (KAT_ID)
references KATEGORIE (KAT_ID)
on delete cascade;  
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key SZACHOWE_LICENCJE3;
PROMPT----------------------------------------;
PROMPT ;
alter table SZACHOWE_LICENCJE add constraint FK_SZACHOWE_LICENCJE_ZWI_ID
foreign key (ZWI_ID)
references ZWIAZKI (ZWI_ID)
on delete cascade; 



PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE DRUZYNY;
PROMPT----------------------------------------;
PROMPT ;
create table DRUZYNY
(
DRU_ID number(4) NOT NULL,
DRU_NAZWA varchar2(50) NOT NULL,
OSO_ID1 number(4) NOT NULL,
OSO_ID2 number(4) NOT NULL,
OSO_ID3 number(4) NOT NULL,
OSO_ID4 number(4) NOT NULL,
SEZ_ID number(4) NOT NULL
);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key DRUZYNY;
PROMPT----------------------------------------;
PROMPT ;

alter table DRUZYNY
add constraint PK_DRUZYNY
primary key (DRU_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY1;
PROMPT----------------------------------------;
PROMPT ;
alter table DRUZYNY add constraint FK_DRUZYNY_OSO_ID1
foreign key (OSO_ID1)
references OSOBY (OSO_ID);
--domyslnie jest on delete no restrict 

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY2;
PROMPT----------------------------------------;
PROMPT ;
alter table DRUZYNY add constraint FK_DRUZYNY_OSO_ID2
foreign key (OSO_ID2)
references OSOBY (OSO_ID);
--domyslnie jest on delete no restrict  
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY3;
PROMPT----------------------------------------;
PROMPT ;
alter table DRUZYNY add constraint FK_DRUZYNY_OSO_ID3
foreign key (OSO_ID3)
references OSOBY (OSO_ID);
--domyslnie jest on delete no restrict
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY4;
PROMPT----------------------------------------;
PROMPT ;
alter table DRUZYNY add constraint FK_DRUZYNY_OSO_ID4
foreign key (OSO_ID4)
references OSOBY (OSO_ID);
--domyslnie jest on delete no restrict 
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY5;
PROMPT----------------------------------------;
PROMPT ;
alter table DRUZYNY add constraint FK_DRUZYNY_SEZ_ID
foreign key (SEZ_ID)
references SEZON (SEZ_ID); 


PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE MIEJSCA;
PROMPT----------------------------------------;
PROMPT ;
create table MIEJSCA
(
MIE_ID number(4) NOT NULL,
MIE_ILOSC_ZEGAROW number(4) NOT NULL,
MIE_ZAKWATEROWANIE 	char(3) NOT NULL,
ADR_ID number(4) NOT NULL,
ZWI_ID number(4) NOT NULL
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key MIEJSCA;
PROMPT----------------------------------------;
PROMPT ;

alter table MIEJSCA
add constraint PK_MIEJSCA
primary key (MIE_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key MIEJSCA1;
PROMPT----------------------------------------;
PROMPT ;
alter table MIEJSCA add constraint FK_MIEJSCA_ADR_ID
foreign key (ADR_ID)
references ADRESY (ADR_ID)
on delete cascade; 
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key MIEJSCA2;
PROMPT----------------------------------------;
PROMPT ;
alter table MIEJSCA add constraint FK_MIEJSCA_ZWI_ID
foreign key (ZWI_ID)
references ZWIAZKI (ZWI_ID);
--domyslnie jest on delete no restrict;






PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE TURNIEJE;
PROMPT----------------------------------------;
PROMPT ;
create table TURNIEJE
(
TUR_ID number(4) NOT NULL,
TUR_NAZWA varchar2(40) NOT NULL,
TUR_ILOSC_MIEJSC number(4) NOT NULL,
KAT_ID number(4) NOT NULL,
MIE_ID number(4) NOT NULL
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key TURNIEJE;
PROMPT----------------------------------------;
PROMPT ;

alter table TURNIEJE
add constraint PK_TURNIEJE
primary key (TUR_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key TURNIEJE1;
PROMPT----------------------------------------;
PROMPT ;
alter table TURNIEJE add constraint FK_TURNIEJE_ADR_ID
foreign key (KAT_ID)
references KATEGORIE (KAT_ID);
--domyslnie jest on delete no restrict
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key TURNIEJE2;
PROMPT----------------------------------------;
PROMPT ;
alter table TURNIEJE add constraint FK_TURNIEJE_MIE_ID
foreign key (MIE_ID)
references MIEJSCA (MIE_ID);
--domyslnie jest on delete no restrict
 



 
 
PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE ROZEGRANE_MECZE;
PROMPT----------------------------------------;
PROMPT ;
create table ROZEGRANE_MECZE
(
ROZ_ID number(4) NOT NULL,
TUR_ID number(4) NOT NULL,
OSO_ID1 number(4),
OSO_ID2 number(4),
OSO_ID3 number(4) NOT NULL,
ROZ_WYNIK number(1) NOT NULL,
ROZ_CZAS_TRWANIA_MIN number(4) NOT NULL,
SEZ_ID number(4) NOT NULL
);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key ROZEGRANE_MECZE;
PROMPT----------------------------------------;
PROMPT ;

alter table ROZEGRANE_MECZE
add constraint PK_ROZEGRANE_MECZE
primary key (ROZ_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key ROZEGRANE_MECZE1;
PROMPT----------------------------------------;
PROMPT ;
alter table ROZEGRANE_MECZE add constraint FK_ROZEGRANE_MECZE_OSO_ID1
foreign key (OSO_ID1)
references OSOBY (OSO_ID)
on delete set null;

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key ROZEGRANE_MECZE2;
PROMPT----------------------------------------;
PROMPT ;
alter table ROZEGRANE_MECZE add constraint FK_ROZEGRANE_MECZE_OSO_ID2
foreign key (OSO_ID2)
references OSOBY (OSO_ID)
on delete set null;
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key DRUZYNY3;
PROMPT----------------------------------------;
PROMPT ;
alter table ROZEGRANE_MECZE add constraint FK_ROZEGRANE_MECZE_OSO_ID3
foreign key (OSO_ID3)
references OSOBY (OSO_ID);
--domyslnie jest on delete no restrict
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key ROZEGRANE_MECZE4;
PROMPT----------------------------------------;
PROMPT ;
alter table ROZEGRANE_MECZE add constraint FK_ROZEGRANE_MECZE_TUR_ID
foreign key (TUR_ID)
references TURNIEJE (TUR_ID);
--domyslnie jest on delete no restrict
PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key ROZEGRANE_MECZE5;
PROMPT----------------------------------------;
PROMPT ;
alter table ROZEGRANE_MECZE add constraint FK_ROZEGRANE_MECZE_SEZ_ID
foreign key (SEZ_ID)
references SEZON (SEZ_ID);
--domyslnie jest on delete no restrict



PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE TROFEA;
PROMPT----------------------------------------;
PROMPT ;
create table TROFEA
(
TRO_ID number(4) NOT NULL,
TUR_ID number(4) NOT NULL,
DRU_ID number(4) NOT NULL,
SEZ_ID number(4) NOT NULL
);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key TROFEA;
PROMPT----------------------------------------;
PROMPT ;

alter table TROFEA
add constraint PK_TROFEA
primary key (TRO_ID);

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key TROFEA1;
PROMPT----------------------------------------;
PROMPT ;
alter table TROFEA add constraint FK_TROFEA_DRU_ID
foreign key (DRU_ID)
references DRUZYNY (DRU_ID)
on delete cascade;

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key TROFEA2;
PROMPT----------------------------------------;
PROMPT ;
alter table TROFEA add constraint FK_TROFEA_TUR_ID
foreign key (TUR_ID)
references TURNIEJE (TUR_ID);
--domyslnie jest on delete no restrict

PROMPT ;
PROMPT----------------------------------------;
PROMPT Foreign Key TROFEA3;
PROMPT----------------------------------------;
PROMPT ;
alter table TROFEA add constraint FK_TROFEA_SEZ_ID
foreign key (SEZ_ID)
references SEZON (SEZ_ID);
--domyslnie jest on delete no restrict




PROMPT----------------------------------------;
PROMPT DESCRIBE;
PROMPT----------------------------------------;
--
PROMPT Sprawdzamy czy prawidlowo utworzono tabele;
PROMPT ;
--
describe SEZON;
describe KATEGORIE;
describe ADRESY;
describe OSOBY;
describe ZWIAZKI;
describe SZACHOWE_LICENCJE;
describe DRUZYNY;
describe MIEJSCA;
describe TURNIEJE;
describe ROZEGRANE_MECZE;
describe TROFEA;

--
PROMPT ;
--
-- zatwierdzenie wszystkich transakcji
--
commit work