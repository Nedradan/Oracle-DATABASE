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
PROMPT ;
PROMPT logowanie
PROMPT ;
--
--connect ######
--
--
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';
SET SERVEROUTPUT ON;
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
SEZ_ROK_ZAKONCZENIA date NOT NULL,
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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_SEZON;
	
	CREATE SEQUENCE SEQ_SEZON 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_SEZON
	BEFORE INSERT ON SEZON
	FOR EACH ROW
	BEGIN
		IF :NEW.SEZ_ID IS NULL THEN
			SELECT SEQ_SEZON.NEXTVAL 
				INTO :NEW.SEZ_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do SEZON - SEZ_ID='||:NEW.SEZ_ID);
		--
	END;
	/
	------------------------
	-- DML SEZON
	------------------------
	insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
	values ('2018/05/03','2019/05/03','MISTRZOWSKI');

	insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
	values ('2019/05/03','2020/05/03','ZWYKLY');
	
	

	
	column SEZ_ID HEADING 'ID' format 999999
	column SEZ_ROK_ROZPOCZECIA HEADING 'DATA ROZPOCZECIA' format A21
	column SEZ_ROK_ZAKONCZENIA HEADING 'DATA ZAKONCZENIA' format A21
	column SEZ_RODZAJ HEADING 'MIEJSCOWOSC' format A20

	select count(SEZ_ID) from SEZON;

	select * from SEZON;	
	






PROMPT ;
PROMPT--------------------------------------------------------------------------------;
PROMPT CREATE TABLE KATEGORIE;
PROMPT----------------------------------------;
PROMPT ;

create table KATEGORIE
(
KAT_ID number(4) NOT NULL,
KAT_TYP varchar2(20) NOT NULL,
KAT_RANGA varchar2(20) NOT NULL,
KAT_OPIS varchar2(40)
);
PROMPT ;
PROMPT----------------------------------------;
PROMPT Primary Key KATEGORIE;
PROMPT----------------------------------------;
PROMPT ;

alter table KATEGORIE
add constraint PK_KATEGORIE
primary key (KAT_ID);

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_KATEGORIE;
	
	CREATE SEQUENCE SEQ_KATEGORIE 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_KATEGORIE
	BEFORE INSERT ON KATEGORIE
	FOR EACH ROW
	BEGIN
		IF :NEW.KAT_ID IS NULL THEN
			SELECT SEQ_KATEGORIE.NEXTVAL 
				INTO :NEW.KAT_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do SEZON - KAT_ID='||:NEW.KAT_ID);
		--
	END;
	/
	------------------------
	-- DML KATEGORIE
	------------------------
	insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('ZAWODNIK','POZIOM A+');

	insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('SEDZIA','POZIOM A+');

	
	column KAT_ID HEADING 'ID' format 999999
	column KAT_TYP HEADING 'RODZAJ LICENCJI' format A20
	column KAT_RANGA HEADING 'POZIOM' format A20

	select count(KAT_ID) from KATEGORIE;

	select * from KATEGORIE;	



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
------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_ADRESY;
	
	CREATE SEQUENCE SEQ_ADRESY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_ADRESY
	BEFORE INSERT ON ADRESY
	FOR EACH ROW
	BEGIN
		IF :NEW.ADR_ID IS NULL THEN
			SELECT SEQ_ADRESY.NEXTVAL 
				INTO :NEW.ADR_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do SEZON - ADR_ID='||:NEW.ADR_ID);
		--
	END;
	/
	------------------------
	-- DML ADRESY
	------------------------
	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU)
	values ('Debica','39-200','Krakowska','13A');

	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
	values ('Krakow','31-878','Orlinskiego','12b','13');

	
	column ADR_ID HEADING 'ID' format 999999
	column ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' format A15
	column ADR_KOD_POCZTOWY HEADING 'KOD POCZTOWY' format A15
	column ADR_ULICA HEADING 'ULICA' format A10 WRAP
	column ADR_NUMER_DOMU HEADING 'NR DOMU' format A10
	
	select count(ADR_ID) from ADRESY;

	select * from ADRESY;	




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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_OSOBY;
	
	CREATE SEQUENCE SEQ_OSOBY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_OSOBY
	BEFORE INSERT ON OSOBY
	FOR EACH ROW
	BEGIN
		IF :NEW.OSO_ID IS NULL THEN
			SELECT SEQ_OSOBY.NEXTVAL 
				INTO :NEW.OSO_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do SEZON - OSO_ID='||:NEW.OSO_ID);
		--
	END;
	/
	------------------------
	-- DML OSOBY
	------------------------
	insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
	values ('JAN','KUSEK','99999999999',1);

	insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
	values ('ANDRZEJ','KING','11111111111',2);
	insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
	values ('KAMIL','KRAWCZYK','88888888888',1);

	insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
	values ('MACIEK','KLANOWY','22222222222',2);

	
	column OSO_ID HEADING 'ID' format 9999
	column OSO_IMIE1 HEADING 'IMIE' format A15
	column OSO_NAZWISKO HEADING 'NAZWISKO' format A15
	column OSO_PESEL HEADING 'PESEL' format A11
	column ADR_ID HEADING 'ID ADRESUU' format 9999

	select count(OSO_ID) from OSOBY;

	select * from OSOBY;	
	CLEAR COLUMNS;


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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_ZWIAZKI;
	
	CREATE SEQUENCE SEQ_ZWIAZKI 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_ZWIAZKI
	BEFORE INSERT ON ZWIAZKI
	FOR EACH ROW
	BEGIN
		IF :NEW.ZWI_ID IS NULL THEN
			SELECT SEQ_ZWIAZKI.NEXTVAL 
				INTO :NEW.ZWI_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do ZWIAZKI - ZWI_ID='||:NEW.ZWI_ID);
		--
	END;
	/
	------------------------
	-- DML ZWIAZKI
	------------------------
	insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
	values ('PODKARPACKI',1);

	insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
	values ('MALOPOLSKI',2);

	
	column ZWI_ID HEADING 'ID' format 9999
	column ZWI_NAZWA HEADING 'NAZWA' format A15
	column ADR_ID HEADING 'ID ADRESU' format 9999
	

	select count(ZWI_ID) from ZWIAZKI;

	select * from ZWIAZKI;
	CLEAR COLUMNS;




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
ZWI_ID number(4) NOT NULL,
SZA_OPIS varchar2(40)
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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_SZACHOWE_LICENCJE;
	
	CREATE SEQUENCE SEQ_SZACHOWE_LICENCJE 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_SZACHOWE_LICENCJE
	BEFORE INSERT ON SZACHOWE_LICENCJE
	FOR EACH ROW
	BEGIN
		IF :NEW.SZA_ID IS NULL THEN
			SELECT SEQ_SZACHOWE_LICENCJE.NEXTVAL 
				INTO :NEW.SZA_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do SZACHOWE_LICENCJE - SZA_ID='||:NEW.SZA_ID);
		--
	END;
	/
	------------------------
	-- DML SZACHOWE_LICENCJE
	------------------------
	insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
	values ('2016/03/01',1,1,1);

	insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
	values ('2015/03/01',2,2,2);

	
	column SZA_ID HEADING 'ID' format 9999
	column SZA_DATA_UZYSKANIA HEADING 'DATA UZYSKANIA' format A20
	column OSO_ID HEADING 'ID OSOBY' format 9999
	column KAT_ID HEADING 'ID KATEGORII' format 9999
	column ZWI_ID HEADING 'ID ZWIAZKU' format 9999
	

	select count(SZA_ID) from SZACHOWE_LICENCJE;

	select * from SZACHOWE_LICENCJE;
	CLEAR COLUMNS;


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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_DRUZYNY;
	
	CREATE SEQUENCE SEQ_DRUZYNY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_DRUZYNY
	BEFORE INSERT ON DRUZYNY
	FOR EACH ROW
	BEGIN
		IF :NEW.DRU_ID IS NULL THEN
			SELECT SEQ_DRUZYNY.NEXTVAL 
				INTO :NEW.DRU_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do DRUZYNY - DRU_ID='||:NEW.DRU_ID);
		--
	END;
	/
	------------------------
	-- DML DRUZYNY
	------------------------
	insert into DRUZYNY (DRU_NAZWA, OSO_ID1,OSO_ID2,OSO_ID3,OSO_ID4,SEZ_ID)
	values ('KOZAKI',1,2,3,4,1);

	insert into DRUZYNY (DRU_NAZWA, OSO_ID1,OSO_ID2,OSO_ID3,OSO_ID4,SEZ_ID)
	values ('KOZAKI',1,2,3,4,2);

	
	column DRU_ID HEADING 'ID' format 9999
	column DRU_NAZWA HEADING 'NAZWA' format A15
	column OSO_ID1 HEADING 'GRACZ1 ID' format 9999
	column OSO_ID2 HEADING 'GRACZ2 ID' format 9999
	column OSO_ID3 HEADING 'GRACZ3 ID' format 9999
	column OSO_ID4 HEADING 'GRACZ4 ID' format 9999
	column ZWI_ID HEADING 'ID ZWIAZKU' format 9999
	

	select count(DRU_ID) from DRUZYNY;

	select * from DRUZYNY;
	CLEAR COLUMNS;


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
MIE_RODZAJ_SZACHOWNIC varchar2(25),
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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_MIEJSCA;
	
	CREATE SEQUENCE SEQ_MIEJSCA 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_MIEJSCA
	BEFORE INSERT ON MIEJSCA
	FOR EACH ROW
	BEGIN
		IF :NEW.MIE_ID IS NULL THEN
			SELECT SEQ_MIEJSCA.NEXTVAL 
				INTO :NEW.MIE_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do MIEJSCA - MIE_ID='||:NEW.MIE_ID);
		--
	END;
	/
	------------------------
	-- DML MIEJSCA
	------------------------
	insert into MIEJSCA (MIE_ILOSC_ZEGAROW, MIE_ZAKWATEROWANIE,MIE_RODZAJ_SZACHOWNIC,ADR_ID,ZWI_ID)
	values (15,'TAK','PAPIEROWE',1,1);

	insert into MIEJSCA (MIE_ILOSC_ZEGAROW, MIE_ZAKWATEROWANIE,MIE_RODZAJ_SZACHOWNIC,ADR_ID,ZWI_ID)
	values (20,'NIE','SZKLANE',2,2);

	
	column MIE_ID HEADING 'ID' format 9999
	column MIE_ILOSC_ZEGAROW HEADING 'ILOSC ZEGAROW' format 9999
	column MIE_ZAKWATEROWANIE HEADING 'ZAKWATEROWANIE' format 9999
	column ADR_ID HEADING 'ID ADRESU' format 9999
	column ZWI_ID HEADING 'ID ZWIAZKU' format 9999
	

	select count(MIE_ID) from MIEJSCA;

	select * from MIEJSCA;
	CLEAR COLUMNS;




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
TUR_NAGRODA number(4),
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
------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_TURNIEJE;
	
	CREATE SEQUENCE SEQ_TURNIEJE 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_TURNIEJE
	BEFORE INSERT ON TURNIEJE
	FOR EACH ROW
	BEGIN
		IF :NEW.TUR_ID IS NULL THEN
			SELECT SEQ_TURNIEJE.NEXTVAL 
				INTO :NEW.TUR_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do TURNIEJE - TUR_ID='||:NEW.MIE_ID);
		--
	END;
	/
	------------------------
	-- DML TURNIEJE
	------------------------
	insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
	values (15,'TURNIEJEK SZEFA',3000,1,1);

	insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
	values (20,'TURNIEJEK KROLA',6000,2,2);

	
	column TUR_ID HEADING 'ID' format 9999
	column TUR_ILOSC_MIEJSC HEADING 'ILOSC MIEJSC' format 9999
	column TUR_NAZWA HEADING 'NAZWA' format A10 WRAP
	column KAT_ID HEADING 'ID KAT MIN' format 9999
	column MIE_ID HEADING 'ID MIEJSCA' format 9999
	

	select count(TUR_ID) from TURNIEJE;

	select * from TURNIEJE;
	CLEAR COLUMNS; 



 
 
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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_ROZEGRANE_MECZE;
	
	CREATE SEQUENCE SEQ_ROZEGRANE_MECZE 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_ROZEGRANE_MECZE
	BEFORE INSERT ON ROZEGRANE_MECZE
	FOR EACH ROW
	BEGIN
		IF :NEW.ROZ_ID IS NULL THEN
			SELECT SEQ_ROZEGRANE_MECZE.NEXTVAL 
				INTO :NEW.ROZ_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do ROZEGRANE_MECZE - ROZ_ID='||:NEW.ROZ_ID);
		--
	END;
	/
	------------------------
	-- DML ROZEGRANE_MECZE
	------------------------
	insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
	values (1,1,2,3,0,10,1);

	insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
	values (1,2,1,3,1,12,2);

	
	column ROZ_ID HEADING 'ID' format 9999
	column TUR_ID HEADING 'ID TURNIEJU' format 9999
	column OSO_ID1 HEADING 'GRACZ1 ID' format 9999
	column OSO_ID2 HEADING 'GRACZ2 ID' format 9999
	column OSO_ID3 HEADING 'SEDZIA' format 9999
	column ROZ_WYNIK HEADING 'WYNIK' format 9999
	column ROZ_CZAS_TRWANIA_MIN HEADING 'CZAS(MIN)' format 9999
	column SEZ_ID HEADING 'ID SEZONU' format 9999
	

	select count(ROZ_ID) from ROZEGRANE_MECZE;

	select * from ROZEGRANE_MECZE;
	CLEAR COLUMNS;

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

------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_TROFEA;
	
	CREATE SEQUENCE SEQ_TROFEA 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_PK_TROFEA
	BEFORE INSERT ON TROFEA
	FOR EACH ROW
	BEGIN
		IF :NEW.TRO_ID IS NULL THEN
			SELECT SEQ_TROFEA.NEXTVAL 
				INTO :NEW.TRO_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do TROFEA - TRO_ID='||:NEW.TRO_ID);
		--
	END;
	/
	------------------------
	-- DML TROFEA
	------------------------
	insert into TROFEA (TUR_ID,DRU_ID,SEZ_ID)
	values (1,1,1);

	insert into TROFEA (TUR_ID,DRU_ID,SEZ_ID)
	values (2,2,2);

	
	column TRO_ID HEADING 'ID' format 9999
	column TUR_ID HEADING 'ID TURNIEJU' format 9999
	column DRU_ID HEADING 'ID DRUZYNY' format 9999
	column SEZ_ID HEADING 'ID SEZONU' format 9999
	

	select count(TRO_ID) from TROFEA;

	select * from TROFEA;
	CLEAR COLUMNS;




---------------------------------------------------
---WYZWALACZE ZDARZENIOWE--------------------------
---------------------------------------------------
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT TRIGGERY DODATKOWE;
PROMPT----------------------------------------;
PROMPT----------------------------------------;

DROP TRIGGER T_NAGRODA_TURNIEJE

CREATE OR REPLACE TRIGGER T_NAGRODA_TURNIEJE
BEFORE INSERT ON TURNIEJE
FOR EACH ROW
BEGIN
  IF :NEW.TUR_NAGRODA > 7500 THEN
  :NEW.TUR_NAGRODA := 7500;
  END IF;
END;
/

insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (20,'TURNIEJEK KROLA2',9000,2,2);

	column TUR_ID HEADING 'ID' format 9999
	column TUR_ILOSC_MIEJSC HEADING 'ILOSC MIEJSC' format 9999
	column TUR_NAZWA HEADING 'NAZWA' format A10 WRAP
	column KAT_ID HEADING 'ID KAT MIN' format 9999
	column MIE_ID HEADING 'ID MIEJSCA' format 9999
	

select * from TURNIEJE where TUR_NAZWA like 'TURNIEJEK KROLA2';
CLEAR COLUMNS;
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

DROP TRIGGER T_UPDATE_TROFEA

CREATE OR REPLACE TRIGGER T_UPDATE_TROFEA
BEFORE INSERT ON TROFEA
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('ZAKTUALIZOWANO WIERSZ W TABELI TROFEA ');
END;
/

DROP TRIGGER T_DELETE_TROFEA

CREATE OR REPLACE TRIGGER T_DELETE_TROFEA
BEFORE DELETE ON TROFEA
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('USUNIETO WIERSZ Z TABELI TROFEA ');
END;
/

update TROFEA set TUR_ID=1 	WHERE TRO_ID=2;
delete from TROFEA WHERE TRO_ID=2;
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
DROP TRIGGER T_INSERT_ZAK_MIEJSCA

CREATE OR REPLACE TRIGGER T_INSERT_ZAK_MIEJSCA
BEFORE INSERT OR UPDATE ON MIEJSCA
FOR EACH ROW
BEGIN
IF inserting OR updating ('MIE_ZAKWATEROWANIE') THEN
:NEW.MIE_ZAKWATEROWANIE := UPPER(:NEW.MIE_ZAKWATEROWANIE);
END IF;
END;
/	

	insert into MIEJSCA (MIE_ILOSC_ZEGAROW, MIE_ZAKWATEROWANIE,ADR_ID,ZWI_ID)
	values (30,'nie',2,2);

	
	column MIE_ID HEADING 'ID' format 9999
	column MIE_ILOSC_ZEGAROW HEADING 'ILOSC ZEGAROW' format 9999
	column MIE_ZAKWATEROWANIE HEADING 'ZAKWATEROWANIE' format 9999
	column ADR_ID HEADING 'ID ADRESU' format 9999
	column ZWI_ID HEADING 'ID ZWIAZKU' format 9999
	
	select * from MIEJSCA;
	CLEAR COLUMNS;

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJE INSERT DLA WYBRANYCH TABEL
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2017/05/03','2018/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2016/05/03','2017/05/03','ZWYKLY');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2015/05/03','2016/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2014/05/03','2015/05/03','ZWYKLY');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2013/05/03','2014/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2012/05/03','2013/05/03','ZWYKLY');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2011/05/03','2012/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2010/05/03','2011/05/03','ZWYKLY');

---------------------------------------------------------
insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('ZAWODNIK','POZIOM A','KATEGORIA A');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('SEDZIA','POZIOM A','KATEGORIA A');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('ZAWODNIK','POZIOM B+','KATEGORIA B+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('SEDZIA','POZIOM B+','KATEGORIA B+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('ZAWODNIK','POZIOM B','KATEGORIA B');

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
values ('SEDZIA','POZIOM B');

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
values ('ZAWODNIK','POZIOM C+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
values ('SEDZIA','POZIOM C+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
values ('ZAWODNIK','POZIOM C');

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
values ('SEDZIA','POZIOM C');
---------------------------------------------------------
insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU)
values ('Warszawa','00-001','Krakowska','115A');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
values ('Warszawa','00-002','Rzeszowska','11','75');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU)
values ('Debica','39-200','Fredry','73');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
values ('Giżycko','11-500','Orlinskiego','10','99');
---------------------------------------------------------
insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('PAWEL','JUMPER','33333333333',3);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('KAMIL','MROCZKA','22222223456',4);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('ADAM','KRAWCZYK','77777777777',5);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('TOMASZ','KLANOWY','55553355555',6);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('TOMASZ','SKOCZEK','33345333333',6);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('AGATA','MROCZKA','22211223456',3);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('MARIOLA','KRAWCZYK','77777733777',5);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('WIESŁAW','KLANOWY','55555555555',2);
---------------------------------------------------------
insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('MAZOWIECKI',3);

insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('WARSZAWSKI',4);

insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('MAZURSKI',5);
---------------------------------------------------------
insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
values ('2013/07/01',3,3,3);

insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
values ('2011/04/01',4,4,4);

insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
values ('2016/11/01',5,5,5);

insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
values ('2019/12/01',6,3,2);
---------------------------------------------------------
insert into DRUZYNY (DRU_NAZWA, OSO_ID1,OSO_ID2,OSO_ID3,OSO_ID4,SEZ_ID)
values ('SZEFOWIE',5,6,7,8,3);

insert into DRUZYNY (DRU_NAZWA, OSO_ID1,OSO_ID2,OSO_ID3,OSO_ID4,SEZ_ID)
values ('DRUKARZE',5,3,1,2,4);

insert into DRUZYNY (DRU_NAZWA, OSO_ID1,OSO_ID2,OSO_ID3,OSO_ID4,SEZ_ID)
values ('ALBIONI',4,2,1,7,6);
---------------------------------------------------------
insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (1,1,6,3,0,2,1);

insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (1,2,7,3,1,6,2);

insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (1,3,6,5,2,2,1);

insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (1,1,7,5,2,6,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,KAT_ID,MIE_ID)
values (20,'TURNIEJ PREZESA',2,2);
---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJE SELECT
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
column OSO_IMIE1 HEADING 'IMIE' format A15
column OSO_NAZWISKO HEADING 'NAZWISKO' format A15
SELECT OSO_IMIE1,OSO_NAZWISKO FROM OSOBY WHERE ADR_ID = 3;
CLEAR COLUMNS;


column SEZ_ID HEADING 'ID' format 999999
column SEZ_ROK_ROZPOCZECIA HEADING 'DATA ROZPOCZECIA' format A21
SELECT SEZ_ID,SEZ_ROK_ROZPOCZECIA FROM SEZON WHERE SEZ_RODZAJ LIKE 'MISTRZOWSKI';
CLEAR COLUMNS;


column KAT_ID HEADING 'ID' format 999999
column KAT_RANGA HEADING 'POZIOM' format A20
SELECT KAT_ID,KAT_RANGA FROM KATEGORIE WHERE KAT_TYP LIKE 'SEDZIA';
CLEAR COLUMNS;

column ROZ_ID HEADING 'ID' format 999999
SELECT ROZ_ID FROM ROZEGRANE_MECZE WHERE ROZ_CZAS_TRWANIA_MIN > 5 AND ROZ_CZAS_TRWANIA_MIN < 10;
CLEAR COLUMNS;


column OSO_ID HEADING 'ID OSOBY' format 9999
column OSO_IMIE1 HEADING 'IMIE' format A15
column ADR_ID HEADING 'ID ADRESUU' format 9999
SELECT OSO_ID,OSO_IMIE1,ADR_ID FROM OSOBY WHERE OSO_IMIE1 LIKE 'TOMASZ';
CLEAR COLUMNS;

column SZA_ID HEADING 'ID' format 9999
column SZA_DATA_UZYSKANIA HEADING 'DATA UZYSKANIA' format A20
column OSO_ID HEADING 'ID OSOBY' format 9999
column KAT_ID HEADING 'ID KATEGORII' format 9999
SELECT SZA_ID,OSO_ID,SZA_DATA_UZYSKANIA,KAT_ID FROM SZACHOWE_LICENCJE WHERE SZA_DATA_UZYSKANIA < '2016/01/01';

PROMPT UPDATE;
update SZACHOWE_LICENCJE set SZA_DATA_UZYSKANIA = '2011/03/02' 	WHERE SZA_ID=5;
SELECT SZA_ID,OSO_ID,SZA_DATA_UZYSKANIA,KAT_ID FROM SZACHOWE_LICENCJE WHERE SZA_DATA_UZYSKANIA < '2016/01/01';
CLEAR COLUMNS;

column ADR_ID HEADING 'ID' format 999999
column ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' format A15
column ADR_KOD_POCZTOWY HEADING 'KOD POCZTOWY' format A15
SELECT ADR_ID,ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY FROM ADRESY WHERE ADR_ULICA LIKE 'Krakowska';
CLEAR COLUMNS;
-------------------------------------------------------------
--NVL
-------------------------------------------------------------
column ADR_ID HEADING 'ID' format 999999
column ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' format A15
column ADR_KOD_POCZTOWY HEADING 'KOD POCZTOWY' format A15
column ADR_ULICA HEADING 'ULICA' format A10 WRAP
column ADR_NUMER_DOMU HEADING 'NR DOMU' format A10
column ADR_NUMER_MIESZKANIA HEADING 'NR MIESZK' format A10
SELECT ADR_ID,ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY,ADR_ULICA,ADR_NR_DOMU,NVL(ADR_NR_MIESZKANIA, '--') FROM ADRESY WHERE ADR_ULICA LIKE 'Krakowska';
CLEAR COLUMNS;

column KAT_ID HEADING 'ID' format 999999
column KAT_RANGA HEADING 'POZIOM' format A20
column KAT_OPIS HEADING 'OPIS' FORMAT A15 WRAP
SELECT KAT_ID,KAT_RANGA,NVL(KAT_OPIS, 'BRAK OPISU') OPIS FROM KATEGORIE WHERE KAT_TYP LIKE 'ZAWODNIK';
CLEAR COLUMNS;

column TUR_ID HEADING 'ID' format 999999
column TUR_NAZWA HEADING 'NAZWA TURNIEJU' format A20
column TUR_NAGRODA HEADING 'NAGRODA' format 9999
SELECT TUR_ID,TUR_NAZWA,NVL(TUR_NAGRODA, 0) NAGRODA FROM TURNIEJE WHERE TUR_ILOSC_MIEJSC > 10;
CLEAR COLUMNS;

column MIE_ID HEADING 'ID' format 999999
column MIE_ILOSC_ZEGAROW HEADING 'ILOSC ZEGAROW' format 9999
column MIE_ZAKWATEROWANIE HEADING 'ZAKWATEROWANIE' format A4;
column MIE_RODZAJ_SZACHOWNIC HEADING 'SZACHOWNICE' format A20;
column ADR_ID HEADING 'ID ADRESU' format 9999
column ZWI_ID HEADING 'ID ZWIAZKU' format 9999
SELECT MIE_ID,MIE_ILOSC_ZEGAROW,NVL(MIE_RODZAJ_SZACHOWNIC,'WLASNE') SZACHOWNICE FROM MIEJSCA WHERE MIE_ZAKWATEROWANIE LIKE 'T%' OR MIE_ZAKWATEROWANIE LIKE 'N%';
CLEAR COLUMNS;

---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJA MERGE
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
column SZA_ID HEADING 'ID' format 9999
column SZA_DATA_UZYSKANIA HEADING 'DATA UZYSKANIA' format A20
column OSO_ID HEADING 'ID OSOBY' format 9999
column KAT_ID HEADING 'ID KATEGORII' format 9999
column SZA_OPIS HEADING 'opis' format A15
SELECT * FROM SZACHOWE_LICENCJE;

PROMPT WYKONUJEMY MERGE;


MERGE INTO SZACHOWE_LICENCJE
USING KATEGORIE 
ON
(SZACHOWE_LICENCJE.KAT_ID = KATEGORIE.KAT_ID)
WHEN MATCHED THEN 
UPDATE SET SZACHOWE_LICENCJE.SZA_OPIS = KATEGORIE.KAT_OPIS;

SELECT * FROM SZACHOWE_LICENCJE;
CLEAR COLUMNS;


PROMPT----------------------------------------;
PROMPT DESCRIBE;
PROMPT----------------------------------------;

PROMPT Sprawdzamy czy prawidlowo utworzono tabele;
PROMPT ;

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
commit work;