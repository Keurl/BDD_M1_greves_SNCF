prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE Equipes1 CASCADE CONSTRAINTS;
DROP TABLE Equipes2 CASCADE CONSTRAINTS;
DROP TABLE Entraineurs CASCADE CONSTRAINTS;
DROP TABLE Joueurs CASCADE CONSTRAINTS;
DROP TABLE EquipesAdverses CASCADE CONSTRAINTS;
DROP TABLE Salles1 CASCADE CONSTRAINTS;
DROP TABLE Salles2 CASCADE CONSTRAINTS;
DROP TABLE Rencontres CASCADE CONSTRAINTS;
DROP TABLE Arbitres CASCADE CONSTRAINTS;
DROP TABLE Cles CASCADE CONSTRAINTS;

prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

prompt ******************** Equipes1 ***************************
/* Table R1 */
CREATE TABLE Equipes1(	nomEq VARCHAR2(50),
						nomSpo VARCHAR(30) NOT NULL,
						nbJou INTEGER NOT NULL,
						CONSTRAINT pk_Equipes1 PRIMARY KEY(nomEq));	

prompt ******************** Entraineurs ***************************

/* Table R3 */
CREATE TABLE Entraineurs(	idEntr NUMBER (5,0),
							prenEntr VARCHAR2(20) NOT NULL,
							nomEntr VARCHAR2 (20) NOT NULL,
							CONSTRAINT pk_Entraineurs PRIMARY KEY(idEntr),
							CONSTRAINT check_Entraineurs1 CHECK (idEntr BETWEEN 10000 AND 99999),
							CONSTRAINT check_Entraineurs2 CHECK (MOD((idEntr/1000),10) = 1),
							CONSTRAINT check_Entraineurs3 CHECK (MOD((idEntr/100),100) = 0));

prompt ******************** Equipes2 ***************************

/* Table R2 */
CREATE TABLE Equipes2(	nomSpo VARCHAR(30),
						nomEq VARCHAR2(50) NOT NULL,
						villeEq VARCHAR2(30) NOT NULL,
						idEntr NUMBER (5,0) NOT NULL,
						CONSTRAINT pk_Equipes2 PRIMARY KEY (nomSpo),
						CONSTRAINT fk_Equipes2_Equipes1 FOREIGN KEY (nomEq) REFERENCES Equipes1(nomEq),
						CONSTRAINT fk_Equipes2_Entraineurs FOREIGN KEY (idEntr) REFERENCES Entraineurs(idEntr));	 

ALTER TABLE Equipes1 ADD CONSTRAINT fk_Equipes1_Equipes2 FOREIGN KEY (nomSpo) REFERENCES Equipes2(nomSpo);

prompt ******************** Joueurs ***************************

/* Table R4 */
CREATE TABLE Joueurs(	idJou NUMBER (5,0),
						prenJou VARCHAR(20) NOT NULL,
						nomJou VARCHAR2(20) NOT NULL,
						posteJou VARCHAR2(20) NOT NULL,
						CONSTRAINT pk_Joueurs PRIMARY KEY (idJou),
						CONSTRAINT check_Joueurs1 CHECK (idJou BETWEEN 10000 AND 99999),
						CONSTRAINT check_Joueurs2 CHECK (MOD((idJou/1000),10) = 0),
						CONSTRAINT check_Joueurs3 CHECK (MOD((idJou/100),100) = 0));

prompt ******************** EquipesAdverses ***************************

/* Table R5 */
CREATE TABLE EquipesAdverses(	equipeAdv VARCHAR2(50),
								nomSpo VARCHAR2(30) NOT NULL,
								villeEqAdv VARCHAR2(30) NOT NULL,
								CONSTRAINT pk_EquipesAdverses PRIMARY KEY (equipeAdv),
								CONSTRAINT fk_EquipesAdverses_Equipes2 FOREIGN KEY (nomSpo) REFERENCES Equipes2(nomSpo));

prompt ******************** Salles1 ***************************

/* Table R6 */
CREATE TABLE Salles1(	nomSpo VARCHAR2(50),
						codePostal NUMBER(6,0),
						nomSalle VARCHAR2(30) NOT NULL,
						CONSTRAINT pk_Salles1 PRIMARY KEY (nomSpo,codePostal));
			
prompt ******************** Salles2 ***************************

/* Table R7 */				
CREATE TABLE Salles2(	nomSalle VARCHAR2(30) NOT NULL,
						lieuSalle VARCHAR2(30) NOT NULL,
						codePostal NUMBER(6,0) NOT NULL,
						--CONSTRAINT fk_Salles2_Salles1 FOREIGN KEY (codePostal) REFERENCES Salles1(codePostal),
						CONSTRAINT pk_Salles2 PRIMARY KEY (nomSalle, lieuSalle));



--ALTER TABLE Salles1 ADD CONSTRAINT fk_Salles1_Salles2 FOREIGN KEY (nomSalle) REFERENCES Salles2(nomSalle);

prompt ******************** Arbitres ***************************

/* Table R9 */
CREATE TABLE Arbitres(	idArb NUMBER (5,0),
						prenArb VARCHAR2(20) NOT NULL,
						nomArb VARCHAR2(20) NOT NULL,
						CONSTRAINT pk_Arbitres PRIMARY KEY(idArb),
						CONSTRAINT check_Arbitres1 CHECK (idArb BETWEEN 10000 AND 99999),
						CONSTRAINT check_Arbitres2 CHECK (MOD((idArb/1000),10) = 0),
						CONSTRAINT check_Arbitres3 CHECK (MOD((idArb/100),100) = 1));


prompt ******************** Rencontres ***************************

/* Table R8 */
CREATE TABLE Rencontres(dateEvt DATE,
						heure DATE,
						equipeAdv VARCHAR2(30),
						score NUMBER NOT NULL,
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
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************


INSERT INTO Equipes1 VALUES ('Hermine de Nantes', 'Basket-ball', 5);
INSERT INTO Equipes1 VALUES ('FC Nantes', 'Football', 11);
INSERT INTO Equipes1 VALUES ('Handball Club de Nantes', 'Handball', 7);
INSERT INTO Equipes1 VALUES ('Nantes Atlantique Rink Hockey', 'Rink Hockey', 5);

INSERT INTO Entraineurs VALUES (11001, 'Franck', 'Collineau');
INSERT INTO Entraineurs VALUES (21002, 'Sergio', 'Conceiçao');
INSERT INTO Entraineurs VALUES (31003, 'Thierry', 'Anti');
INSERT INTO Entraineurs VALUES (41004, 'Florent', 'Luce');

INSERT INTO Equipes2 VALUES ('Basket-ball', 'Hermine de Nantes', 'Nantes', 11001);
INSERT INTO Equipes2 VALUES ('Football', 'FC Nantes',  'Nantes', 21002);
INSERT INTO Equipes2 VALUES ('Handball', 'Handball Club de Nantes', 'Reze', 31003);
INSERT INTO Equipes2 VALUES ('Rink Hockey', 'Nantes Atlantique Rink Hockey', 'Nantes', 41004);

INSERT INTO Joueurs VALUES (10001, 'Guy-Marc', 'Michel', 'Meneur');
INSERT INTO Joueurs VALUES (10002, 'Kwamain', 'Mitchell', 'Arriere');
INSERT INTO Joueurs VALUES (10003, 'Henri', 'Kahudi', 'Ailier');
INSERT INTO Joueurs VALUES (10004, 'Corentin', 'Lecointe', 'Ailier fort');
INSERT INTO Joueurs VALUES (10005, 'Laurence', 'Ekperigin', 'Pivot');

INSERT INTO Joueurs VALUES (20001, 'Nassim', 'Badri', 'Gardien de but');
INSERT INTO Joueurs VALUES (20002, 'Maxime', 'Bossis', 'Attaquant axial');
INSERT INTO Joueurs VALUES (20003, 'Patrice', 'Rio', 'Ailier gauche');
INSERT INTO Joueurs VALUES (20004, 'Bruno', 'Baronchelli', 'Ailier droit');
INSERT INTO Joueurs VALUES (20005, 'Eric', 'Pecout', 'Attaquant soutient');
INSERT INTO Joueurs VALUES (20006, 'Jacky', 'Simon', 'Milieu offensif');
INSERT INTO Joueurs VALUES (20007, 'Henri', 'Michel', 'Milieu gauche');
INSERT INTO Joueurs VALUES (20008, 'Loic', 'Amisse', 'Milieu axial');
INSERT INTO Joueurs VALUES (20009, 'Gilles', 'Rampillon', 'Milieu droit');
INSERT INTO Joueurs VALUES (20010, 'Philipe', 'Gondet', 'Defenseur gauche');
INSERT INTO Joueurs VALUES (20011, 'Bernard', 'Blanchet', 'Defenseur droit');

INSERT INTO Joueurs VALUES (30001, 'Florian', 'Delacroix', 'Arrière droit');
INSERT INTO Joueurs VALUES (30002, 'Jerko', 'Matulic', 'Ailier droit');
INSERT INTO Joueurs VALUES (30003, 'Dominik', 'Klein', 'Ailier gauche');
INSERT INTO Joueurs VALUES (30004, 'Nicolas', 'Claire', 'Demi centre');
INSERT INTO Joueurs VALUES (30005, 'Mahmoud', 'Gharbi', 'Pivot');
INSERT INTO Joueurs VALUES (30006, 'Romain', 'Lagarde', 'Arrière gauche');
INSERT INTO Joueurs VALUES (30007, 'Cyril', 'Dumoulin', 'Gardien de but');

INSERT INTO Joueurs VALUES (40001, 'Alan', 'Audelin', 'Gardin de but');
INSERT INTO Joueurs VALUES (40002, 'Jeremy', 'Audelin', 'Attaquant');
INSERT INTO Joueurs VALUES (40003, 'Julien', 'Huvelin', 'Attaquant');
INSERT INTO Joueurs VALUES (40004, 'Benjamin', 'Lafargue', 'Defenseur');
INSERT INTO Joueurs VALUES (40005, 'Anthony', 'Le Roux', 'Defenseur');
/*

INSERT INTO EquipesAdverses VALUES ('Angers Basket Club', 'Basket-ball', 'Angers');
INSERT INTO EquipesAdverses VALUES ('Paris Saint Germain', 'Football', 'Paris');
INSERT INTO EquipesAdverses VALUES ('Montpellier Handball', 'Handball', 'Montpellier');
INSERT INTO EquipesAdverses VALUES ('US Coutras', 'Rink Hockey', 'Coutras');


INSERT INTO Salles1 VALUES ('Basket-ball', 44200, 'Complexe Sportif Mangin Beaulieu');
INSERT INTO Salles1 VALUES ('Football', 44300, 'La Beaujoire');
INSERT INTO Salles1 VALUES ('Handball', 44400, 'La Trocardiere');
INSERT INTO Salles1 VALUES ('Rink Hockey', 44300, 'Le Croissant');


INSERT INTO Salles2 VALUES ('Complexe Sportif Mangin Beaulieu', 'Nantes', 44200);
INSERT INTO Salles2 VALUES ('La Beaujoire', 'Nantes', 44300);
INSERT INTO Salles2 VALUES ('La Trocardiere', 'Reze', 44400);
INSERT INTO Salles2 VALUES ('Le Croissant', 'Nantes', 44300);


INSERT INTO Rencontres VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 'Angers Basket Club', 20-30, 'Match interessant', 1011);
INSERT INTO Rencontres VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 'Paris Saint Germain', 3-2, 'Score serre', 2012);
INSERT INTO Rencontres VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 'Montpellier Handball', 15-10, 'Joli match', 3013);
INSERT INTO Rencontres VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 'US Coutras', 5-0, 'Victoire ecrasante de Nantes !', 4014);


INSERT INTO Arbitres VALUES (10101, 'Regis', 'Bardera');
INSERT INTO Arbitres VALUES (20102, 'Benoit', 'Bastien');
INSERT INTO Arbitres VALUES (30103, 'Nordine', 'Lazaar');
INSERT INTO Arbitres VALUES (40104, 'Philipe', 'Aubre');


INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 10001, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 10002, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 10003, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 10004, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH:MI:SS'), 10005, 'Angers Basket Club', 44200);

INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20001, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20002, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20003, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20004, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20005, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20006, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20007, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20008, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20009, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20010, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH:MI:SS'), 20011, 'Paris Saint Germain', 44300);

INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30001, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30002, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30003, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30004, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30005, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30006, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH:MI:SS'), 30007, 'Montpellier Handball', 44400);

INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 40001, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 40002, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 40003, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 40004, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH:MI:SS'), 40005, 'US Coutras', 44300);


CREATE SEQUENCE seq START WITH 0 INCREMENT BY 1;

*/

/*
Idée de fonction, triggers, vues :
	Fonctions :	- Calculer le pourcentage des victoire d'une équipe
				- Calculer le nombre moyen de points marqué tous match confondu d'une équipe
				- Selon un poste et un sport donnée récupérer tous les joueurs correspondants 

	Triggers : 	- Empécher l'ajout d'un joueur dans une équipe déjà complète
				- Empécher qu'un entraineur entraine plusieurs équipes
				- 
N.B. : Pour l’ID je propose un nombre à 4 chiffres (voir 5) le premier correspondant au sport → Basket 1xxx ; Foot 2xxx etc.
Le second est à 1 si c’est un coach à 0 sinon, le troisième est à 1 si c’est un arbitre à 0 sinon
*/


CREATE OR REPLACE FUNCTION nb_moy_points_marque (nom_eq IS VARCHAR2)
RETURN NUMBER
IS
DECLARE
	val_retour NUMBER;
BEGIN
	
	
RETURN
END;
/