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
SET SERVEROUTPUT ON;
alter session set 
	nls_date_format = 'YYYY-MM-DD';
SET LINESIZE 350;
SET PAGESIZE 300;

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
PROMPT CREATE TABLE KATEGORIE - typ obiektowy;
PROMPT--------------------------------------------------------------------------------;
PROMPT ;

create table KATEGORIE
(
KAT_ID number(4) NOT NULL,
KAT_TYP varchar2(20) NOT NULL,
KAT_RANGA varchar2(20) NOT NULL
);



------------------------
	--TWORZENIE TYPU OBIEKTOWEGO
------------------------

	create or replace type KATEGORIE_OBJ as object
	(
	KATOBJ_ID number(4),
	KATOBJ_TYP varchar2(20),
	KATOBJ_RANGA varchar2(20)
	);
	/
	show errors;
------------------------
	--VIEW DLA OBIEKTU
------------------------
	
	
	create or replace view V_KATOBJ of KATEGORIE_OBJ
	with object identifier (KATOBJ_ID) as
	select KATEGORIE.KAT_ID,
	KATEGORIE.KAT_TYP,
	KATEGORIE.KAT_RANGA
	from KATEGORIE;
	
	

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
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do kategorie - KAT_ID='||:NEW.KAT_ID);
		--
	END;
	/
	------------------------
	-- DML KATEGORIE
	------------------------
	
	
	insert into V_KATOBJ (KATOBJ_TYP,KATOBJ_RANGA)
	values ('ZAWODNIK','POZIOM A');

	insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('SEDZIA','POZIOM A');
	
	
	insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('ZAWODNIK','POZIOM A+');

	insert into KATEGORIE (KAT_TYP,KAT_RANGA)
	values ('SEDZIA','POZIOM A+');


	column KATOBJ_ID HEADING 'ID' for 9999
	column KATOBJ_TYP HEADING 'TYP' for A15
	column KATOBJ_RANGA HEADING 'RANGA' for A15
	
	select count(KATOBJ_ID) from V_KATOBJ;
	select * from V_KATOBJ;	



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
	
	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
	values ('Krakow','31-878','Orlinskiego','11b','13');
	
	insert into ADRESY (ADR_MIEJSCOWOSC,ADR_KOD_POCZTOWY, ADR_ULICA, ADR_NR_DOMU,ADR_NR_MIESZKANIA)
	values ('Krakow','31-878','Orlinskiego','13b','13');

	
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

--TWORZENIE KOLEKCJI IMIONA ORAZ NAZWISKA
create or replace type
VARR_IMIONA is VARRAY(2) of varchar(50);
/
create or replace type
VARR_NAZWISKA is VARRAY(2) of varchar(50);
/



create table OSOBY
(
OSO_ID number(4) NOT NULL,
OSO_IMIONA VARR_IMIONA,
OSO_NAZWISKA VARR_NAZWISKA,
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
	PROMPT ;
	
PROMPT----------------------------------------;
PROMPT	 DML OSOBY 
PROMPT----------------------------------------;
PROMPT	 kolekcja w tabeli
PROMPT ;
--

--INSERT 

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Jan','Jakub'),VARR_NAZWISKA('Krawczyk','Bak'),'42022105224', 3);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Tomasz','Kamil'),VARR_NAZWISKA('Zawrotny'),'52022345224', 1);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('krzysiek'),VARR_NAZWISKA('Kaminski'),'62212105224', 2);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Maciek'),VARR_NAZWISKA('Tarnopolski'),'77712105224', 4);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Adrian'),VARR_NAZWISKA('Tarnopolski'),'66612105224', 4);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Krzysiek'),VARR_NAZWISKA('Tarnopolski'),'55512105224', 4);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Lukasz'),VARR_NAZWISKA('Kaminski'),'44412105224', 2);

insert into OSOBY (OSO_IMIONA, OSO_NAZWISKA, OSO_PESEL, ADR_ID)
values (VARR_IMIONA('Jakub'),VARR_NAZWISKA('Kaminski'),'33312105224', 2);


	
	column OSO_ID HEADING 'ID' format 9999
	column OSO_IMIONA HEADING 'IMIONA' format A35 WRAP
	column OSO_NAZWISKA HEADING 'NAZWISKA' format A35 WRAP
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
	insert into MIEJSCA (MIE_ILOSC_ZEGAROW, MIE_ZAKWATEROWANIE,ADR_ID,ZWI_ID)
	values (15,'TAK',1,1);

	insert into MIEJSCA (MIE_ILOSC_ZEGAROW, MIE_ZAKWATEROWANIE,ADR_ID,ZWI_ID)
	values (20,'NIE',2,2);

	
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
TUR_NAGRODA number(4) NOT NULL,
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



PROMPT----------------------------------------;
PROMPT 	Obsługa kolekcji
PROMPT----------------------------------------;



--FORMATOWANIE
--
	column OSO_ID HEADING 'ID' format 9999
	column OSO_IMIONA HEADING 'IMIONA' format A35 WRAP
	column OSO_NAZWISKA HEADING 'NAZWISKA' format A35 WRAP
	column OSO_PESEL HEADING 'PESEL' format A11
	column ADR_ID HEADING 'ID ADRESUU' format 9999
	
--PROCEDURA DO USUWANIA IMION
create or replace procedure P_USUN_IMIE(p_id in OSOBY.OSO_ID%TYPE, p_IMIONA in number)
is
	--ZMIENNE POMOCNICZE
	imie varchar2(50);
	imiona OSOBY.OSO_IMIONA%TYPE;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_LAST_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_LAST_ERROR,-20011);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20012);
begin
	--ZAPIS IMION DO ZMIENNEJ POMOCNICZEJ
	select OSO_IMIONA into imiona 
	from OSOBY where OSO_ID =p_id;
	--SPRAWDZENIE ILOSCI IMION
	if imiona.count = 1 then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20011,'Nie mozna usunac imienia.');
	else
		--SPRAWDZENIE KTORE IMIE USUWAMY
		if p_IMIONA = 1 then
			imie := imiona(2);
		else
			imie := imiona(1);
		end if;
		imiona := VARR_IMIONA(imie);
	end if;
	--USUNIECIE IMIENIA ZA POMOCA WSTAWIENIA NOWEGO SETU IMION
	update OSOBY 
	set OSO_IMIONA = imiona
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20012,'Nie udalo sie usunac imienia');
	end if;
	--ZATWIERDZENIE
	commit;
--OBSLUGA BLEDOW
exception
	when EX_LAST_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_USUN_IMIE - Wykryto blad');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_USUN_IMIE - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_USUN_IMIE!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--
select * 
from OSOBY;
/*

 ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Krawczyk', 'Bak')    42022105224          3
    2 VARR_IMIONA('Tomasz', 'Kamil')      VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek')             VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2


*/


PROMPT USUNE 1 IMIE OSOBY O INDESIE 2
EXEC P_USUN_IMIE(2, 1);
select * 
from OSOBY;

/*


   ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Krawczyk', 'Bak')    42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek')             VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2


*/


PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;

--PROCEDURA DO USUWANIA NAZWISK
create or replace procedure P_USUN_NAZWISKO(p_id in OSOBY.OSO_ID%TYPE, p_NAZWISK0 in number)
is
	--ZMIENNE POMOCNICZE
	nazwisko varchar2(50);
	nazwiska OSOBY.OSO_NAZWISKA%TYPE;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_LAST_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_LAST_ERROR,-20011);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20012);
begin
--ZAPIS NAZWISK DO ZMIENNEJ POMOCNICZEJ
	select OSO_NAZWISKA into nazwiska 
	from OSOBY where OSO_ID = p_id;
	--SPRAWDZENIE ILOSCI NAZWISK
	if nazwiska.count = 1 then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20011,'Nie mozna usunac nazwiskonia.');
	else
	--SPRAWDZENIE KTORE NAZWISKO USUWAMY
		if p_NAZWISK0 = 1 then
			nazwisko := nazwiska(2);
		else
			nazwisko := nazwiska(1);
		end if;
		nazwiska := VARR_NAZWISKA(nazwisko);
	end if;
	--USUNIECIE NAZWISKA ZA POMOCA WSTAWIENIA NOWEGO SETU NAZWISK
	update OSOBY 
	set OSO_NAZWISKA = nazwiska
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20012,'Nie udalo sie usunac nazwiska');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_LAST_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_USUN_NAZWISKO - Wykryto blad');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_USUN_NAZWISKO - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_USUN_NAZWISKO!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--
select * 
from OSOBY;
/*



   ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Krawczyk', 'Bak')    42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek')             VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2



*/
PROMPT USUNE 1 NAZWISKO OSOBY O INDESIE 1
EXEC P_USUN_NAZWISKO(1, 1);
select * 
from OSOBY;
/*



   ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek')             VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2



*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
	
--PROCEDURA DO DODAWANIA IMION
create or replace procedure P_INSERT_IMIE(p_id in OSOBY.OSO_ID%TYPE, p_IMIE in varchar2)
is
	--ZMIENNE POMOCNICZE
	imiona OSOBY.OSO_IMIONA%TYPE;
	imie varchar2(50);
	PRAGMA AUTONOMOUS_TRANSACTION;
	
	EX_TOO_MANY_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_TOO_MANY_ERROR,-20001);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20002);

begin
	select OSO_IMIONA into imiona 
	from OSOBY
	where OSO_ID = p_id;
	--SPRAWDZENIE CZY SA DWA IMIIONA
	if imiona.count >= 2 then
		RAISE_APPLICATION_ERROR(-20001,'Nie mozna dodac wiecej niz 2 imiona');
	else
		--SPRAWDZENIE KTORE IMIE DODAJEMY
		if imiona.exists(1) then
			imie := imiona(1);
		else
			imie := imiona(2);
		end if;
		imiona := VARR_IMIONA(imie, p_IMIE);
	end if;
	--UPDATE
	update OSOBY 
	set OSO_IMIONA = imiona
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20002,'Nie udalo sie dodac imienia');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_TOO_MANY_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_INSERT_IMIE - Wykryto blad ');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_INSERT_IMIE - Wykryto blad ');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_INSERT_IMIE!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/

--
select * 
from OSOBY;
/*

   ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek')             VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2



*/
PROMPT DODA IMIE OSOBIE O INDESIE 3
EXEC P_INSERT_IMIE(3, 'Michal');
select * 
from OSOBY;
/*



   ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2


*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
--PROCEDURA DO DODAWANIA NAZWISK
create or replace procedure P_INSERT_NAZWISKO(p_id in OSOBY.OSO_ID%TYPE, p_NAZWISKO in varchar2)
is
	--ZMIENNE POMOCNICZE
	nazwisko varchar2(50);
	nazwiska OSOBY.OSO_NAZWISKA%TYPE;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_TOO_MANY_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_TOO_MANY_ERROR,-20001);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20002);

begin
	select OSO_NAZWISKA into nazwiska
	from OSOBY 
	where OSO_ID = p_id;
	--SPRAWDZENIE CZY SA DWA NAZWISKA
	if nazwiska.count >= 2 then
		RAISE_APPLICATION_ERROR(-20001,'Nie mozna dodac wiecej niz 2 nazwiska');
	else
		--SPRAWDZENIE KITORE NAZWISKO DODAJEMY
		if nazwiska.exists(1) then
			nazwisko := nazwiska(1);
		else
			nazwisko := nazwiska(2);
		end if;
		nazwiska := VARR_NAZWISKA(nazwisko, p_NAZWISKO);
	end if;
	--UPDATE
	update OSOBY 
	set OSO_NAZWISKA = nazwiska
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20002,'Nie udalo sie dodac imienia');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_TOO_MANY_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_INSERT_NAZWISKO - Wykryto blad ');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_INSERT_NAZWISKO - Wykryto blad ');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_INSERT_NAZWISKO!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/

--
select * 
from OSOBY;
/*

 ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny')           52022345224          1
    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2




*/
PROMPT DODA NAZWISKO OSOBIE O INDESIE 2
EXEC P_INSERT_NAZWISKO(2, 'Kaminski');
select * 
from OSOBY;
/*

  ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny', 'Kaminski 52022345224          1
                                          ')

    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2



*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
--PROCEDURA DO WYBIERANIA IMION
create or replace procedure P_SELECT_IMIE(a_imie in varchar2, n_IX_IMIENIA in number)
is
	cursor cur_IMIONA IS
		select * 
		from OSOBY;
		--ZMIENNA POMOCNICZA TYPU WIERSZOWEGO
	rekord CUR_IMIONA%ROWTYPE;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
begin
	--OTWARCIE KURSORA
	open cur_IMIONA;
	loop fetch cur_IMIONA into rekord;
		--WARUNEK ZATRZYMANIA PETLI
		exit when cur_IMIONA%NOTFOUND;
		--SPRAWDZENIE CZY SA IMIIONA
		if rekord.OSO_IMIONA.EXISTS(n_IX_IMIENIA) then
			if rekord.OSO_IMIONA(n_IX_IMIENIA) = a_imie then
				--SPRAWDZENIE CZY SA DWA IMIIONA
				if rekord.OSO_IMIONA.count = 2 then
					--SPRAWDZENIE CZY SA DWA NAZWISKA
					if rekord.OSO_NAZWISKA.count =2 then
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||', '||rekord.OSO_IMIONA(2)||'------
							nazwiska: '||rekord.OSO_NAZWISKA(1)||','||rekord.OSO_NAZWISKA(2)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					else
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||', '||rekord.OSO_IMIONA(2)||'------
							nazwisko: '||rekord.OSO_NAZWISKA(1)||'------ 
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					end if;
				else
					--SPRAWDZENIE CZY SA DWA NAZWISKA
					if rekord.OSO_NAZWISKA.count =2 then
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||'------ 
							nazwiska: '||rekord.OSO_NAZWISKA(1)||','||rekord.OSO_NAZWISKA(2)||'------ 
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					else
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||' ------ 
							imiona: '||rekord.OSO_IMIONA(1)||' ------
							nazwisko: '||rekord.OSO_NAZWISKA(1)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					end if;
				end if;
			end if;
		end if;
	end loop;
	--ZAMKNIECIE KURSORA
	close cur_IMIONA;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_SELECT_IMIE!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--

PROMPT WYSZUKA OSOBE O PIERWSZYM IMIENIU TOMASZ
EXEC P_SELECT_IMIE('Tomasz', 1);
/*

---------(BRAK REKORDU)



*/
PROMPT WYSZUKA OSOBE O DRUGIM IMIENIU JAKUB
EXEC P_SELECT_IMIE('Jakub', 2);
/*

 ID: 1------
                                                        imiona: Jan, Jakub------
                                                        nazwisko: Bak------
                                                        PESEL: 42022105224------
                                                        ID_adresu: 3



*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
--PROCEDURA DO WYBIERANIA NAZWISK
create or replace procedure P_SELECT_NAZWISKO(a_nazwisko in varchar2, n_IX_NAZWISKA in number)
is
	cursor cur_NAZWISKA IS
		select * 
		from OSOBY;
		--ZMIENNA POMOCNICZA TYPU WIERSZOWEGO
	rekord CUR_NAZWISKA%ROWTYPE;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
begin
	open cur_NAZWISKA;
	loop fetch cur_NAZWISKA into rekord;
		--WARUNEK ZATRZYMANIA PETLI
		exit when cur_NAZWISKA%NOTFOUND;
		--SPRAWDZENIE CZY SĄ NAZWISKA
		if rekord.OSO_NAZWISKA.EXISTS(n_IX_NAZWISKA) then
			if rekord.OSO_NAZWISKA(n_IX_NAZWISKA) = a_nazwisko then
				--SPRAWDZENIE CZY SA DWA NAZWISKA
				if rekord.OSO_NAZWISKA.count = 2 then
					--SPRAWDZENIE CZY SA DWA IMIIONA
					if rekord.OSO_IMIONA.count =2 then
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||', '||rekord.OSO_IMIONA(2)||'------
							nazwiska: '||rekord.OSO_NAZWISKA(1)||','||rekord.OSO_NAZWISKA(2)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					else
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||'------ 
							nazwiska: '||rekord.OSO_NAZWISKA(1)||','||rekord.OSO_NAZWISKA(2)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					end if;
				else
					--SPRAWDZENIE CZY SĄ DWA IMIONA
					if rekord.OSO_IMIONA.count =2 then
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||'------
							imiona: '||rekord.OSO_IMIONA(1)||', '||rekord.OSO_IMIONA(2)||'------
							nazwisko: '||rekord.OSO_NAZWISKA(1)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					else
						DBMS_OUTPUT.PUT_LINE('
							ID: '||rekord.OSO_ID||' ------ 
							imiona: '||rekord.OSO_IMIONA(1)||' ------
							nazwisko: '||rekord.OSO_NAZWISKA(1)||'------
							PESEL: '||rekord.OSO_PESEL||'------
							ID_adresu: '||rekord.ADR_ID);
					end if;
				end if;
			end if;
		end if;
	end loop;
	close cur_NAZWISKA;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_SELECT_NAZWISKO!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--


PROMPT WYSZUKA OSOBE O PIERWSZYM NAZWISKU ZAWROTNY
EXEC P_SELECT_NAZWISKO('Zawrotny', 1);
/*

ID: 2------
                                                        imiona: Kamil------
                                                        nazwiska: Zawrotny,Kaminski------
                                                        PESEL: 52022345224------
                                                        ID_adresu: 1



*/
PROMPT WYSZUKA OSOBE O DRUGIM NAZWISKU BAK
EXEC P_SELECT_NAZWISKO('Bak', 1);
/*



                                                        ID: 1------
                                                        imiona: Jan, Jakub------
                                                        nazwisko: Bak------
                                                        PESEL: 42022105224------
                                                        ID_adresu: 3


*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
--PROCEDURA DO DODAWANIA/EDYTOWANIA IMION
create or replace procedure P_EDIT_INSERT_IMIE(p_id in OSOBY.OSO_ID%TYPE, p_IX_IMIENIA in number, p_imie in varchar2)
is
	--ZMIENNE POMOCNICZE
	imiona OSOBY.OSO_IMIONA%TYPE;
	imie varchar2(50);
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_TOO_MANY_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_TOO_MANY_ERROR,-20021);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20022);
begin
	select OSO_IMIONA into imiona
	from OSOBY
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if p_IX_IMIENIA > 2 then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20021,'Moga byc tylko 2 imiona');
	--SPRAWDZENIE KTORE IMIE DODAJEMY/EDYTUJEMY
	elsif p_IX_IMIENIA = 1 then
		if imiona.EXISTS(2) then
			imie := imiona(2);
			imiona := VARR_IMIONA(p_imie, imie);
		else
			imiona := VARR_IMIONA(p_imie);
		end if;
	else
		imie := imiona(1);
		imiona := VARR_IMIONA(imie, p_imie);
	end if;
	--UPDATE
	update OSOBY 
	set OSO_IMIONA = imiona
	where OSO_ID = p_id;
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20022,'Nie udalo sie dodac lub zmienic imienia');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_TOO_MANY_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_EDIT_INSERT_IMIE - Wykryto blad');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_EDIT_INSERT_IMIE - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_EDIT_INSERT_IMIE!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--	

select * 
from OSOBY;
/*

  ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Kamil')                VARR_NAZWISKA('Zawrotny', 'Kaminski 52022345224          1
                                          ')

    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2




*/
PROMPT DODA/EDYTUJE OSOBIE O ID 2, PIERWSZE IMIE GRZEGORZ
EXEC P_EDIT_INSERT_IMIE(2, 1, 'Grzegorz');
PROMPT DODA/EDYTUJE OSOBIE O ID 2, DRUGIE IMIE JAN
EXEC P_EDIT_INSERT_IMIE(2, 2, 'Jan');
select * 
from OSOBY;
/*


ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Grzegorz', 'Jan')      VARR_NAZWISKA('Zawrotny', 'Kaminski 52022345224          1
                                          ')

    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2

8 rows selected.


*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;

--PROCEDURA DO EDYTOWANIA/DODANIA NAZWISK
create or replace procedure P_EDIT_INSERT_NAZWISKO(p_id in OSOBY.OSO_ID%TYPE, p_IX_NAZWISKA in number, p_nazwisko in varchar2)
is
	--ZMIENNE POMOCNICZE
	nazwiska OSOBY.OSO_NAZWISKA%TYPE;
	nazwisko varchar2(50);
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_TOO_MANY_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_TOO_MANY_ERROR,-20021);
	EX_INSERT_ERROR EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_INSERT_ERROR,-20022);
begin
	select OSO_NAZWISKA into nazwiska
	from OSOBY 
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if p_IX_NAZWISKA > 2 and p_IX_NAZWISKA < 1 then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20021,'Moga byc tylko 2 nazwiska');
	--SPRAWDZENIE KTORE NAZWISKO ZMIENIAMY/DODAJEMY
	elsif p_IX_NAZWISKA = 1 then
		if nazwiska.EXISTS(2) then
			nazwisko := nazwiska(2);
			nazwiska := VARR_NAZWISKA(p_nazwisko, nazwisko);
		else
			nazwiska := VARR_NAZWISKA(p_nazwisko);
		end if;
	else
		nazwisko := nazwiska(1);
		nazwiska := VARR_NAZWISKA(nazwisko, p_nazwisko);
	end if;
	--UPDATE
	update OSOBY 
	set OSO_NAZWISKA = nazwiska
	where OSO_ID = p_id;
	--SPRAWDZENIE
	if sql%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20022,'Nie udalo sie dodac lub zmienic nazwiska');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_TOO_MANY_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_EDIT_INSERT_NAZWISKO - Wykryto blad');
	when EX_INSERT_ERROR then
		DBMS_OUTPUT.PUT_LINE('P_EDIT_INSERT_NAZWISKO - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_EDIT_INSERT_NAZWISKO!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--	

select * 
from OSOBY;
/*

ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak')                42022105224          3
    2 VARR_IMIONA('Grzegorz', 'Jan')      VARR_NAZWISKA('Zawrotny', 'Kaminski 52022345224          1
                                          ')

    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2



*/
PROMPT DODA/EDYTUJE OSOBIE O ID 1, DRUGIE NAZWISKO BYCZEK
EXEC P_EDIT_INSERT_NAZWISKO(1, 2, 'Byczek');
PROMPT DODA/EDYTUJE OSOBIE O ID 2, PIERWSZE NAZWISKO KIEDYSZAWROTNY
EXEC P_EDIT_INSERT_NAZWISKO(2, 1, 'KiedysZawrotny');
select * 
from OSOBY;
/*


 ID IMIONA                              NAZWISKA                            PESEL       ID ADRESUU
----- ----------------------------------- ----------------------------------- ----------- ----------
    1 VARR_IMIONA('Jan', 'Jakub')         VARR_NAZWISKA('Bak', 'Byczek')      42022105224          3
    2 VARR_IMIONA('Grzegorz', 'Jan')      VARR_NAZWISKA('KiedysZawrotny', 'Ka 52022345224          1
                                          minski')

    3 VARR_IMIONA('krzysiek', 'Michal')   VARR_NAZWISKA('Kaminski')           62212105224          2
    4 VARR_IMIONA('Maciek')               VARR_NAZWISKA('Tarnopolski')        77712105224          4
    5 VARR_IMIONA('Adrian')               VARR_NAZWISKA('Tarnopolski')        66612105224          4
    6 VARR_IMIONA('Krzysiek')             VARR_NAZWISKA('Tarnopolski')        55512105224          4
    7 VARR_IMIONA('Lukasz')               VARR_NAZWISKA('Kaminski')           44412105224          2
    8 VARR_IMIONA('Jakub')                VARR_NAZWISKA('Kaminski')           33312105224          2


*/
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
	
	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	

PROMPT  OBSLUGA TYPU OBIEKTOWEGO	
	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;	
PROMPT----------------------------------------;
--FORMATOWANIE
	column KATOBJ_ID HEADING 'ID' for 9999
	column KATOBJ_TYP HEADING 'TYP' for A25
	column KATOBJ_RANGA HEADING 'RANGA' for A25	


SELECT * 
FROM V_KATOBJ;
/*

 ID TYP                       RANGA
----- ------------------------- -------------------------
    1 ZAWODNIK                  POZIOM A
    2 SEDZIA                    POZIOM A
    3 ZAWODNIK                  POZIOM A+
    4 SEDZIA                    POZIOM A+

*/
--PROCEDURA DO DODAWANIA KATEGORII
Create or replace procedure P_INSERT_KATEGORIAOBJ(liczba_rekordow IN number)
is
	--ZMIENNE POMOCNICZE TYPU TABLICOWEGO
	type TRANGA is VARRAY(128) of VARCHAR2(255);
	type TTYP is VARRAY(128) of VARCHAR2(255);
	--ZMIENNE POMOCNICZE
	n_TYP KATEGORIE.KAT_TYP%TYPE;
	n_RANGA KATEGORIE.KAT_RANGA%TYPE;
	--TWORZENIE TABLIC
	lista_typow TTYP :=TTYP('KATEGORIA A+','KATEGORIA A','KATEGORIA B+','KATEGORIA B','KATEGORIA C+','KATEGORIA C','KATEGORIA D+','KATEGORIA D','KATEGORIA E+','KATEGORIA E','KATEGORIA F+','KATEGORIA F','KATEGORIA G+','KATEGORIA G','KATEGORIA H+','KATEGORIA H','KATEGORIA I+','KATEGORIA J+','KATEGORIA I','KATEGORIA K+','KATEGORIA K','KATEGORIA L','KATEGORIA M','KATEGORIA N','KATEGORIA O','KATEGORIA P','KATEGORIA R');
	lista_rang TTYP := TTYP('ZAWODNIK','SEDZIA','ZAWODNIK1','SEDZIA1','ZAWODNIK2','SEDZIA2','ZAWODNIK3','SEDZIA3','ZAWODNIK4','SEDZIA4','ZAWODNIK5','SEDZIA5');
	--ZMIENNE POMOCNICZE INDEXY
	ix_typ number;
	ix_ranga number;
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_KATEGORIA_INSERT EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_KATEGORIA_INSERT,-20031);
begin
	--PETLA FOR
	for var_i in 1 .. liczba_rekordow
	loop
		--WYBRANIE LOSOWO INDEXOW
		ix_typ := floor(DBMS_RANDOM.VALUE(1,lista_typow.COUNT+0.9));
		ix_ranga := floor(DBMS_RANDOM.VALUE(1,lista_rang.COUNT+0.9));
		--WYBRANIE Z TABEL NA PODSTAWIE INDEXOW
		n_TYP := lista_typow(ix_typ);
		n_RANGA := lista_rang(ix_ranga);
		--DODANIE REKORDU
		insert into V_KATOBJ(KATOBJ_TYP,KATOBJ_RANGA)
		values(n_TYP,n_RANGA);
	end loop;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_KATEGORIA_INSERT then
		DBMS_OUTPUT.PUT_LINE('P_INSERT_KATEGORIAOBJ - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_INSERT_KATEGORIAOBJ!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/
--
exec P_INSERT_KATEGORIAOBJ(5);
SELECT * 
FROM V_KATOBJ;
/*

   ID TYP                       RANGA
----- ------------------------- -------------------------
    1 ZAWODNIK                  POZIOM A
    2 SEDZIA                    POZIOM A
    3 ZAWODNIK                  POZIOM A+
    4 SEDZIA                    POZIOM A+
    5 KATEGORIA H               SEDZIA3
    6 KATEGORIA D               SEDZIA4
    7 KATEGORIA I+              SEDZIA2
    8 KATEGORIA E               SEDZIA1
    9 KATEGORIA P               SEDZIA3

9 rows selected.



*/

--PROCEDURA DO MODYFIKACJI TYPU
create or replace procedure P_UPDATE_KATOBJ_TYP(p_id in V_KATOBJ.KATOBJ_ID%TYPE, p_TYP in V_KATOBJ.KATOBJ_TYP%TYPE)
is
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_UPDATE_KATOBJ_TYP EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_UPDATE_KATOBJ_TYP,-20061);
begin
	--UPDATE
	update V_KATOBJ 
	set KATOBJ_TYP = p_TYP 
	where KATOBJ_ID = p_id;
	--SPRAWDZENIE
	if SQL%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20061,'BRAK REKORDU O PODANYM ID');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_UPDATE_KATOBJ_TYP then
		DBMS_OUTPUT.PUT_LINE('P_UPDATE_KATOBJ_TYP - Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_UPDATE_KATOBJ_TYP!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/

exec P_UPDATE_KATOBJ_TYP(2,'TYP ZMIENIONY');
SELECT * 
FROM V_KATOBJ;
/*


   ID TYP                       RANGA
----- ------------------------- -------------------------
    1 ZAWODNIK                  POZIOM A
    2 TYP ZMIENIONY             POZIOM A
    3 ZAWODNIK                  POZIOM A+
    4 SEDZIA                    POZIOM A+
    5 KATEGORIA H               SEDZIA3
    6 KATEGORIA D               SEDZIA4
    7 KATEGORIA I+              SEDZIA2
    8 KATEGORIA E               SEDZIA1
    9 KATEGORIA P               SEDZIA3

9 rows selected.


*/
--PROCEDURA DO MODYFIKACJI RANGI
create or replace procedure P_UPDATE_KATOBJ_RANGA(p_id in V_KATOBJ.KATOBJ_ID%TYPE, p_RANGA in V_KATOBJ.KATOBJ_TYP%TYPE)
is
	--DODAJE DYREKTYWE AUTONOMICZNYCH TRANSAKCJI
	PRAGMA AUTONOMOUS_TRANSACTION;
	--TWORZENIE OBIEKÓW WYJĄTKÓW
	EX_UPDATE_KATOBJ_RANGA EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_UPDATE_KATOBJ_RANGA,-20061);
begin
	--UPDATE
	update V_KATOBJ
	set KATOBJ_RANGA= p_RANGA 
	where KATOBJ_ID = p_id;
	--SPRAWDZENIE
	if SQL%NOTFOUND then
		ROLLBACK;
		RAISE_APPLICATION_ERROR(-20061,'BRAK REKORDU O PODANYM ID');
	end if;
	--ZATWIERDZENIE
	commit;
	--OBSLUGA BLEDOW
exception
	when EX_UPDATE_KATOBJ_RANGA then
		DBMS_OUTPUT.PUT_LINE('P_UPDATE_KATOBJ_RANGA- Wykryto blad');
	when OTHERS then
		DBMS_OUTPUT.PUT_LINE('Nieokreslony blad w procedurze P_UPDATE_KATOBJ_RANGA!');
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
		DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_CALL_STACK);
end;
/

exec P_UPDATE_KATOBJ_RANGA(2,'RANGA ZMIENIONA');
SELECT * 
FROM V_KATOBJ;
/*
   ID TYP                       RANGA
----- ------------------------- -------------------------
    1 ZAWODNIK                  POZIOM A
    2 TYP ZMIENIONY             RANGA ZMIENIONA
    3 ZAWODNIK                  POZIOM A+
    4 SEDZIA                    POZIOM A+
    5 KATEGORIA H               SEDZIA3
    6 KATEGORIA D               SEDZIA4
    7 KATEGORIA I+              SEDZIA2
    8 KATEGORIA E               SEDZIA1
    9 KATEGORIA P               SEDZIA3





*/


-- Z RACJI WYBORU TABELI WSZYSTKIE OPERACJE WYKONUJA SIĘ ANALOGICZNIE DO STANDARDOWEGO TYPU TABELI

	
	
	
	
	
	
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