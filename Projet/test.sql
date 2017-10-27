--Fichier contenant tous les jeux de test

prompt ************************************************************
prompt ******************** JEUX DE TEST **************************
prompt ************************************************************

INSERT INTO EquipesAdverses VALUES ('PSG Handball', 'Handball', 'Paris');
INSERT INTO EquipesAdverses VALUES ('SR VHB', 'Handball', 'Saint-Raphael');

INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30001, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30002, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30003, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30004, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30005, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30006, 'PSG Handball', 44400);
INSERT INTO Cles VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 30007, 'PSG Handball', 44400);

INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30001, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30002, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30003, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30004, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30005, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30006, 'SR VHB', 44400);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 30007, 'SR VHB', 44400);

INSERT INTO Rencontres VALUES (to_date('10-11-2014','dd-mm-yyyy'), to_date('14:30:00','HH24:MI:SS'), 'PSG Handball', 10, 20, 'Score serre', 20102);
INSERT INTO Rencontres VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('1:30:00','HH24:MI:SS'), 'SR VHB', 5, 11, 'Score serre', 20102);
	
EXEC nb_moy_points_marque('Handball Club de Nantes');
EXEC nb_moy_points_marque('Belette de Paris');

EXEC pourcent_victoire('FC Nantes'); 
EXEC pourcent_victoire('Handball Club de Nantes');

EXEC joueurs_sport('Handball');

EXEC joueurs_equipe('Football');


INSERT INTO Entraineurs VALUES (51005, 'Jackie', 'Chan');
INSERT INTO Equipes VALUES ('Petanque Nantaise', 'Petanque', 3, 'Nantes', 51005, 'H');
INSERT INTO Joueurs VALUES (50005, 'Bruce', 'Lee', 'Meneur', 'H');
INSERT INTO EquipesAdverses VALUES ('Real Toulon', 'Petanque', 'Toulon');
INSERT INTO Salles VALUES ('Petanque', 44800, 'Nantes', 'Devant chez Gerard');
INSERT INTO Cles VALUES(to_date('01-05-2016','dd-mm-yyyy'), to_date('14:00:00','HH24:MI:SS'), 50005, 'Real Toulon', 44800);
INSERT INTO Rencontres VALUES (to_date('01-05-2016','dd-mm-yyyy'), to_date('14:00:00','HH24:MI:SS'), 'Real Toulon', 10, 2, 'Match interessant', 10101);


INSERT INTO Equipes VALUES ('Tir a l''arc Nantais', 'Tir a l''arc', 1, 'Nantes', 51005, 'H');


SELECT * FROM joueurs_de_basket;
SELECT * FROM score_de_football;