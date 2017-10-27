SET SERVEROUTPUT ON
SET PAGESIZE 200
SET LINESIZE 100

prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE Table_Faits CASCADE CONSTRAINTS;
DROP TABLE Temps CASCADE CONSTRAINTS;
DROP TABLE Orga CASCADE CONSTRAINTS;
DROP TABLE Metiers_Cibles CASCADE CONSTRAINTS;
DROP TABLE Motifs CASCADE CONSTRAINTS;
DROP TABLE Nb_Travailleurs CASCADE CONSTRAINTS;


prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

prompt
prompt ******************** Temps ***************************

CREATE TABLE Temps(
	ID_Temps INT ,
	date_deb DATE,
	date_fin DATE,
	CONSTRAINT pk_Temps PRIMARY KEY(ID_Temps),
	CONSTRAINT positive_ID_Temps CHECK (ID_Temps > 0),
	CONSTRAINT check_debfin CHECK (date_deb <= date_fin));


prompt
prompt ******************** Orga ***************************

CREATE TABLE Orga(
	ID_Orga INT,
	nom_orga VARCHAR(100),
	CONSTRAINT pk_Orga PRIMARY KEY(ID_Orga),
	CONSTRAINT positive_ID_Orga CHECK (ID_Orga > 0));


prompt
prompt ******************** Metiers Cibles ***************************

CREATE TABLE Metiers_Cibles(
	ID_Metiers_Cibles INT,
	nom_metier VARCHAR(100),
	CONSTRAINT pk_Metiers_Cibles PRIMARY KEY(ID_Metiers_Cibles),
	CONSTRAINT positive_ID_Metiers_Cibles CHECK (ID_Metiers_Cibles > 0));


prompt
prompt ******************** Motifs ***************************

CREATE TABLE Motifs(
	ID_Motifs INT,
	motifs VARCHAR(800),
	CONSTRAINT pk_Motifs PRIMARY KEY(ID_Motifs),
	CONSTRAINT positive_ID_Motifs CHECK (ID_Motifs > 0));


prompt
prompt ******************** Nb Travailleurs ***************************

CREATE TABLE Nb_Travailleurs(
	ID_Nb_Travailleurs INT,
	nb_suppose_travaille INT,
	nb_grevistes INT,
	taux_grevistes NUMBER(4,2),
	CONSTRAINT pk_Nb_Travailleurs PRIMARY KEY(ID_Nb_Travailleurs),
	CONSTRAINT positive_ID_Nb_Travailleurs CHECK (ID_Nb_Travailleurs > 0));


prompt
prompt ******************** Table Faits ***************************

CREATE TABLE Table_Faits(
	ID_Fait INT,
	ID_Temps INT,
	ID_Orga INT,
	ID_Metiers_Cibles INT,
	ID_Motifs INT,
	ID_Nb_Travailleurs INT,
	CONSTRAINT pk_TableFaits PRIMARY KEY(ID_Fait),
	CONSTRAINT positive_ID_Fait CHECK (ID_Fait > 0),
 	CONSTRAINT fk_TF_Temps FOREIGN KEY (ID_Temps) REFERENCES Temps(ID_Temps),
 	CONSTRAINT fk_TF_Orga FOREIGN KEY (ID_Orga) REFERENCES Orga(ID_Orga),
 	CONSTRAINT fk_TF_MetiersCibles FOREIGN KEY (ID_Metiers_Cibles) REFERENCES Metiers_Cibles(ID_Metiers_Cibles),
 	CONSTRAINT fk_TF_Motifs FOREIGN KEY (ID_Motifs) REFERENCES Motifs(ID_Motifs),
 	CONSTRAINT fk_TF_NbTravailleurs FOREIGN KEY (ID_Nb_Travailleurs) REFERENCES Nb_Travailleurs(ID_Nb_Travailleurs));

@tuples.sql

@requetes.sql

@privileges.sql
