-- Fichier d'insertion des tuples

prompt *************************************************************
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************

DROP SEQUENCE seq_Fait;
CREATE SEQUENCE seq_Fait START WITH 0 INCREMENT BY 1 MINVALUE 0;


--Tuple 1
INSERT INTO Temps VALUES (1, to_date('08-10-2015','dd-mm-yyyy'), to_date('08-10-2015','dd-mm-yyyy'));
INSERT INTO Orga VALUES (1, 'CGT');
INSERT INTO Orga VALUES (2, 'SUD');
INSERT INTO Metiers_Cibles VALUES (1, 'GPF');
INSERT INTO Motifs VALUES (1, 'Les salaires');
INSERT INTO Motifs VALUES (2, 'L''emploi');
INSERT INTO Motifs VALUES (3, 'Les conditions de travail');
INSERT INTO Motifs VALUES (4, 'La sécurité ferroviaire');
INSERT INTO Nb_Travailleurs VALUES (1, 92602.0, 16988.0, 12.3);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 1, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 2, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 3, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 4, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 2, 1, 1, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 2, 1, 2, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 2, 1, 3, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 2, 1, 4, 1);


--Tuple 2
INSERT INTO Temps VALUES (2, to_date('05-07-2015','dd-mm-yyyy'), to_date('10-07-2015','dd-mm-yyyy'));
INSERT INTO Orga VALUES (3, 'CFDT');
INSERT INTO Metiers_Cibles VALUES (2, 'Tractionnaires');
INSERT INTO Motifs VALUES (5, 'Changement de service été 2015');
INSERT INTO Nb_Travailleurs VALUES (2, 3499.0, 375.0, 1.4);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 2, 3, 2, 5, 2);


--Tuple 3
INSERT INTO Temps VALUES (3, to_date('21-05-2014','dd-mm-yyyy'), to_date('23-05-2014','dd-mm-yyyy'));
--Orga CGT ID=1
INSERT INTO Metiers_Cibles VALUES (3, 'Agent de manoeuvre');
INSERT INTO Metiers_Cibles VALUES (4, 'Régulation et circulation ferroviaire');
INSERT INTO Motifs VALUES (6, 'La réforme ferroviaire');
INSERT INTO Nb_Travailleurs VALUES (3, 4025.0, 123.0, NULL);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 3, 1, 3, 6, 3);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 3, 1, 4, 6, 3);


--Tuple 4
INSERT INTO Temps VALUES (4, to_date('10-06-2003','dd-mm-yyyy'), NULL);
INSERT INTO Orga VALUES (4, 'FO');
--Metiers Agent de manoeuvre ID=3
INSERT INTO Motifs VALUES (7, 'Retraites');
INSERT INTO Nb_Travailleurs VALUES (4, 11090.0, 358.0, NULL);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 4, 4, 3, 7, 4);


--Tuple 5
INSERT INTO Temps VALUES (5, to_date('22-11-2006','dd-mm-yyyy'), to_date('23-11-2006','dd-mm-yyyy'));
--Orga FO ID=4
--Metiers Agent de manoeuvre ID=3
INSERT INTO Metiers_Cibles VALUES (5, 'Accueil en gare et vente');
INSERT INTO Motifs VALUES (8, 'Arrêt immédiat des procédures disciplinaires');
INSERT INTO Motifs VALUES (9, 'Réintégration immédiate des agents révoqués');
INSERT INTO Motifs VALUES (10, 'mise en place d''un système de distribution fiable');
INSERT INTO Nb_Travailleurs VALUES (5, 5609.0, 69.0, NULL);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 3, 8, 5);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 3, 9, 5);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 3, 10, 5);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 5, 8, 5);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 5, 9, 5);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 5, 4, 5, 10, 5);


--Tuple 6
INSERT INTO Temps VALUES (6, to_date('25-06-2015','dd-mm-yyyy'), to_date('25-06-2015','dd-mm-yyyy'));
--Orga CGT ID=1
--Metiers Tractionnaires ID=2
INSERT INTO Metiers_Cibles VALUES (6, 'Conducteurs');
INSERT INTO Motifs VALUES (11, 'Salaires');
INSERT INTO Nb_Travailleurs VALUES (6, 95613.0, 10727.0, 11.2);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 6, 1, 2, 11, 6);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 6, 1, 6, 11, 6);


--Tuple 7
INSERT INTO Temps VALUES (7, to_date('29-01-2015','dd-mm-yyyy'), to_date('29-01-2015','dd-mm-yyyy'));
--Orga CGT ID=1
--Orga SUD ID=2
INSERT INTO Metiers_Cibles VALUES (7, 'Tous métiers');
INSERT INTO Motifs VALUES (12, 'Ouverture de négociations sur la réforme de la SNCF');
INSERT INTO Nb_Travailleurs VALUES (7, 98338.0, 6158.0, 6.3);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 7, 1, 7, 12, 7);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 7, 2, 7, 12, 7);


GRANT SELECT ON Motifs TO admi45 WITH GRANT OPTION;
GRANT SELECT ON Motifs TO admi13 WITH GRANT OPTION;