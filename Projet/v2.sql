SET SERVEROUTPUT ON
SET PAGESIZE 300
SET LINESIZE 200

prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE Equipes CASCADE CONSTRAINTS;
DROP TABLE Entraineurs CASCADE CONSTRAINTS;
DROP TABLE Joueurs CASCADE CONSTRAINTS;
DROP TABLE EquipesAdverses CASCADE CONSTRAINTS;
DROP TABLE Salles CASCADE CONSTRAINTS;
DROP TABLE Rencontres CASCADE CONSTRAINTS;
DROP TABLE Arbitres CASCADE CONSTRAINTS;
DROP TABLE Cles CASCADE CONSTRAINTS;

prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************


prompt ******************** Entraineurs ***************************

/* Table R3 */
CREATE TABLE Entraineurs(	idEntr NUMBER (5,0),
							prenEntr VARCHAR2(20) NOT NULL,
							nomEntr VARCHAR2 (20) NOT NULL,
							CONSTRAINT pk_Entraineurs PRIMARY KEY(idEntr),
							CONSTRAINT check_Entraineurs1 CHECK (idEntr BETWEEN 10000 AND 99999),
							CONSTRAINT check_Entraineurs2 CHECK (MOD(FLOOR(idEntr/1000),10) = 1),
							CONSTRAINT check_Entraineurs3 CHECK (MOD(FLOOR(idEntr/100),10) = 0));


prompt ******************** Equipes ***************************
/* Table R1 */
CREATE TABLE Equipes(	nomEq VARCHAR2(50),
						nomSpo VARCHAR2(30) NOT NULL,
						nbJou INTEGER NOT NULL,
						villeEq VARCHAR2(30) NOT NULL,
						idEntr NUMBER (5,0) NOT NULL,
						sexe VARCHAR2(1) NOT NULL,
						CONSTRAINT pk_Equipes PRIMARY KEY(nomEq),
						CONSTRAINT fk_Equipes_Entraineurs FOREIGN KEY (idEntr) REFERENCES Entraineurs(idEntr),
						CONSTRAINT check_Equipes_sexe CHECK (sexe = 'H' OR sexe = 'F'));	


prompt ******************** Joueurs ***************************

/* Table R4 */
CREATE TABLE Joueurs(	idJou NUMBER (5,0),
						prenJou VARCHAR(20) NOT NULL,
						nomJou VARCHAR2(20) NOT NULL,
						posteJou VARCHAR2(20) NOT NULL,
						sexe VARCHAR2(1) NOT NULL,
						CONSTRAINT pk_Joueurs PRIMARY KEY (idJou),
						CONSTRAINT check_Joueurs1 CHECK (idJou BETWEEN 10000 AND 99999),
						CONSTRAINT check_Joueurs2 CHECK (MOD(FLOOR(idJou/1000),10) = 0),
						CONSTRAINT check_Joueurs3 CHECK (MOD(FLOOR(idJou/100),100) = 0),
						CONSTRAINT check_Joueurs_sexe CHECK (sexe = 'H' OR sexe = 'F'));


prompt ******************** EquipesAdverses ***************************

/* Table R5 */
CREATE TABLE EquipesAdverses(	equipeAdv VARCHAR2(50),
								nomSpo VARCHAR2(30) NOT NULL,
								villeEqAdv VARCHAR2(30) NOT NULL,
								CONSTRAINT pk_EquipesAdverses PRIMARY KEY (equipeAdv));


prompt ******************** Salles1 ***************************

/* Table R6 */
CREATE TABLE Salles(	nomSpo VARCHAR2(50),
						codePostal NUMBER(6,0),
						lieuSalle VARCHAR2(30) NOT NULL,
						nomSalle VARCHAR2(50) NOT NULL,
						CONSTRAINT pk_Salles PRIMARY KEY (nomSpo, codePostal));
			

prompt ******************** Arbitres ***************************

/* Table R9 */
CREATE TABLE Arbitres(	idArb NUMBER (5,0),
						prenArb VARCHAR2(20) NOT NULL,
						nomArb VARCHAR2(20) NOT NULL,
						CONSTRAINT pk_Arbitres PRIMARY KEY(idArb),
						CONSTRAINT check_Arbitres1 CHECK (idArb BETWEEN 10000 AND 99999),
						CONSTRAINT check_Arbitres2 CHECK (MOD(FLOOR(idArb/1000),10) = 0),
						CONSTRAINT check_Arbitres3 CHECK (MOD(FLOOR(idArb/100),100) = 1));


prompt ******************** Rencontres ***************************

/* Table R8 */
CREATE TABLE Rencontres(dateEvt DATE,
						heure DATE,
						equipeAdv VARCHAR2(50),
						scoreEq INTEGER NOT NULL,
						scoreAdv INTEGER NOT NULL,
						description VARCHAR2(100) NOT NULL,
						idArb NUMBER (5,0) NOT NULL,
						CONSTRAINT pk_Rencontres PRIMARY KEY(dateEvt, heure, equipeAdv),
						CONSTRAINT fk_Rencontres_EquipesAdverses FOREIGN KEY(equipeAdv) REFERENCES EquipesAdverses(equipeAdv),
						CONSTRAINT fk_Rencontres_Arbitres FOREIGN KEY(idArb) REFERENCES Arbitres(idArb));


prompt ******************** Cles ***************************

/* Table R10 */
CREATE TABLE Cles(	dateEvt DATE,
					heure DATE,
					idJou NUMBER (5,0),
					equipeAdv VARCHAR2(20),
					codePostal NUMBER(6,0),
					PRIMARY KEY(dateEvt, heure, idJou, equipeAdv, codePostal));


prompt *************************************************************
prompt ******************** CREATE INDEX ***************************
prompt *************************************************************

CREATE INDEX ind_pren_nom_ent
ON Entraineurs (prenEntr, nomEntr);

CREATE INDEX ind_pren_nom_jou
ON Joueurs (prenJou, nomJou);

CREATE INDEX ind_pren_nom_arb
ON Arbitres (prenArb, nomArb);

CREATE INDEX ind_poste_jou
ON Joueurs (posteJou);

CREATE INDEX ind_equipe_sport
ON EquipesAdverses (nomSpo);

@proctrigvue.sql

@tuples.sql

@test.sql