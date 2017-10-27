-- Fichier d'insertion des tuples

prompt *************************************************************
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************



INSERT INTO Entraineurs VALUES (11001, 'Franck', 'Collineau');
INSERT INTO Entraineurs VALUES (21002, 'Sergio', 'Conceiçao');
INSERT INTO Entraineurs VALUES (31003, 'Thierry', 'Anti');
INSERT INTO Entraineurs VALUES (41004, 'Florent', 'Luce');

INSERT INTO Equipes VALUES ('Hermine de Nantes', 'Basket-ball', 5, 'Nantes', 11001, 'H');
INSERT INTO Equipes VALUES ('FC Nantes', 'Football', 11,  'Nantes', 21002, 'H');
INSERT INTO Equipes VALUES ('Handball Club de Nantes', 'Handball', 7, 'Reze', 31003, 'H');
INSERT INTO Equipes VALUES ('Nantes Atlantique Rink Hockey', 'Rink Hockey', 5, 'Nantes', 41004, 'H');

INSERT INTO Joueurs VALUES (10001, 'Guy-Marc', 'Michel', 'Meneur', 'H');
INSERT INTO Joueurs VALUES (10002, 'Kwamain', 'Mitchell', 'Arriere', 'H');
INSERT INTO Joueurs VALUES (10003, 'Henri', 'Kahudi', 'Ailier', 'H');
INSERT INTO Joueurs VALUES (10004, 'Corentin', 'Lecointe', 'Ailier fort', 'H');
INSERT INTO Joueurs VALUES (10005, 'Laurence', 'Ekperigin', 'Pivot', 'H');

INSERT INTO Joueurs VALUES (20001, 'Nassim', 'Badri', 'Gardien de but', 'H');
INSERT INTO Joueurs VALUES (20002, 'Maxime', 'Bossis', 'Attaquant axial', 'H');
INSERT INTO Joueurs VALUES (20003, 'Patrice', 'Rio', 'Ailier gauche', 'H');
INSERT INTO Joueurs VALUES (20004, 'Bruno', 'Baronchelli', 'Ailier droit', 'H');
INSERT INTO Joueurs VALUES (20005, 'Eric', 'Pecout', 'Attaquant soutient', 'H');
INSERT INTO Joueurs VALUES (20006, 'Jacky', 'Simon', 'Milieu offensif', 'H');
INSERT INTO Joueurs VALUES (20007, 'Henri', 'Michel', 'Milieu gauche', 'H');
INSERT INTO Joueurs VALUES (20008, 'Loic', 'Amisse', 'Milieu axial', 'H');
INSERT INTO Joueurs VALUES (20009, 'Gilles', 'Rampillon', 'Milieu droit', 'H');
INSERT INTO Joueurs VALUES (20010, 'Philipe', 'Gondet', 'Defenseur gauche', 'H');
INSERT INTO Joueurs VALUES (20011, 'Bernard', 'Blanchet', 'Defenseur droit', 'H');

INSERT INTO Joueurs VALUES (30001, 'Florian', 'Delacroix', 'Arrière droit', 'H');
INSERT INTO Joueurs VALUES (30002, 'Jerko', 'Matulic', 'Ailier droit', 'H');
INSERT INTO Joueurs VALUES (30003, 'Dominik', 'Klein', 'Ailier gauche', 'H');
INSERT INTO Joueurs VALUES (30004, 'Nicolas', 'Claire', 'Demi centre', 'H');
INSERT INTO Joueurs VALUES (30005, 'Mahmoud', 'Gharbi', 'Pivot', 'H');
INSERT INTO Joueurs VALUES (30006, 'Romain', 'Lagarde', 'Arrière gauche', 'H');
INSERT INTO Joueurs VALUES (30007, 'Cyril', 'Dumoulin', 'Gardien de but', 'H');

DROP SEQUENCE seq;
CREATE SEQUENCE seq START WITH 40001 INCREMENT BY 1 MINVALUE 0;

INSERT INTO Joueurs VALUES (seq.nextval, 'Alan', 'Audelin', 'Gardin de but', 'H');
INSERT INTO Joueurs VALUES (seq.nextval, 'Jeremy', 'Audelin', 'Attaquant', 'H');
INSERT INTO Joueurs VALUES (seq.nextval, 'Julien', 'Huvelin', 'Attaquant', 'H');
INSERT INTO Joueurs VALUES (seq.nextval, 'Benjamin', 'Lafargue', 'Defenseur', 'H');
INSERT INTO Joueurs VALUES (seq.nextval, 'Anthony', 'Le Roux', 'Defenseur', 'H');


INSERT INTO EquipesAdverses VALUES ('Angers Basket Club', 'Basket-ball', 'Angers');
INSERT INTO EquipesAdverses VALUES ('Paris Saint Germain', 'Football', 'Paris');
INSERT INTO EquipesAdverses VALUES ('Montpellier Handball', 'Handball', 'Montpellier');
INSERT INTO EquipesAdverses VALUES ('US Coutras', 'Rink Hockey', 'Coutras');


INSERT INTO Salles VALUES ('Basket-ball', 44200, 'Nantes', 'Complexe Sportif Mangin Beaulieu');
INSERT INTO Salles VALUES ('Football', 44300, 'Nantes', 'La Beaujoire');
INSERT INTO Salles VALUES ('Handball', 44400, 'Reze', 'La Trocardiere');
INSERT INTO Salles VALUES ('Rink Hockey', 44300, 'Nantes', 'Le Croissant');


INSERT INTO Arbitres VALUES (10101, 'Regis', 'Bardera');
INSERT INTO Arbitres VALUES (20102, 'Benoit', 'Bastien');
INSERT INTO Arbitres VALUES (30103, 'Nordine', 'Lazaar');
INSERT INTO Arbitres VALUES (40104, 'Philipe', 'Aubre');


INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 10001, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 10002, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 10003, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 10004, 'Angers Basket Club', 44200);
INSERT INTO Cles VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 10005, 'Angers Basket Club', 44200);

INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20001, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20002, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20003, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20004, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20005, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20006, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20007, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20008, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20009, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20010, 'Paris Saint Germain', 44300);
INSERT INTO Cles VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 20011, 'Paris Saint Germain', 44300);

INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30001, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30002, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30003, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30004, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30005, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30006, 'Montpellier Handball', 44400);
INSERT INTO Cles VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 30007, 'Montpellier Handball', 44400);

INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 40001, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 40002, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 40003, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 40004, 'US Coutras', 44300);
INSERT INTO Cles VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 40005, 'US Coutras', 44300);


INSERT INTO Rencontres VALUES (to_date('01-02-2016','dd-mm-yyyy'), to_date('19:00:00','HH24:MI:SS'), 'Angers Basket Club', 20, 30, 'Match interessant', 10101);
INSERT INTO Rencontres VALUES (to_date('05-10-2016','dd-mm-yyyy'), to_date('19:30:00','HH24:MI:SS'), 'Paris Saint Germain', 3, 2, 'Score serre', 20102);
INSERT INTO Rencontres VALUES (to_date('20-05-2017','dd-mm-yyyy'), to_date('20:00:00','HH24:MI:SS'), 'Montpellier Handball', 15, 10, 'Joli match', 30103);
INSERT INTO Rencontres VALUES (to_date('31-12-2014','dd-mm-yyyy'), to_date('23:00:00','HH24:MI:SS'), 'US Coutras', 5, 0, 'Victoire ecrasante de Nantes !', 40104);
