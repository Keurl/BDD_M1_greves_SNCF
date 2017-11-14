SET SERVEROUTPUT ON
SET PAGESIZE 200
SET LINESIZE 100

prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE Table_Faits CASCADE CONSTRAINTS;
DROP TABLE Temps CASCADE CONSTRAINTS;
DROP TABLE Organisations CASCADE CONSTRAINTS;
DROP TABLE Metiers_Cibles CASCADE CONSTRAINTS;
DROP TABLE Motifs CASCADE CONSTRAINTS;
DROP TABLE Nb_Travailleurs CASCADE CONSTRAINTS;


prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

prompt
prompt ******************** Temps ***************************

CREATE TABLE Temps(
	ID_Temps INT,
	date_deb DATE,
	date_fin DATE,
	saison VARCHAR2(20),
	CONSTRAINT pk_Temps PRIMARY KEY(ID_Temps),
	CONSTRAINT check_deb_notnull CHECK (date_deb IS NOT NULL),
	CONSTRAINT check_debfin CHECK (date_deb <= date_fin));


prompt
prompt ******************** Organisation ***************************

CREATE TABLE Organisations(
	ID_Organisations INT,
	nom_orga VARCHAR2(1000),
	CONSTRAINT pk_Orga PRIMARY KEY(ID_Organisations));


prompt
prompt ******************** Metiers Cibles ***************************

CREATE TABLE Metiers_Cibles(
	ID_Metiers_Cibles INT,
	nom_metier VARCHAR2(1000),
	CONSTRAINT pk_Metiers_Cibles PRIMARY KEY(ID_Metiers_Cibles));


prompt
prompt ******************** Motifs ***************************

CREATE TABLE Motifs(
	ID_Motifs INT,
	motifs VARCHAR2(4000),
	categorie_greve VARCHAR2(1000),
	CONSTRAINT pk_Motifs PRIMARY KEY(ID_Motifs));


prompt
prompt ******************** Nb Travailleurs ***************************

CREATE TABLE Nb_Travailleurs(
	ID_Nb_Travailleurs INT,
	nb_supposes_travailleurs INT,
	nb_grevistes INT,
	CONSTRAINT pk_Nb_Travailleurs PRIMARY KEY(ID_Nb_Travailleurs));


prompt
prompt ******************** Table Faits ***************************

CREATE TABLE Table_Faits(
	ID_Fait INT,
	ID_Temps INT,
	ID_Organisations INT,
	ID_Metiers_Cibles INT,
	ID_Motifs INT,
	ID_Nb_Travailleurs INT,
	annee NUMBER(4,0),
	taux_grevistes NUMBER(4,2),
	duree_en_jour INT,
	CONSTRAINT pk_TableFaits PRIMARY KEY(ID_Fait),
 	CONSTRAINT fk_TF_Temps FOREIGN KEY (ID_Temps) REFERENCES Temps(ID_Temps),
 	CONSTRAINT fk_TF_Organisations FOREIGN KEY (ID_Organisations) REFERENCES Organisations(ID_Organisations),
 	CONSTRAINT fk_TF_MetiersCibles FOREIGN KEY (ID_Metiers_Cibles) REFERENCES Metiers_Cibles(ID_Metiers_Cibles),
 	CONSTRAINT fk_TF_Motifs FOREIGN KEY (ID_Motifs) REFERENCES Motifs(ID_Motifs),
 	CONSTRAINT fk_TF_NbTravailleurs FOREIGN KEY (ID_Nb_Travailleurs) REFERENCES Nb_Travailleurs(ID_Nb_Travailleurs));
