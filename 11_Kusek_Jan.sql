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
--connect ####
--
--
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';
SET SERVEROUTPUT ON;
SET SERVEROUTPUT ON;
SET LINESIZE 300;
SET PAGESIZE 350;
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
references DRUZYNY (DRU_ID);

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
	
PROMPT ----------------------------------------------------------;
PROMPT lab05;
PROMPT ----------------------------------------------------------;
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- lab05
----------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
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

PROMPT ----------------------------------------------------------;
PROMPT lab06;
PROMPT ----------------------------------------------------------;
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- lab06
----------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJE INSERT DLA WYBRANYCH TABEL
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2009/05/03','2010/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2008/05/03','2009/05/03','ZWYKLY');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2007/05/03','2008/05/03','MISTRZOWSKI');

insert into SEZON (SEZ_ROK_ROZPOCZECIA,SEZ_ROK_ZAKONCZENIA,SEZ_RODZAJ)
values ('2006/05/03','2007/05/03','ZWYKLY');

---------------------------------------------------------
insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('ZAWODNIK','POZIOM D+','KATEGORIA D+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('SEDZIA','POZIOM D+','KATEGORIA D+');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('ZAWODNIK','POZIOM D','KATEGORIA D');

insert into KATEGORIE (KAT_TYP,KAT_RANGA,KAT_OPIS)
values ('SEDZIA','POZIOM D','KATEGORIA D');

---------------------------------------------------------
insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU)
values ('Warszawa','00-001','Fredry','115A');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
values ('Warszawa','00-002','Kolakowska','11','75');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU)
values ('Debica','39-200','Nieziemska','73');

insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
values ('Giżycko','11-500','3maja','10','99');
---------------------------------------------------------
insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('PAWEŁ','TOCZYNSKI','33133393233',7);

insert into OSOBY (OSO_IMIE1,OSO_NAZWISKO,OSO_PESEL,ADR_ID)
values ('KAMIL','MROCZKA','12342223456',8);

---------------------------------------------------------
insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('SWIETOKRZYSKI',6);

insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('LUBELSKI',7);

insert into ZWIAZKI (ZWI_NAZWA,ADR_ID)
values ('POMORSKI',8);
----------------------------------------------------------------
insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (2,2,1,3,1,12,2);
insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (2,2,3,3,1,10,2);
insert into ROZEGRANE_MECZE (TUR_ID,OSO_ID1,OSO_ID2,OSO_ID3,ROZ_WYNIK,ROZ_CZAS_TRWANIA_MIN,SEZ_ID)
values (3,5,6,3,1,12,2);

---------------------------------------------------------
---------------------------------------------------------
--INSTRUKCJE SELECT DO WIELU TABEL JEDNOCZEŚNIE
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

--FORMATOWANIE
COLUMN TUR_ID HEADING 'ID TUR' FORMAT 9999
COLUMN TUR_NAZWA HEADING 'NAZWA' FORMAT A20 WRAP
COLUMN ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' FORMAT A20 WRAP
--WYSWIETLAM ID, NAZWE, ILOSC ZEGARÓW ORAZ MIEJSCOWOSCI WSZYTSKICH TURNIEJÓW

SELECT t.TUR_ID,t.TUR_NAZWA,m.MIE_ILOSC_ZEGAROW,a.ADR_MIEJSCOWOSC 
FROM TURNIEJE t,MIEJSCA m, ADRESY a 
WHERE t.MIE_ID = m.MIE_ID AND m.ADR_ID = a.ADR_ID;
/*
ID TUR NAZWA                MIE_ILOSC_ZEGAROW MIEJSCOWOSC
------ -------------------- ----------------- --------------------
     1 TURNIEJEK SZEFA                     15 Debica
     2 TURNIEJEK KROLA                     20 Krakow
     3 TURNIEJEK KROLA2                    20 Krakow
     4 TURNIEJ PREZESA                     20 Krakow

*/

CLEAR COLUMNS;
-----------------------------------------------------
--FORMATOWANIE
COLUMN OSO_IMIE1 HEADING 'IMIE' FORMAT A15 WRAP
COLUMN OSO_NAZWISKO HEADING 'NAZWISKO' FORMAT A20 WRAP
COLUMN ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC ZAMIESZKANIA' FORMAT A30 WRAP
--WYSWIETLAM IMIE NAZWISKO ORAZ MIEJCOWOSC ZAMIESZKANIA WSYZTSKICH OSOB W BAZIE

SELECT o.OSO_IMIE1,o.OSO_NAZWISKO,a.ADR_MIEJSCOWOSC 
from OSOBY o, ADRESY a 
WHERE o.ADR_ID = a.ADR_ID;
/*
IMIE            NAZWISKO             MIEJSCOWOSC ZAMIESZKANIA
--------------- -------------------- ------------------------------
JAN             KUSEK                Debica
ANDRZEJ         KING                 Krakow
KAMIL           KRAWCZYK             Debica
MACIEK          KLANOWY              Krakow
PAWEL           JUMPER               Warszawa
KAMIL           MROCZKA              Warszawa
ADAM            KRAWCZYK             Debica
TOMASZ          KLANOWY              Gi??ycko
TOMASZ          SKOCZEK              Gi??ycko
AGATA           MROCZKA              Warszawa
MARIOLA         KRAWCZYK             Debica
WIES??AW        KLANOWY              Krakow
PAWE??          TOCZYNSKI            Warszawa
KAMIL           MROCZKA              Warszawa
*/
CLEAR COLUMNS;

-----------------------------------------------------
--FORMATOWANIE
COLUMN SZA_ID HEADING 'ID LICENCJI' FORMAT 9999
COLUMN OSO_IMIE1 HEADING 'IMIE' FORMAT A15 WRAP
COLUMN OSO_NAZWISKO HEADING 'NAZWISKO' FORMAT A20 WRAP
COLUMN KAT_TYP HEADING 'TYP' FORMAT A10 WRAP
COLUMN ZWI_NAZWA HEADING 'NAZWA' FORMAT A15 WRAP

--WYSWIETLAM ID LICENCJI, IMIE I NAZWISKO POSIADACZA,TYP KATEGORII ORAZ NAZWA ZWIAZKU WYDAJĄCEGO LICENCJE

SELECT s.SZA_ID,o.OSO_IMIE1,o.OSO_NAZWISKO,k.KAT_TYP,z.ZWI_NAZWA 
FROM SZACHOWE_LICENCJE s,OSOBY o,KATEGORIE k,ZWIAZKI z 
WHERE s.OSO_ID = o.OSO_ID AND s.KAT_ID = k.KAT_ID AND s.ZWI_ID = z.ZWI_ID;
/*
ID LICENCJI IMIE            NAZWISKO             TYP        			NAZWA
----------- --------------- -------------------- ---------- ---------------
          1 JAN            		KUSEK                	ZAWODNIK   	PODKARPACKI
          2 ANDRZEJ         	KING                 		SEDZIA     		MALOPOLSKI
          3 KAMIL           	KRAWCZYK             ZAWODNIK   	MAZOWIECKI
          4 MACIEK          	KLANOWY              SEDZIA     		WARSZAWSKI
          5 PAWEL           	JUMPER               	ZAWODNIK   	MAZURSKI
          6 KAMIL           	MROCZKA              ZAWODNIK   	MALOPOLSKI
	
*/
CLEAR COLUMNS;
-----------------------------------------------------

--FORMATOWANIE
COLUMN TRO_ID HEADING 'ID TROFEUM' FORMAT 9999
COLUMN TUR_NAZWA HEADING 'NAZWA TURNIEJU' FORMAT A15 WRAP
COLUMN DRU_NAZWA HEADING 'NAZWA TEAMU' FORMAT A15 WRAP
COLUMN SEZ_RODZAJ HEADING 'RODZAJ SEZONU' FORMAT A20 WRAP
--WYSWIETLAM ID TROFEUM,NAZWE TURNIEJU, NAZWE DRUZYNY ORAZ RODZAJ SEZONU
SELECT tr.TRO_ID,t.TUR_NAZWA,d.DRU_NAZWA,s.SEZ_RODZAJ 
FROM TROFEA tr,TURNIEJE t,DRUZYNY d,SEZON s 
WHERE tr.TUR_ID = t.TUR_ID AND tr.DRU_ID = d.DRU_ID AND tr.SEZ_ID = s.SEZ_ID;
/*

ID TROFEUM NAZWA TURNIEJU  NAZWA TEAMU     RODZAJ SEZONU
---------- --------------- --------------- --------------------
         1 	TURNIEJEK SZEFA 		KOZAKI          MISTRZOWSKI
*/
CLEAR COLUMNS;

---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- GROUP BY, HAVING
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------


--FORMATOWANIE
column KAT_ID HEADING 'ID' format 999999
column KAT_TYP HEADING 'RODZAJ LICENCJI' format A20
column KAT_RANGA HEADING 'POZIOM' format A20
COLUMN KAT_OPIS HEADING 'OPIS' format A20 WRAP
column ILOSC HEADING 'ILOSC' FORMAT 9999
--WYSWIETLAM TABELE KATEGORIE
select * 
from KATEGORIE;
/*
 ID RODZAJ LICENCJI      POZIOM               OPIS
------- -------------------- -------------------- --------------------
      1 ZAWODNIK             POZIOM A+
      2 SEDZIA               	POZIOM A+
      3 ZAWODNIK             POZIOM A             KATEGORIA A
      4 SEDZIA              	 POZIOM A             KATEGORIA A
      5 ZAWODNIK             POZIOM B+            KATEGORIA B+
      6 SEDZIA              	 POZIOM B+            KATEGORIA B+
      7 ZAWODNIK             POZIOM B             KATEGORIA B
      8 SEDZIA               	POZIOM B
      9 ZAWODNIK             POZIOM C+
     10 SEDZIA               	POZIOM C+
     11 ZAWODNIK             POZIOM C
     12 SEDZIA               	POZIOM C
     13 ZAWODNIK             POZIOM D+            KATEGORIA D+
     14 SEDZIA               	POZIOM D+            KATEGORIA D+
     15 ZAWODNIK             POZIOM D             KATEGORIA D
     16 SEDZIA              	 POZIOM D             KATEGORIA D
*/

--A TERAZ ZLICZYMY ILE JEST KATEGORII SEDZIOWSKICH I ILE DLA GRACZY(group by);
PROMPT A TERAZ ZLICZYMY ILE JEST KATEGORII SEDZIOWSKICH I ILE DLA GRACZY;
select KAT_TYP TYP_KATEGORII, COUNT(KAT_TYP) ILOSC
from KATEGORIE
GROUP BY KAT_TYP;

/*
TYP_KATEGORII        ILOSC
-------------------- -----
SEDZIA                      8
ZAWODNIK                 8

*/

CLEAR COLUMNS;

---------------------------------------------------------------------------------
--FORMATOWANIE
column ADR_ID HEADING 'ID' format 999999
column ADR_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' format A15
column ADR_KOD_POCZTOWY HEADING 'KOD POCZTOWY' format A15
column ADR_ULICA HEADING 'ULICA' format A20 WRAP
column ADR_NUMER_DOMU HEADING 'NR DOMU' format A10
column ILOSC HEADING 'ILOSC' FORMAT 9999

--WYSWIETLAM ZAWARTOSC TABELI ADRESY
select * 
from ADRESY;
/*
ID MIEJSCOWOSC     KOD POCZTOWY    ULICA                ADR_NR_DOM ADR_NR_MIE
------- --------------- --------------- -------------------- ---------- ----------
      1 Debica          39-200          Krakowska            13A
      2 Krakow          31-878          Orlinskiego          12b        			13
      3 Warszawa        00-001          Krakowska            115A
      4 Warszawa        00-002          Rzeszowska           11        			 75
      5 Debica          39-200          Fredry               73
      6 Gi??ycko        11-500          Orlinskiego          10        				 99
      7 Warszawa        00-001          Fredry               115A
      8 Warszawa        00-002          Kolakowska           11         			75
      9 Debica          39-200          Nieziemska           73
     10 Gi??ycko        11-500          3maja                10        					 99

*/

--A TERAZ ZLICZYMY ILE JEST ADRESOW W DANEJ MIEJSCOWOSCI(GROUP BY ADR_MIEJSCOWOSC)
PROMPT A TERAZ ZLICZYMY ILE JEST ADRESOW W DANEJ MIEJSCOWOSCI;
select ADR_MIEJSCOWOSC, COUNT(ADR_MIEJSCOWOSC) ILOSC 
from ADRESY
GROUP BY ADR_MIEJSCOWOSC;
/*
MIEJSCOWOSC     ILOSC
--------------- -----
Gi??ycko           		 2
Debica             		3
Warszawa          		 4
Krakow              		1
*/
---------------------------------------------------------------------------------
--FORMATOWANIE
column TUR_ID HEADING 'ID TURNIEJU' format 9999
column ILOSC HEADING 'ILOSC' FORMAT 9999

--ILOSC ROZEGRANYCH MECZY W TURNIEJU
PROMPT A TERAZ ZLICZYMY ILE MECZY ROZEGRANO W DANYM TURNIEJU;

select TUR_ID, COUNT(ROZ_ID) ILOSC 
from ROZEGRANE_MECZE
GROUP BY TUR_ID;
/*

ID TURNIEJU ILOSC
----------- -----
          1     6
          2     2
          3     1

*/
CLEAR COLUMNS;



--HAVING

---------------------------------------------------------------------------------
--FORMATOWANIE
column SEZ_ID HEADING 'ID' format 999999
column SEZ_ROK_ROZPOCZECIA HEADING 'DATA ROZPOCZECIA' format A21
column SEZ_ROK_ZAKONCZENIA HEADING 'DATA ZAKONCZENIA' format A21
column SEZ_RODZAJ HEADING 'MIEJSCOWOSC' format A20
column ILOSC HEADING 'ILOSC' FORMAT 9999

--WYSWIETLAM ZAWARTOSC TABELI SEZON
select * from SEZON;
/*
ID DATA ROZPOCZECIA      DATA ZAKONCZENIA      MIEJSCOWOSC
------- --------------------- --------------------- --------------------
      1 2018-05-03 00:00      2019-05-03 00:00      MISTRZOWSKI
      2 2019-05-03 00:00      2020-05-03 00:00      ZWYKLY
      3 2017-05-03 00:00      2018-05-03 00:00      MISTRZOWSKI
      4 2016-05-03 00:00      2017-05-03 00:00      ZWYKLY
      5 2015-05-03 00:00      2016-05-03 00:00      MISTRZOWSKI
      6 2014-05-03 00:00      2015-05-03 00:00      ZWYKLY
      7 2013-05-03 00:00      2014-05-03 00:00      MISTRZOWSKI
      8 2012-05-03 00:00      2013-05-03 00:00      ZWYKLY
      9 2011-05-03 00:00      2012-05-03 00:00      MISTRZOWSKI
     10 2010-05-03 00:00      2011-05-03 00:00      ZWYKLY
     11 2009-05-03 00:00      2010-05-03 00:00      MISTRZOWSKI
     12 2008-05-03 00:00      2009-05-03 00:00      ZWYKLY
     13 2007-05-03 00:00      2008-05-03 00:00      MISTRZOWSKI
     14 2006-05-03 00:00      2007-05-03 00:00      ZWYKLY

*/

--A TERAZ ZLICZYMY ILE JEST SEZONOW ZWYKLYCH(HAVING)
PROMPT A TERAZ ZLICZYMY ILE JEST SEZONOW ZWYKLYCH;

select SEZ_RODZAJ RODZAJ, COUNT(SEZ_ID) ILOSC 
from SEZON
GROUP BY SEZ_RODZAJ
HAVING SEZ_RODZAJ LIKE 'ZWYKLY';
/*
			RODZAJ               ILOSC
			-------------------- -----
			ZWYKLY                   7
*/

CLEAR COLUMNS;
------------------------------------------------------------------------------------
--FORMATOWANIE
column TUR_ID HEADING 'ID TURNIEJU' format 9999
column ILOSC HEADING 'ILOSC' FORMAT 9999

--A TERAZ ZLICZYMY ILE MECZY ROZEGRANO W TURNIEJU O ID 1;
PROMPT A TERAZ ZLICZYMY ILE MECZY ROZEGRANO W TURNIEJU O ID 1;

select TUR_ID, COUNT(ROZ_ID) ILOSC from ROZEGRANE_MECZE
GROUP BY TUR_ID
HAVING TUR_ID = 1;
CLEAR COLUMNS;

/*
					ID TURNIEJU ILOSC
					----------- -----
							  1     6

*/

------------------------------------------------------------------------------------
--FORMATOWANIE
column KAT_ID HEADING 'ID' format 999999
column KAT_TYP HEADING 'RODZAJ LICENCJI' format A20
column KAT_RANGA HEADING 'POZIOM' format A20
COLUMN KAT_OPIS HEADING 'OPIS' format A20 WRAP
column ILOSC HEADING 'ILOSC' FORMAT 9999

--A TERAZ ZLICZYMY ILE JEST KATEGORII O TYPIE SEDZIOWSKIM
PROMPT A TERAZ ZLICZYMY ILE JEST KATEGORII O TYPIE SEDZIOWSKIM;

select KAT_TYP TYP_KATEGORII, COUNT(KAT_TYP) ILOSC
from KATEGORIE
GROUP BY KAT_TYP
HAVING KAT_TYP LIKE 'SEDZIA';

/*
			TYP_KATEGORII             ILOSC
			-------------------- ----------
			SEDZIA                        8
*/




---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- ZŁĄCZENIA NIERÓWNOŚCIOWE I ZEWNĘTRZNE
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--FORMATOWANIE
column DRU_ID HEADING 'ID TEAMU' format 9999
column OSO_1 HEADING 'IMIE Z1' format A15
column OSO_2 HEADING 'IMIE Z2' format A15
column OSO_3 HEADING 'IMIE Z3' format A15
column OSO_4 HEADING 'IMIE Z4' format A15


--WYSWIETLAM IMIONA CZLONKOW DRUZYN
PROMPT WYSWIETLAM IMIONA CZLONKOW DRUZYN
SELECT
d.DRU_ID,
o1.OSO_IMIE1 AS OSO_1,
o2.OSO_IMIE1 AS OSO_2,
o3.OSO_IMIE1 AS OSO_3,
o4.OSO_IMIE1 AS OSO_4
FROM
DRUZYNY d
INNER JOIN OSOBY o1 ON d.OSO_ID1 = o1.OSO_ID
INNER JOIN OSOBY o2 ON d.OSO_ID2 = o2.OSO_ID
INNER JOIN OSOBY o3 ON d.OSO_ID3 = o3.OSO_ID
INNER JOIN OSOBY o4 ON d.OSO_ID4 = o4.OSO_ID;
/*
ID TEAMU IMIE Z1         IMIE Z2         IMIE Z3         IMIE Z4
-------- --------------- --------------- --------------- ---------------
       1 JAN             ANDRZEJ         KAMIL           MACIEK
       2 JAN             ANDRZEJ         KAMIL           MACIEK
       3 PAWEL           KAMIL           ADAM            TOMASZ
       4 PAWEL           KAMIL           JAN             ANDRZEJ
       5 MACIEK          ANDRZEJ         JAN             ADAM
 */
CLEAR COLUMNS;






PROMPT ----------------------------------------------------------;
PROMPT lab07;
PROMPT ----------------------------------------------------------;
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- lab07
----------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJE INSERT WYKORZYSTUJE Z LAB06 + PONIŻSZE
----------------------------------------------------------------------------------------------------------------
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (50,'TURNIEJEK KROLA3',7000,2,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (60,'TURNIEJEK KROLA4',8000,2,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (70,'TURNIEJEK KROLA5',5000,2,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (120,'TURNIEJEK KROLA6',3000,2,2);
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- INSTRUKCJE SELECT 
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------


--FORMATOWANIE
column TUR_ID HEADING 'ID TURNIEJU' format 9999
column TUR_NAZWA HEADING 'NAZWA TURNIEJU' format A20
column TUR_NAGRODA HEADING 'NAGRODA TURNIEJU' format 9999
column TUR_ILOSC_MIEJSC HEADING 'MIEJSCA' format 9999


--WYSWIETLAM TURNEIJE W KTORYCH NAGRODA JEST WYZSZA OD SREDNIEJ NAGRODY (STOSUJĄC AVG)
PROMPT WYSWIETLAM TURNEIJE W KTORYCH NAGRODA JEST WYZSZA OD SREDNIEJ NAGRODY;
SELECT TUR_ID,TUR_NAZWA,TUR_NAGRODA 
FROM TURNIEJE 
WHERE TUR_NAGRODA > (SELECT AVG(TUR_NAGRODA) FROM TURNIEJE);
/*
ID TURNIEJU NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- -------------------- ----------------
          2 TURNIEJEK KROLA                  6000
          3 TURNIEJEK KROLA2                 7500
          5 TURNIEJEK KROLA3                 7000
          6 TURNIEJEK KROLA4                 7500


*/


--WYSWIETLAM SREDNIA LICZBY MIESC W TURNIEJACH
SELECT AVG(TUR_ILOSC_MIEJSC) SREDNIA FROM TURNIEJE;

/*
			SREDNIA
			----------
				46.875

*/



--WYSWIETLAM LICZBY MIESC W TURNIEJACH
SELECT TUR_ILOSC_MIEJSC FROM TURNIEJE;
/*
TUR_ILOSC_MIEJSC
----------------
              15
              20
              20
              20
              50
              60
              70
             120


*/

--	WYSWIETLAM TURNEIJE W KTORYCH LICZBA MIEJSC JEST POMIEDZY SREDNIA +-20 STOSUJAC KLAUZURĘ BEETWEEN

PROMPT WYSWIETLAM TURNEIJE W KTORYCH LICZBA MIEJSC JEST POMIEDZY SREDNIA +-20;

SELECT TUR_ID,TUR_NAZWA,TUR_ILOSC_MIEJSC 
FROM TURNIEJE 
WHERE TUR_ILOSC_MIEJSC 
BETWEEN (SELECT AVG(TUR_ILOSC_MIEJSC) FROM TURNIEJE)-20 
AND (SELECT AVG(TUR_ILOSC_MIEJSC) FROM TURNIEJE)+20;

/*
ID TURNIEJU NAZWA TURNIEJU       TUR_ILOSC_MIEJSC
----------- -------------------- ----------------
          5 TURNIEJEK KROLA3                   50
          6 TURNIEJEK KROLA4                   60
*/

--FORMATOWANIE
column SZA_ID HEADING 'ID LIC' format 9999
column KAT_TYP HEADING 'TYP' format A15
column KAT_RANGA HEADING 'RANGA' format A15


--WYSWIETLAM LICENCJE SEDZIOW Z ZASTOSOWANIEM 'IN'
PROMPT WYSWIETLAM licencje sedziow;
SELECT s.SZA_ID,k.KAT_TYP,k.KAT_RANGA 
FROM SZACHOWE_LICENCJE s,KATEGORIE k
WHERE s.KAT_ID=k.KAT_ID 
AND k.KAT_TYP IN (SELECT KAT_TYP FROM KATEGORIE WHERE KAT_TYP LIKE 'S%');
/*

		ID_LICENCJI TYP                  RANGA
		----------- -------------------- --------------------
				  4 	SEDZIA               POZIOM A
				  2 	SEDZIA               POZIOM A+


*/


----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- TWORZE PERSPEKTYWY
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_TUR_NAGRODA_PONAD_AVG
(ID_TURNIEJU,NAZWA,NAGRODA)
AS
SELECT TUR_ID,TUR_NAZWA,TUR_NAGRODA FROM TURNIEJE WHERE TUR_NAGRODA > (SELECT AVG(TUR_NAGRODA) FROM TURNIEJE);

--WYSWIETLAM PERSPEKTYWE
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG ORDER BY NAGRODA;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          2 TURNIEJEK KROLA                                6000
          5 TURNIEJEK KROLA3                               7000
          6 TURNIEJEK KROLA4                               7500
          3 TURNIEJEK KROLA2                               7500

*/



CREATE OR REPLACE VIEW V_TUR_ILOSC_MIEJSC_ZAKRES
(ID_TURNIEJU,NAZWA,ILOSC_MIEJSC)
AS
SELECT TUR_ID,TUR_NAZWA,TUR_ILOSC_MIEJSC FROM TURNIEJE WHERE TUR_ILOSC_MIEJSC BETWEEN (SELECT AVG(TUR_ILOSC_MIEJSC) FROM TURNIEJE)-20 AND (SELECT AVG(TUR_ILOSC_MIEJSC) FROM TURNIEJE)+20;

--WYSWIETLAM PERSPEKTYWE
SELECT * FROM V_TUR_ILOSC_MIEJSC_ZAKRES ORDER BY ILOSC_MIEJSC;
/*

ID_TURNIEJU NAZWA                                    ILOSC_MIEJSC
----------- ---------------------------------------- ------------
          5 TURNIEJEK KROLA3                                   50
          6 TURNIEJEK KROLA4                                   60

*/



CREATE OR REPLACE VIEW V__SZA_LICENCJE_SEDZIOW
(ID_LICENCJI,TYP,RANGA)
AS
SELECT s.SZA_ID,k.KAT_TYP,k.KAT_RANGA FROM SZACHOWE_LICENCJE s,KATEGORIE k
WHERE s.KAT_ID=k.KAT_ID AND k.KAT_TYP IN (SELECT KAT_TYP FROM KATEGORIE WHERE KAT_TYP LIKE 'S%');

--WYSWIETLAM PERSPEKTYWE
SELECT * FROM V__SZA_LICENCJE_SEDZIOW;

/*

		ID_LICENCJI TYP                  RANGA
		----------- -------------------- --------------------
				  4 SEDZIA               POZIOM A
				  2 SEDZIA               POZIOM A+




*/


----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- SYMULACJA PRZY WŁĄCZONYCH WIĘZACH INTEGRALNOSCI
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

--MODYFIKACJA
-- UPDATE V_TUR_NAGRODA_PONAD_AVG
-- SET NAGRODA = 2000;
-- SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
-- Zostaly zaktualizowane wiersze będące wyswietane prze perspektywe
-- Przy ponownym wyswietleniu danych srednia sie aktualizuje( wczesniejsze 4 wyniki zmienione na 200 ją pomniejszyly)
-- DODANIE NOWYCH

-- INSERT INTO V_TUR_NAGRODA_PONAD_AVG VALUES (99,'TURNIEJ DZIKA',4000);

-- POKAZUJE SIE BLAD SPOWODOWANY POWIAZANIEM
-- ERROR at line 1:
-- ORA-01400: cannot insert NULL into
-- ("ST12K_KUSEK_JAN"."TURNIEJE"."TUR_ILOSC_MIEJSC")

-- USUWANIE

-- DELETE FROM V_TUR_NAGRODA_PONAD_AVG
-- WHERE NAZWA LIKE 'TURNIEJEK SZEFA';

-- POKAZUJE SIE BLAD SPOWODOWANY POWIAZANIEM
-- ERROR at line 1:
-- ORA-02292: integrity constraint (ST12K_KUSEK_JAN.FK_ROZEGRANE_MECZE_TUR_ID)
-- violated - child record found





----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- SYMULACJA PRZY WYŁĄCZONYCH WIĘZACH INTEGRALNOSCI
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- ALTER TABLE TURNIEJE DISABLE CONSTRAINT FK_TURNIEJE_ADR_ID;
-- ALTER TABLE TURNIEJE DISABLE CONSTRAINT FK_TURNIEJE_ADR_ID;
-- INSERT INTO V_TUR_NAGRODA_PONAD_AVG VALUES (99,'TURNIEJ DZIKA',4000);
-- DELETE FROM V_TUR_NAGRODA_PONAD_AVG
-- WHERE NAZWA LIKE 'TURNIEJ DZIKA';


-- NADAL WYSTEPUJE BLADY PONIEWAZ WIDOK NIE MA WSYZTSKICH POL WYMAGANYCH PRZEZ TABELE TURNIEJE (POLA NOT NULL) WIEC NIE MOZNA DOKONAC OPERACJI WSTAWIENIA DANYCH
-- ALTER TABLE TURNIEJE ENABLE CONSTRAINT FK_TURNIEJE_ADR_ID;
-- ALTER TABLE TURNIEJE ENABLE CONSTRAINT FK_TURNIEJE_ADR_ID;



--PODSUMOWUJAC WIDOKI MOGĄ SLUZYC DO EDYCJI DANYCH JEDNAK NALEZY PAMIETAC ZE W TAKIEJ SYTUACJI NALEZY PRZY TWORZENIU WIDOKU UWZGLEDNIC POWIAZANIA JAKIE MA TABELA I POLA KTORE WYMAGA



PROMPT ----------------------------------------------------------;
PROMPT lab08;
PROMPT ----------------------------------------------------------;
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- lab08
----------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Tworzenie indexow
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

--INDEX DLA POLA SEZ_RODZAJ
create index IX_SEZON_RODZAJ
on SEZON (SEZ_RODZAJ)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--INDEX DLA POLA KATEGORIE_TYP
create index IX_KATEGORIE_TYP
on KATEGORIE (KAT_TYP)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--INDEX DLA POLA ADR_MIEJSCOWOSC
create index IX_ADRESY_MIEJSCOWOSC
on ADRESY (ADR_MIEJSCOWOSC)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 


--INDEX DLA POLA OSO_IMIE1
create index IX_OSOBY_IMIE
on OSOBY (OSO_IMIE1)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--INDEX DLA POLA OSO_NAZWISKO
create index IX_OSOBY_NAZWISKO
on OSOBY (OSO_NAZWISKO)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX;

  --INDEX DLA POLA DRU_NAZWA
create index IX_DRUZYNY_NAZWA
on DRUZYNY (DRU_NAZWA)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--INDEX DLA POLA_MIE_ZAKWATEROWANIE
create index IX_MIEJSCA_ZAKWATEROWANIE
on MIEJSCA (MIE_ZAKWATEROWANIE)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--INDEX DLA POLA MIE_RODZAJ_SZACHOWNIC
create index IX_MIEJSCA_RODZAJ_SZACHOWNIC
on MIEJSCA (MIE_RODZAJ_SZACHOWNIC)
STORAGE (INITIAL 10k NEXT 10k) 
tablespace STUDENT_INDEX; 

--ZATWIERDZENIE INDEXOW POLECENIEM COMMIT
commit;

--FORMATOWANIE
column INDEX_NAME HEADING 'NAZWA INDEXU' format A20 WRAP
column TABLESPACE_NAME HEADING 'TABELA' format A20 WRAP
column UNIQUENESS HEADING 'UNIKALNOSC' format A20 WRAP

--WYSWIETLAM WSZYTSKIE INDEXY NIEUNIKALNE

select INDEX_NAME, TABLESPACE_NAME, UNIQUENESS from USER_INDEXES where UNIQUENESS <> 'UNIQUE';

/*

NAZWA INDEXU         TABELA               UNIKALNOSC
-------------------- -------------------- --------------------
IX_SEZON_RODZAJ      STUDENT_INDEX        NONUNIQUE
IX_OSOBY_NAZWISKO    STUDENT_INDEX        NONUNIQUE
IX_OSOBY_IMIE        STUDENT_INDEX        NONUNIQUE
IX_MIEJSCA_ZAKWATERO STUDENT_INDEX        NONUNIQUE
WANIE

IX_MIEJSCA_RODZAJ_SZ STUDENT_INDEX        NONUNIQUE
ACHOWNIC

IX_KATEGORIE_TYP     STUDENT_INDEX        NONUNIQUE
IX_DRUZYNY_NAZWA     STUDENT_INDEX        NONUNIQUE
IX_ADRESY_MIEJSCOWOS STUDENT_INDEX        NONUNIQUE


*/
--ZNAJDUJĄ SIĘ TU WSZYTSKIE INDEXY KTORE STWORZYLISMY



--WYSWIETLAM WSYZTSKIE INDEXY UNIKALNE

select INDEX_NAME, TABLESPACE_NAME, UNIQUENESS from USER_INDEXES where UNIQUENESS = 'UNIQUE';
/*
NAZWA INDEXU         TABELA               UNIKALNOSC
-------------------- -------------------- --------------------
UQ_OSOBY             STUDENT_DATA         UNIQUE
PK_ZWIAZKI           STUDENT_DATA         UNIQUE
PK_TURNIEJE          STUDENT_DATA         UNIQUE
PK_TROFEA            STUDENT_DATA         UNIQUE
PK_SZACHOWE_LICENCJE STUDENT_DATA         UNIQUE
PK_SEZON             STUDENT_DATA         UNIQUE
PK_ROZEGRANE_MECZE   STUDENT_DATA         UNIQUE
PK_OSOBY             STUDENT_DATA         UNIQUE
PK_MIEJSCA           STUDENT_DATA         UNIQUE
PK_KATEGORIE         STUDENT_DATA         UNIQUE
PK_DRUZYNY           STUDENT_DATA         UNIQUE
PK_ADRESY            STUDENT_DATA         UNIQUE



*/
--ZNAJDUJĄ SIĘ TU WSZYTSKIE KLUCZE GLOWNE I UNIKALNE DO KTORYCH INDEX TWORZY SIE SAMOCZYNNIE
CLEAR COLUMNS;

PROMPT----------------------------------------;
PROMPT TEST TRANSAKCJI;
PROMPT----------------------------------------;

--FORMATOWANIE
column TUR_ID HEADING 'ID TURNIEJU' format 9999
column TUR_NAZWA HEADING 'NAZWA TURNIEJU' format A20
column TUR_NAGRODA HEADING 'NAGRODA TURNIEJU' format 9999
column TUR_ILOSC_MIEJSC HEADING 'MIEJSCA' format 9999

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000


*/

--TWORZE PUNKT KONTROLNY
SAVEPOINT PUNKT_KONTROLNY1;

--DODAJE 2 REKORDY
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (50,'TURNIEJEK KROLA33',7000,2,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (60,'TURNIEJEK KROLA34',7000,2,2);

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;



/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000
         11      50 TURNIEJEK KROLA33                7000
         12      60 TURNIEJEK KROLA34                7000



*/

--WRACAM DO PUNKTU KONTOLRNEGO(PRZED DODANIEM REKORDOW)
ROLLBACK TO PUNKT_KONTROLNY1;


--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000


*/

--DODANIE REKORDOW ZOSTAJE COFNIĘTE


--PONOWNIE DODAJE OBA REKORDY
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (50,'TURNIEJEK KROLA33',7000,2,2);
insert into TURNIEJE (TUR_ILOSC_MIEJSC,TUR_NAZWA,TUR_NAGRODA,KAT_ID,MIE_ID)
values (60,'TURNIEJEK KROLA34',7000,2,2);

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000
         13      50 TURNIEJEK KROLA33                7000
         14      60 TURNIEJEK KROLA34                7000



*/
--REKORDY ZOSTALY DODANE LECZ NIE MAJA ID TAKICH JAK WCZESNIEJ

--ZATWIERDZAM TRANSAKCJE


COMMIT WORK;


-- ROLLBACK TO PUNKT_KONTROLNY1;

-- ROLLBACK TO PUNKT_KONTROLNY1
-- *
-- ERROR at line 1:
-- ORA-01086: savepoint 'PUNKT_KONTROLNY1' never established in this session or is invalid


--WYSTAPIL BLAD PONIEWAZ OSTATNIM MIEJSCEM DO KTOREGO MOZEMY WROCIC JEST COMMIT A SAVEPOINT

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000
         13      50 TURNIEJEK KROLA33                7000
         14      60 TURNIEJEK KROLA34                7000



*/

-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
--KOLEJNA SYMULACJA - DELETE
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

--TWORZE PUNKT KONTROLNY2
SAVEPOINT PUNKT_KONTROLNY2;


--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000
         13      50 TURNIEJEK KROLA33                7000
         14      60 TURNIEJEK KROLA34                7000



*/;

--USUWAM REKORDY O NAZWIE 'TURNIEJEK KROLA33'
DELETE FROM TURNIEJE
WHERE TUR_NAZWA LIKE 'TURNIEJEK KROLA33';

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
         10      60 TURNIEJEK KROLA34                2000
         14      60 TURNIEJEK KROLA34                7000



*/
--REKORDY ZOSTALY USUNIETE

--WYKONUJE UPDATE POLA TUR_NAZWA
UPDATE TURNIEJE SET TUR_NAZWA='ODNOWIONA NAZWA' WHERE TUR_NAZWA='TURNIEJEK KROLA34';

--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
         10      60 ODNOWIONA NAZWA                  2000
         14      60 ODNOWIONA NAZWA                  7000



*/
--REKORDY ZOSTALY ZMODYFIKOWANE

--WYKONUJE ROLLBACK DO PUNKTU KONTROLNEGO2(MIEJSCE PRZED USUWANIEM I MODYFIKACJA)
ROLLBACK TO PUNKT_KONTROLNY2;
--WYSWIETLAM ZAWARTOSC TABELI TURNIEJE
SELECT t.TUR_ID, t.TUR_ILOSC_MIEJSC,t.TUR_NAZWA,t.TUR_NAGRODA
FROM TURNIEJE t,KATEGORIE k,MIEJSCA m
WHERE t.MIE_ID=m.MIE_ID AND t.KAT_ID=k.KAT_ID;

/*

ID TURNIEJU MIEJSCA NAZWA TURNIEJU       NAGRODA TURNIEJU
----------- ------- -------------------- ----------------
          1      15 TURNIEJEK SZEFA                  3000
          2      20 TURNIEJEK KROLA                  2000
          3      20 TURNIEJEK KROLA2                 2000
          4      20 TURNIEJ PREZESA
          5      50 TURNIEJEK KROLA3                 2000
          6      60 TURNIEJEK KROLA4                 2000
          7      70 TURNIEJEK KROLA5                 5000
          8     120 TURNIEJEK KROLA6                 3000
          9      50 TURNIEJEK KROLA33                2000
         10      60 TURNIEJEK KROLA34                2000
         13      50 TURNIEJEK KROLA33                7000
         14      60 TURNIEJEK KROLA34                7000



*/
--ROLLBACK ZADZIALAL PRAWIDLOWO



-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
--TEST TRANSAKCJI W PERSPEKTYWACH PRZY MODYFIKACJI DANYCH
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

--WYSWIETLAM ZAWARTOSC PERSPEKTYWY V_TUR_NAGRODA_PONAD_AVG
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          7 TURNIEJEK KROLA5                               5000
         13 TURNIEJEK KROLA33                              7000
         14 TURNIEJEK KROLA34                              7000


*/

--TWORZE PUNKT KONTORLNY3
SAVEPOINT PUNKT_KONTROLNY3;

--WYKONUJE UPDATE POLA NAGRODA
UPDATE V_TUR_NAGRODA_PONAD_AVG
SET NAGRODA = 2000;


--WYSWIETLAM ZAWARTOSC PERSPEKTYWY V_TUR_NAGRODA_PONAD_AVG
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          1 TURNIEJEK SZEFA                                3000
          8 TURNIEJEK KROLA6                               3000


*/
--ZMIENILA SIE SREDNIA BEDACE PODSTAWA PERSPEKTYWY WIEC WYSWIETLA ONA INNE REKORDY

--WYKONUJE ROLLBACK DO PUNKTU KONTOLRNEGO3
ROLLBACK TO PUNKT_KONTROLNY3;


--WYSWIETLAM ZAWARTOSC PERSPEKTYWY V_TUR_NAGRODA_PONAD_AVG
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          7 TURNIEJEK KROLA5                               5000
         13 TURNIEJEK KROLA33                              7000
         14 TURNIEJEK KROLA34                              7000
*/


--ROLLBACK ZADZIALAL PRAWIDŁOWO

--PONOWNIE WYKONUJE UPDATE POLA NAGRODA
UPDATE V_TUR_NAGRODA_PONAD_AVG
SET NAGRODA = 2000;

--ZATWIERDZAM
COMMIT;


--WYSWIETLAM ZAWARTOSC PERSPEKTYWY V_TUR_NAGRODA_PONAD_AVG
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          1 TURNIEJEK SZEFA                                3000
          8 TURNIEJEK KROLA6                               3000


*/
--ZMIENILA SIE SREDNIA BEDACE PODSTAWA PERSPEKTYWY WIEC WYSWIETLA ONA INNE REKORDY

--KOLEJNY UPDATE POLA NAGRODA
UPDATE V_TUR_NAGRODA_PONAD_AVG
SET NAGRODA = 8000;

SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          1 TURNIEJEK SZEFA                                8000
          8 TURNIEJEK KROLA6                               8000

*/
--ZMIENILA SIE SREDNIA BEDACE PODSTAWA PERSPEKTYWY WIEC WYSWIETLA ONA INNE REKORDY


ROLLBACK;
SELECT * FROM V_TUR_NAGRODA_PONAD_AVG;
/*

ID_TURNIEJU NAZWA                                       NAGRODA
----------- ---------------------------------------- ----------
          1 TURNIEJEK SZEFA                                3000
          8 TURNIEJEK KROLA6                               3000

*/
--ROLLBACK ZADZIAŁAL PRAWIDLOWO,ZOSTALISMY COFNIECI DO OSTATNIEGO COMMITA


-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
--lab09
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

--WYSWIETLAM KAT_OPIS Z TABELI KATEGORIE
select KAT_ID, KAT_OPIS from KATEGORIE;
/*
 KAT_ID KAT_OPIS
---------- ----------------------------------------
         1
         2
         3 KATEGORIA A
         4 KATEGORIA A
         5 KATEGORIA B+
         6 KATEGORIA B+
         7 KATEGORIA B
         8
         9
        10
        11
        12
        13 KATEGORIA D+
        14 KATEGORIA D+
        15 KATEGORIA D
        16 KATEGORIA D

*/

--TWORZE PROCEDURE DO WSTAWIANIA OPISU KATEGORII 
create or replace procedure p_wstawianie__opisu_kategorii(typ KATEGORIE.KAT_TYP%TYPE, ranga KATEGORIE.KAT_RANGA%TYPE)
is
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZE POMOCNICZA ZMIENNA OPIS
	opis KATEGORIE.KAT_OPIS%TYPE;
begin
	--TWORZE PUNKT KONTROLNY
	SAVEPOINT ROZPOCZECIE_PROCEDURY;
	--TWORZE WARUNKI NA TWORZENIE OPISU
	if ranga = 'POZIOM A+' then
		opis := 'KATEGORIA A+';
	elsif ranga = 'POZIOM A' then
		opis := 'KATEGORIA A';
	elsif ranga = 'POZIOM B+' then
		opis := 'KATEGORIA B+';
	elsif ranga = 'POZIOM B' then
		opis := 'KATEGORIA B';
	elsif ranga = 'POZIOM C+' then
		opis := 'KATEGORIA C+';
	elsif ranga = 'POZIOM C' then
		opis := 'KATEGORIA C';
	elsif ranga = 'POZIOM D+' then
		opis := 'KATEGORIA D+';
	elsif ranga = 'POZIOM D' then
		opis := 'KATEGORIA D';
	else
		opis := 'NIESTANDARDOWA KATEGORIA';
	end if;
	--TWORZE DRUGI PUNKT KONTROLNY
	SAVEPOINT WSTAWIANIE_PROCEDURA;
	--WSTAWIAM NOWE POLE Z AUTOMATYCZNIE TWORZONYM OPISEM
	insert into KATEGORIE(KAT_TYP,KAT_RANGA,KAT_OPIS)
	values (typ,ranga,opis);
	--ZATWIERDZAM TRANSAKCJE
	commit;
end;
/

--TWORZE PETLE DODAJACĄ 4 REKORDY
declare
	--TWORZENIE ZMIENNYCH POMOCNICZYCH
	typ KATEGORIE.KAT_TYP%TYPE;
	ranga KATEGORIE.KAT_RANGA%TYPE;
	licznik number;
begin
	licznik := 0;
	--TWORZENIE PUNKTU KONTROLNEGO
	SAVEPOINT PETLA_PROCEDURA_START;
	--POCZATEK PETLI
	loop
		--W KAZDYM NOWYM PRZEJSCU PETLI INKREMENTUJE LICZNIK
		licznik := licznik + 1;
		--WARUNKI NADAWANIA WARTOSCI ZMIENNYM
		if licznik = 1 then
			typ := 'SEDZIA';
			ranga := 'POZIOM A+';
		elsif licznik = 2 then
			typ := 'ZAWODNIK';
			ranga := 'POZIOM A';
		elsif licznik = 3 then
			typ := 'ZAWODNIK';
			ranga := 'POZIOM B+';
		elsif licznik = 4 then
			typ := 'ZAWODNIK';
			ranga := 'SENIOR A+';
		end if;
		--KOLEJNY PUNKT KONTROLNY
		SAVEPOINT PETLA_PROCEDURA;
		--WYWOLUJE PROCEDURE Z UTWORZONYMI WCZESNIEJ ARGUMENTAMI
		p_wstawianie__opisu_kategorii(typ,ranga);
		--WARUNEK WYJSCA Z PETLI
		exit when licznik > 3;
	end loop;
end;
/
/*
Dodano nowy wiersz do SEZON - KAT_ID=17
Dodano nowy wiersz do SEZON - KAT_ID=18
Dodano nowy wiersz do SEZON - KAT_ID=19
Dodano nowy wiersz do SEZON - KAT_ID=20

PL/SQL procedure successfully completed.
*/

--WYSWIETLAM KAT_OPIS Z TABELI KATEGORIE
select KAT_ID, KAT_OPIS from KATEGORIE;
/*
  KAT_ID KAT_OPIS
---------- ----------------------------------------
         1
         2
         3 KATEGORIA A
         4 KATEGORIA A
         5 KATEGORIA B+
         6 KATEGORIA B+
         7 KATEGORIA B
         8
         9
        10
        11
        12
        13 KATEGORIA D+
        14 KATEGORIA D+
        15 KATEGORIA D
        16 KATEGORIA D
        17 KATEGORIA A+
        18 KATEGORIA A
        19 KATEGORIA B+
        20 NIESTANDARDOWA KATEGORIA
*/


----------------------------------------------------

--TWORZE FUNKCJE DO WSTAWIANIA OPISU KATEGORII 
create or replace function f_wstawianie_opisu__kategorii(typ KATEGORIE.KAT_TYP%TYPE, ranga KATEGORIE.KAT_RANGA%TYPE)
--OKRESLENIE TYPU ZWRACANEGO
return varchar2
is
--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZE ZMIENNA POMOCNICZĄ
	opis KATEGORIE.KAT_OPIS%TYPE;
begin
	--TWORZE PUNKT KONTROLNY
	SAVEPOINT PETLA_FUNKCJA_START;
	--TWORZE WARUNKI NA TWORZENIE OPISU
	if ranga = 'POZIOM A+' then
		opis := 'KATEGORIA A+';
	elsif ranga = 'POZIOM A' then
		opis := 'KATEGORIA A';
	elsif ranga = 'POZIOM B+' then
		opis := 'KATEGORIA B+';
	elsif ranga = 'POZIOM B' then
		opis := 'KATEGORIA B';
	elsif ranga = 'POZIOM C+' then
		opis := 'KATEGORIA C+';
	elsif ranga = 'POZIOM C' then
		opis := 'KATEGORIA C';
	elsif ranga = 'POZIOM D+' then
		opis := 'KATEGORIA D+';
	elsif ranga = 'POZIOM D' then
		opis := 'KATEGORIA D';
	else
		opis := 'NIESTANDARDOWA KATEGORIA';
	end if;
	--TWORZE PUNKT KONTROLNY
	SAVEPOINT WSTAWIANIE_FUNKCJA;
	--WSTAWIAM NOWE POLE Z AUTOMATYCZNIE TWORZONYM OPISEM
	insert into KATEGORIE(KAT_TYP,KAT_RANGA,KAT_OPIS)
	values (typ,ranga,opis);
	--ZATWIERDZAM TRANSAKCJE
	commit;
	--ZWRACAM KOMUNIKAT
	return('MISJA DODANIA ZAKONCZONA SUKCESEM');
end;
/


--TWORZE PETLE DODAJACĄ 4 REKORDY
declare
	--TWORZENIE ZMIENNYCH POMOCNICZYCH
	typ KATEGORIE.KAT_TYP%TYPE;
	ranga KATEGORIE.KAT_RANGA%TYPE;
	licznik number;
begin
	licznik := 0;
	--TWORZENIE PUNKTU KONTROLNEGO
	SAVEPOINT PETLA_FUNKCJA_START;
	--POCZATEK PETLI
	loop
		--W KAZDYM NOWYM PRZEJSCU PETLI INKREMENTUJE LICZNIK
		licznik := licznik + 1;
		--WARUNKI NADAWANIA WARTOSCI ZMIENNYM
		if licznik = 1 then
			typ := 'SEDZIA';
			ranga := 'POZIOM C+';
		elsif licznik = 2 then
			typ := 'ZAWODNIK';
			ranga := 'POZIOM C';
		elsif licznik = 3 then
			typ := 'ZAWODNIK';
			ranga := 'POZIOM D+';
		elsif licznik = 4 then
			typ := 'ZAWODNIK';
			ranga := 'SENIOR D+';
		end if;
		--KOLEJNY PUNKT KONTROLNY
		SAVEPOINT PETLA_FUNKCJA;
		--WYWOLUJE FUNKCJE Z UTWORZONYMI WCZESNIEJ ARGUMENTAMI I ZWRACAM JEJ WYNIK DO POLECENIA DBMS_OUTPUT.PUT_LINE
		DBMS_OUTPUT.PUT_LINE(f_wstawianie_opisu__kategorii(typ,ranga));
		--WARUNEK WYJSCA Z PETLI
		exit when licznik > 3;
	end loop;
end;
/
/*
Dodano nowy wiersz do SEZON - KAT_ID=21
MISJA DODANIA ZAKONCZONA SUKCESEM
Dodano nowy wiersz do SEZON - KAT_ID=22
MISJA DODANIA ZAKONCZONA SUKCESEM
Dodano nowy wiersz do SEZON - KAT_ID=23
MISJA DODANIA ZAKONCZONA SUKCESEM
Dodano nowy wiersz do SEZON - KAT_ID=24
MISJA DODANIA ZAKONCZONA SUKCESEM

*/




--WYSWIETLAM KAT_OPIS Z TABELI KATEGORIE
select KAT_ID, KAT_OPIS from KATEGORIE;
/*
  KAT_ID KAT_OPIS
---------- ----------------------------------------
         1
         2
         3 KATEGORIA A
         4 KATEGORIA A
         5 KATEGORIA B+
         6 KATEGORIA B+
         7 KATEGORIA B
         8
         9
        10
        11
        12
        13 KATEGORIA D+
        14 KATEGORIA D+
        15 KATEGORIA D
        16 KATEGORIA D
        17 KATEGORIA A+
        18 KATEGORIA A
        19 KATEGORIA B+
        20 NIESTANDARDOWA KATEGORIA
        21 KATEGORIA C+
        22 KATEGORIA C
        23 KATEGORIA D+
        24 NIESTANDARDOWA KATEGORIA
*/

--FUNKCJA JAK I PROCEDURA ZADZIALAY PRAWIDLOWO



PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT 	FUNKCJA DO SPRAWDZANIA POPRAWNOSCI DANYCH;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;

--FUNKCJA DO SPRAWDZANIA CZY PODANY CIAG LICZBOWY(JAKO TYP TEKSTOWY) MOZE BYC PESELEM
create or replace function f_sprawdzanie_peselu(PESEL OSOBY.OSO_PESEL%TYPE)
--OKRESLENIE TYPU ZWRACANEGO
return varchar2
is
	--TWORZENIE ZMIENNYCH POMOCNICZYCH
	pomocnicza number(4);
	komunikat varchar2(200);
begin
	--SPRAWDZENIE DLUGOSCI ARGUMENTU FUNKCJI I UMIESZCZENIE JEJ W ZMIENNEJ pomocnicza
	select LENGTH(PESEL) into pomocnicza 
	from dual;
	--WARUNEK SPRAWDZAJACY POPRAWNOSC PESELU
	if pomocnicza = 11 then
		--OKRESLENIE WARTOSCI ZMIENNEJ KOMUNIKAT
		komunikat:='Pesel podany do sprawdzenia jest poprawny';
	else
		--OKRESLENIE WARTOSCI ZMIENNEJ KOMUNIKAT
		komunikat:='Pesel podany do sprawdzenia jest bledny';
	end if;
	--ZWRACANIE zmiennej komunikat
	return(komunikat);
end;
/
begin
--WYWOLANIE FUNKCJI SPRAWDZAJACEJ Z DOBRYM PESELEM
DBMS_OUTPUT.PUT_LINE(f_sprawdzanie_peselu('12345678911'));

/*
Pesel podany do sprawdzenia jest poprawny
*/

--WYWOLANIE FUNKCJI SPRAWDZAJACEJ ZE ZLYM PESELEM
DBMS_OUTPUT.PUT_LINE(f_sprawdzanie_peselu('1234567891'));

/*
Pesel podany do sprawdzenia jest bledny
*/

end;
/



PROMPT----------------------------------------;
PROMPT -------------------lab10---------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT 	Procedura do dodawania danych (2tabele);
PROMPT----------------------------------------;
--
--FORMATOWANIE
CLEAR COLUMNS;
column V_NAZWA_ZWI HEADING 'NAZWA' format A20 WRAP
column V_MIEJSCOWOSC HEADING 'MIEJSCOWOSC' format A20 WRAP
column V_KOD HEADING 'KOD POCZT' format A10 WRAP
column V_ULICA HEADING 'ULICA' format A20 WRAP
column V_NUMER_BUDYNKU HEADING 'NR DOMU' format A10 WRAP
column V_NUMER_MIESZK HEADING 'NR DOMU' format A10 WRAP

--TWORZENIE PERSPEKTYWY V_DANE_ADRESOWE_ZWIAZKOW
CREATE OR REPLACE VIEW V_DANE_ADRESOWE_ZWIAZKOW
(V_NAZWA_ZWI,V_MIEJSCOWOSC,V_KOD,V_ULICA,V_NUMER_BUDYNKU,V_NUMER_MIESZK)
AS
SELECT z.ZWI_NAZWA,a.ADR_MIEJSCOWOSC,a.ADR_KOD_POCZTOWY,a.ADR_ULICA,a.ADR_NR_DOMU,a.ADR_NR_MIESZKANIA FROM ZWIAZKI z,ADRESY a
WHERE z.ADR_ID=a.ADR_ID;

--WYSWIETLENIE PERSPEKTYWY  V_DANE_ADRESOWE_ZWIAZKOW
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;

/*
NAZWA                MIEJSCOWOSC          KOD POCZT	 ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
*/


--	TWORZENIE PROCEDURY DO WSTAWIANIA DANYCH ZWIAZKOW
create or replace procedure PROC_WSTAW_V_DANE_ZWIAZKOW (p_NAZWA_ZWI in varchar2, p_MIEJSCOWOSC in varchar2, p_KOD in varchar2, p_ULICA in varchar2, p_NUMER_BUDYNKU in varchar2,p_NUMER_MIESZKANIA in varchar2)
is
--TWORZENIE ZMIENNEJ POMOCNICZEJ
OSTATNI_ADR_ID ADRESY.ADR_ID%TYPE;
--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
PRAGMA AUTONOMOUS_TRANSACTION;
begin 
	--WSTAWIENIE NOWEGO REKORDU DO TABELI ADRESY
	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
	values(p_MIEJSCOWOSC, p_KOD, p_ULICA, p_NUMER_BUDYNKU, p_NUMER_MIESZKANIA);
	--POBRANIE OSTATNIEGO ID ADRESU
	select SEQ_ADRESY.currval into OSTATNI_ADR_ID 
	from dual;
	--WSTAWIENIE NOWEGO REKORDU DO TABELI ZWIAZKI Z UZYCIEM WCZESNIEJ POBRANEGO ADRESU_ID
	insert into ZWIAZKI(ZWI_NAZWA, ADR_ID)
	values(p_NAZWA_ZWI,OSTATNI_ADR_ID);
	--ZATWIERDZENIE TRANSACJI
	commit;
end;
/

--WYSWIETLENIE PERSPEKTYWY  V_DANE_ADRESOWE_ZWIAZKOW
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*
NAZWA                MIEJSCOWOSC          KOD POCZT	 ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
*/

--WYWOLANIE PROCEDURY DODAJACEJ ZWIAZEK I ADRES
begin
	PROC_WSTAW_V_DANE_ZWIAZKOW('DOLNOSLASKI','Wroclaw','44-100','Slaska', '64a', '3');
end;
/

SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*
NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
*/
SELECT * FROM ZWIAZKI;
/*
ZWI_ID ZWI_NAZWA                ADR_ID
---------- -------------------- ----------
         1 PODKARPACKI                   1
         2 MALOPOLSKI                    2
         3 MAZOWIECKI                    3
         4 WARSZAWSKI                    4
         5 MAZURSKI                      5
         6 SWIETOKRZYSKI                 6
         7 LUBELSKI                      7
         8 POMORSKI                      8
         9 DOLNOSLASKI                  11


*/

SELECT ADR_ID,ADR_MIEJSCOWOSC FROM ADRESY WHERE ADR_NR_DOMU LIKE '64a';

/*

 ADR_ID ADR_MIEJSCOWOSC
---------- --------------------
        11 Wroclaw

*/

--dodano pomyslnie

PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT 	Procedura do dodawania danych (2tabele);
PROMPT 		z użyciem kursora niejawnego;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;

--TWORZENIE PROCEDURY WSTAWIAJACEJ DANE ZWIAZKOW I ADRESY  Z UZYCIEM KURSORA NIEJAWNEGO
create or replace procedure PROC_WSTAW_V_DANE_ZWIAZKOW_K (p_NAZWA_ZWI in varchar2, p_MIEJSCOWOSC in varchar2, p_KOD in varchar2, p_ULICA in varchar2, p_NUMER_BUDYNKU in varchar2,p_NUMER_MIESZKANIA in varchar2)
is
--TWORZENIE ZMIENNEJ POMOCNICZEJ
OSTATNI_ADR_ID ADRESY.ADR_ID%TYPE;
--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
PRAGMA AUTONOMOUS_TRANSACTION;
begin 
	--TWORZE PUNKT KONTROLNY W RAZIE NIEPOWODZENIA INSERTA
	SAVEPOINT SPRAWDZENIE_KLUCZA;
	--WSTAWIAM NOWY ADRES I POBIERAM ZA POMOCĄ returning ZAWARTOSC POLA ADR_ID
	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
	values(p_MIEJSCOWOSC, p_KOD, p_ULICA, p_NUMER_BUDYNKU, p_NUMER_MIESZKANIA) returning ADR_ID into OSTATNI_ADR_ID;
	--SPRAWDZENIE POBRANIA KLUCZA
	IF SQL%NOTFOUND THEN
		ROLLBACK TO SAVEPOINT SPRAWDZENIE_KLUCZA;
	END IF;
	--WSTAWIENIE NOWEGO REKORDU DO TABELI ZWIAZKI Z UZYCIEM WCZESNIEJ POBRANEGO ADRESU_ID
	insert into ZWIAZKI(ZWI_NAZWA, ADR_ID)
	values(p_NAZWA_ZWI,OSTATNI_ADR_ID);
	--ZATWIERDZENIE TRANSACJI
	commit;
end;
/

--WYSWIETLENIE PERSPEKTYWY  V_DANE_ADRESOWE_ZWIAZKOW
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*
NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
*/

--WYWOLANIE PROCEDURY DODAJACEJ ZWIAZEK I ADRES
begin
	PROC_WSTAW_V_DANE_ZWIAZKOW_K('SLASKI','Opole','43-200','DolnnoSlaska', '84a', '4');
end;
/
/*

Dodano nowy wiersz do ADRESY - ADR_ID=12
Dodano nowy wiersz do ZWIAZKI - ZWI_ID=10
*/

SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*


NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
SLASKI               Opole                43-200     DolnnoSlaska         84a        4

*/
--dodano pomyslnie

PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT				ZADANIE NA 4,5-5 		  ;
PROMPT 	Procedura tworzaca lub modyfikujaca;
PROMPT 	dane, w zaleznosci od danych w bazie;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;

--TWORZENIE PROCEDURY WSTAWIAJACEJ LUB MODYFIKUJACEJ DANE W ZALEZNOSCI OD ICH WYSTAPIENIA W BAZIE
create or replace procedure PROC_AKTU_V_DANE_ZWIAZKOW_K (p_NAZWA_ZWI in varchar2, p_MIEJSCOWOSC in varchar2, p_KOD in varchar2, p_ULICA in varchar2, p_NUMER_BUDYNKU in varchar2,p_NUMER_MIESZKANIA in varchar2)
is
--TWORZENIE ZMIENNYCH POMOCNICZYCH
OSTATNI_ADR_ID ADRESY.ADR_ID%TYPE;
LICZNIK_TABELI number;
ID_ADR_ZWIAZKU_POM number;
begin 
	--SPRAWDZENIE CZY WYSTEPUJA JAKIES DANE W TABELI ADRESY I ZAPISANIE ILE ICH JEST DO ZMIENNEJ LICZNIK_TABELI
	SELECT COUNT(a.ADR_ID) INTO LICZNIK_TABELI 
	FROM ADRESY a, ZWIAZKI z
	WHERE a.ADR_ID=z.ADR_ID AND ZWI_NAZWA LIKE p_NAZWA_ZWI;
	--SPRAWDZENIE WARUNKU NA LICZNIK TABELI
	IF LICZNIK_TABELI = 0 THEN
		--TWORZENIE PUNKTY KONTROLNEGO
		SAVEPOINT SPRAWDZENIE_KLUCZA_2;
		--BRAK DANYCH W TABELI ADRESY WIEC DODAJEMY NOWY ADRES POBIERAM ZA POMOCĄ returning ZAWARTOSC POLA ADR_ID
		insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
		values(p_MIEJSCOWOSC, p_KOD, p_ULICA, p_NUMER_BUDYNKU, p_NUMER_MIESZKANIA) returning ADR_ID into OSTATNI_ADR_ID;
		--SPRAWDZENIE POBRANIA KLUCZA
		IF SQL%NOTFOUND THEN
			ROLLBACK TO SAVEPOINT SPRAWDZENIE_KLUCZA_2;
		END IF;
			--WSTAWIENIE NOWEGO REKORDU DO TABELI ZWIAZKI Z UZYCIEM WCZESNIEJ POBRANEGO ADRESU_ID
		insert into ZWIAZKI(ZWI_NAZWA, ADR_ID)
		values(p_NAZWA_ZWI,OSTATNI_ADR_ID);
	ELSE
		--DANY ADRES JEST JUZ W BAZIE
		--WYBIERAMY JEGO ADRES ID NA PODSTAWIE DANYCH
		SELECT ADR_ID INTO ID_ADR_ZWIAZKU_POM FROM ZWIAZKI WHERE ZWI_NAZWA LIKE p_NAZWA_ZWI;
		--WYKONUJEMY UPDATE
		UPDATE ADRESY
			SET 
				ADR_MIEJSCOWOSC = p_MIEJSCOWOSC,
				ADR_KOD_POCZTOWY = p_KOD,
				ADR_ULICA = p_ULICA,
				ADR_NR_DOMU = p_NUMER_BUDYNKU,
				ADR_NR_MIESZKANIA = p_NUMER_MIESZKANIA
			WHERE 
				ADR_ID = ID_ADR_ZWIAZKU_POM;
	END IF;
end;
/

SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*
NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
SLASKI               Opole                43-200     DolnnoSlaska         84a        4


*/

--WYWOLANIE PROCEDURY (ZWIAZEK O TEJ NAZWIE ISTNIEJE WIEC WYKONA SIE UPDATE)
begin
	PROC_AKTU_V_DANE_ZWIAZKOW_K('SLASKI','Opole3','43-220','DolnnoSlaska2', '85a', '1');
end;
/

SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*
NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
SLASKI               Opole3               43-220     DolnnoSlaska2        85a        1
*/

--WYWOLANIE PROCEDURY (ZWIAZEK O TEJ NAZWIE NIE ISTNIEJE WIEC WYKONA SIE INSERT)
begin
	PROC_AKTU_V_DANE_ZWIAZKOW_K('GORNOSLASKI','Opole33','49-220','DolnnoSlaska22', '89a', '1');
end;
/
/*
Dodano nowy wiersz do ADRESY - ADR_ID=13
Dodano nowy wiersz do ZWIAZKI - ZWI_ID=11

*/
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;

/*
NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
SLASKI               Opole3               43-220     DolnnoSlaska2        85a        1
GORNOSLASKI          Opole33              49-220     DolnnoSlaska22       89a        1


*/

--ZATWIERDZENIE TRANSAKCJI
COMMIT;

--TWORZENIE PUNKTU BEZPIECZENSTWA
SAVEPOINT USUWANIE_PUNKT_BEZP;

--SEKWENCJA USUWANIA DANYCH
DELETE FROM TROFEA;
DELETE FROM ROZEGRANE_MECZE;
DELETE FROM TURNIEJE;
DELETE FROM MIEJSCA;
DELETE FROM DRUZYNY;
DELETE FROM SZACHOWE_LICENCJE;
DELETE FROM ZWIAZKI;
DELETE FROM OSOBY;
DELETE FROM ADRESY;

SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
--no rows selected
SELECT * FROM ZWIAZKI;
--no rows selected
SELECT ADR_ID FROM ADRESY ;
--no rows selected

--WYKONANIE PROCEDURY PRZY PUSTEJ BAZIE DANYCH
begin
	PROC_AKTU_V_DANE_ZWIAZKOW_K('SLASKI','Opole3','43-220','DolnnoSlaska2', '85a', '1');
end;
/
/*

Dodano nowy wiersz do ADRESY - ADR_ID=14
Dodano nowy wiersz do ZWIAZKI - ZWI_ID=12

*/

--WYSWIETLENIE ZAWARTOSCI PERSPEKTYWY 
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*

NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
SLASKI               Opole3               43-220     DolnnoSlaska2        85a        1

*/

--WYSWIETLENIE ZAWARTOSCI TABELI ZWIAZKI
SELECT * FROM ZWIAZKI ORDER BY ADR_ID;
/*

    ZWI_ID ZWI_NAZWA                ADR_ID
---------- -------------------- ----------
        12 SLASKI                       14

*/
--WYSWIETLENIE ZAWARTOSCI TABELI ADRESY
SELECT ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY FROM ADRESY;
/*
ADR_MIEJSCOWOSC       ADR_KOD_POCZTOWY
------------------------------------
Opole3                       43-220

*/

--POWROT DO PUNKTU KONTROLNEGO
ROLLBACK TO SAVEPOINT USUWANIE_PUNKT_BEZP;

--WYSWIETLENIE ZAWARTOSCI PERSPEKTYWY 
SELECT * FROM V_DANE_ADRESOWE_ZWIAZKOW;
/*


NAZWA                MIEJSCOWOSC          KOD POCZTO ULICA                NR DOMU    NR DOMU
-------------------- -------------------- ---------- -------------------- ---------- ----------
PODKARPACKI          Debica               39-200     Krakowska            13A
MALOPOLSKI           Krakow               31-878     Orlinskiego          12b        13
MAZOWIECKI           Warszawa             00-001     Krakowska            115A
WARSZAWSKI           Warszawa             00-002     Rzeszowska           11         75
MAZURSKI             Debica               39-200     Fredry               73
SWIETOKRZYSKI        Gi??ycko             11-500     Orlinskiego          10         99
LUBELSKI             Warszawa             00-001     Fredry               115A
POMORSKI             Warszawa             00-002     Kolakowska           11         75
DOLNOSLASKI          Wroclaw              44-100     Slaska               64a        3
SLASKI               Opole3               43-220     DolnnoSlaska2        85a        1
GORNOSLASKI          Opole33              49-220     DolnnoSlaska22       89a        1

*/
--ZATWIERDZENIE
COMMIT;


PROMPT----------------------------------------;
PROMPT -------------------lab11---------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT----------------------------------------;
PROMPT 	Procedura edytująca kolumne;
PROMPT----------------------------------------;



--WYKONUJE DWA INSERTY DO TABELI KATEGORIE

insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('ZAWODNIK','POZIOM F+');
insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('ZAWODNIK','POZIOM F');

---------------------------
--  PROCEDURA  DODAJACA OPIS DO TABELI KATEGORIE PROC_SET_K_KATEGORIE_UWAGI
---------------------------			
CREATE OR REPLACE PROCEDURE PROC_SET_K_KATEGORIE_UWAGI(
						p_KAT_RANGA IN KATEGORIE.KAT_RANGA%TYPE, 
						p_KAT_OPIS IN KATEGORIE.KAT_OPIS%TYPE
)
IS
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	--TWORZENIE KURSORA
	CURSOR curKAT_RANGA(cKAT_RANGA IN KATEGORIE.KAT_RANGA%TYPE)
	IS
	select * from KATEGORIE
		where KAT_RANGA = cKAT_RANGA
	FOR UPDATE of KAT_OPIS; 
	--
	--TWORZENIE ZMIENNEJ O TYPIE WIERSZOWYM
	wiersz KATEGORIE%ROWTYPE;
	--
	--TWORZENIE ZMIENNYCH POMOCNICZYCH
	ile number := 0;
	status number := 0;
BEGIN
	--
	--OTWARCIE KURSORA
	OPEN curKAT_RANGA(p_KAT_RANGA);
	--
	--PETLA
	LOOP 
	--PRZESZUKIWANIE KURSORA I ZAPISYWANIE WYNIKOW DO ZMIENNEJ WIERSZ
	FETCH curKAT_RANGA INTO wiersz; 
		--
		-- warunek wyjścia z pętli
		EXIT WHEN curKAT_RANGA%NOTFOUND OR curKAT_RANGA%ROWCOUNT <1;
		--
		--INKREMENTACJA ZMIENNEJ POMOCNICZEJ
		ile := ile + 1;
			--WARUNEK PUSTEGO OPISU
			IF wiersz.KAT_OPIS IS NULL THEN
			--
				--WARUNEK GDY ZMIENNA PODANA DO PROCEDURY NIE JEST PUSTA
				IF p_KAT_OPIS IS NOT NULL then	
					--
					-- kursor niejawny
					--UPDATE
					UPDATE KATEGORIE set KAT_OPIS = p_KAT_OPIS
					WHERE CURRENT OF curKAT_RANGA;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status := status + 1; 
					ELSE 
						status := status-1; 
						--zmiana warunku polegająca na uniknięciu niezapisania informacji gdy w bazie byłoby kilka kategorii ale któreś z pól miałoby opis.
					END IF;
				END IF;
			--
			ELSE
				ile:=ile-1;
			END IF;
		--	
	END LOOP;
	--
	--ZAMKNIECIE KURSORA
	CLOSE curKAT_RANGA;
	--
	-- prosta obsługa transakcji
	IF ile = status THEN
		DBMS_OUTPUT.PUT_LINE('PROC_SET_K_KATEGORIE_UWAGI: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('PROC_SET_K_KATEGORIE_UWAGI: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/

--NOWY WIDOK V_KATEGORIE_OPIS
CREATE OR REPLACE VIEW V_KATEGORIE_OPIS
(V_KAT_ID,V_K_OPIS)
AS
select KAT_ID, KAT_OPIS 
from KATEGORIE 
WHERE KAT_RANGA LIKE '%F+' OR KAT_RANGA LIKE '%F';


SELECT * 
FROM V_KATEGORIE_OPIS;
/*

  V_KAT_ID V_K_OPIS
---------- ----------------------------------------
        25
        26
		
*/

--WYWOŁANIE PROCEDURY
exec PROC_SET_K_KATEGORIE_UWAGI('POZIOM F+','POZIOM F+ PROC');
exec PROC_SET_K_KATEGORIE_UWAGI('POZIOM F','POZIOM F PROC');


SELECT * FROM V_KATEGORIE_OPIS;
/*

  V_KAT_ID V_K_OPIS
---------- ----------------------------------------
        25 POZIOM F+ PROC
        26 POZIOM F PROC
		
*/
--DZIAŁA PRAWIDLOWO



		
--WYKONUJE DWA INSERTY
insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
	values ('2015/03/01',7,6,3);
	
insert into SZACHOWE_LICENCJE (SZA_DATA_UZYSKANIA, OSO_ID,KAT_ID,ZWI_ID)
	values ('2013/03/01',8,6,3);
	

---------------------------
--   PROCEDURA  DODAJACA OPIS DO TABELI SZACHOWE_LICENCJE PROC_SET_K_SZACHLIC_OPIS
---------------------------	
CREATE OR REPLACE PROCEDURE PROC_SET_K_SZACHLIC_OPIS(
						p_SZA_ZWI_ID IN SZACHOWE_LICENCJE.ZWI_ID%TYPE, 
						p_SZA_OPIS IN SZACHOWE_LICENCJE.SZA_OPIS%TYPE
)
IS
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	--TWORZENIE KURSORA
	CURSOR curSZA_ZWI_ID(cSZA_ZWI_ID IN SZACHOWE_LICENCJE.ZWI_ID%TYPE)
	IS
	select * from SZACHOWE_LICENCJE
		where ZWI_ID = cSZA_ZWI_ID
	FOR UPDATE of SZA_OPIS; 
	--
	--TWORZENIE ZMIENNEJ O TYPIE WIERSZOWYM
	wiersz SZACHOWE_LICENCJE%ROWTYPE;
	--
	--TWORZENIE ZMIENNYCH POMOCNICZYCH
	ile2 number := 0;
	status2 number := 0;
BEGIN
	--
	--OTWARCIE KURSORA
	OPEN curSZA_ZWI_ID(p_SZA_ZWI_ID);
	---
	--PETLA
	LOOP 
	--PRZESZUKIWANIE KURSORA I ZAPISYWANIE WYNIKOW DO ZMIENNEJ WIERSZ
	FETCH curSZA_ZWI_ID INTO wiersz; 
		--
		-- warunek wyjścia z pętli
		EXIT WHEN curSZA_ZWI_ID%NOTFOUND OR curSZA_ZWI_ID%ROWCOUNT <1;
		--INKREMENTACJA ZMIENNEJ POMOCNICZEJ
		ile2 := ile2 + 1;
			--WARUNEK PUSTEGO OPISU
			IF wiersz.SZA_OPIS IS NULL THEN
			--	-WARUNEK GDY ZMIENNA PODANA DO PROCEDURY NIE JEST PUSTA
				IF p_SZA_OPIS IS NOT NULL then	
					--
					-- kursor niejawny
					--UPDATE
					UPDATE SZACHOWE_LICENCJE set SZA_OPIS = p_SZA_OPIS
					WHERE CURRENT OF curSZA_ZWI_ID;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status2 := status2 + 1; 
					ELSE 
						status2 := status2-1; 
						--zmiana warunku polegająca na uniknięciu niezapisania informacji gdy w bazie byłoby kilka kategorii ale któreś z pól miałoby opis.
					END IF;
				END IF;
			--
			ELSE
				ile2:=ile2-1;
			END IF;
		--	
	END LOOP;
	--ZAMKNIECIE KURSORA
	CLOSE curSZA_ZWI_ID;
	--
	-- prosta obsługa transakcji
	IF ile2 = status2 THEN
		DBMS_OUTPUT.PUT_LINE('PROC_SET_K_SZACHLIC_OPIS: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('PROC_SET_K_SZACHLIC_OPIS: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/

-- check:
--NOWY WIDOK V_SZACHLIC_ZWI_ID_OPIS
CREATE OR REPLACE VIEW V_SZACHLIC_ZWI_ID_OPIS
(V_ZWI_ID,V_OPIS)
AS
select ZWI_ID, SZA_OPIS 
from SZACHOWE_LICENCJE 
WHERE ZWI_ID=3;

SELECT * 
FROM V_SZACHLIC_ZWI_ID_OPIS;
/*


 V_ZWI_ID V_OPIS
---------- ----------------------------------------
         3 KATEGORIA A
         3
         3
		 
*/

--WYWOŁANIE PROCEDURY
exec PROC_SET_K_SZACHLIC_OPIS(3,'WYDAL ZWIAZEK O ID 3');
exec PROC_SET_K_SZACHLIC_OPIS(3,'WYDAL ZWIAZEK O ID 3');

SELECT * 
FROM V_SZACHLIC_ZWI_ID_OPIS;
/*

  V_ZWI_ID V_OPIS
---------- ----------------------------------------
         3 KATEGORIA A
         3 WYDAL ZWIAZEK O ID 3
         3 WYDAL ZWIAZEK O ID 3
		 
		 
*/

--DZIAŁA PRAWIDLOWO






--

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