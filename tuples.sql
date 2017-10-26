-- Fichier d'insertion des tuples

prompt *************************************************************
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************

DROP SEQUENCE seq_Fait;
DROP SEQUENCE seq_Temps;
DROP SEQUENCE seq_Orga;
DROP SEQUENCE seq_Motifs;
DROP SEQUENCE seq_MetiersCibles;
DROP SEQUENCE seq_NbTravailleurs;
CREATE SEQUENCE seq_Fait START WITH 1 INCREMENT BY 1 MINVALUE 0;
CREATE SEQUENCE seq_Temps START WITH 1 INCREMENT BY 1 MINVALUE 0;
CREATE SEQUENCE seq_Orga START WITH 1 INCREMENT BY 1 MINVALUE 0;
CREATE SEQUENCE seq_Motifs START WITH 1 INCREMENT BY 1 MINVALUE 0;
CREATE SEQUENCE seq_MetiersCibles START WITH 1 INCREMENT BY 1 MINVALUE 0;
CREATE SEQUENCE seq_NbTravailleurs START WITH 1 INCREMENT BY 1 MINVALUE 0;


INSERT INTO Temps VALUES (seq_Temps.nextval, to_date('2015-10-08','dd-mm-yyyy'), to_date('2015-10-08','dd-mm-yyyy'));
INSERT INTO Temps VALUES (seq_Temps.nextval, to_date('2015-07-05','dd-mm-yyyy'), to_date('2015-07-10','dd-mm-yyyy'));
INSERT INTO Temps VALUES (seq_Temps.nextval, to_date('2008-06-18','dd-mm-yyyy'), to_date('2008-06-20','dd-mm-yyyy'));


INSERT INTO Orga VALUES (seq_Orga.nextval, "CGT");
INSERT INTO Orga VALUES (seq_Orga.nextval, "SUD");

INSERT INTO Orga VALUES (seq_Orga.nextval, "CFDT");


INSERT INTO Metiers_Cibles VALUES (seq_MetiersCibles.nextval, "GPF");
INSERT INTO Metiers_Cibles VALUES (seq_MetiersCibles.nextval, "tractionnaires");


INSERT INTO Motifs VALUES (seq_Motifs.nextval, "Les salaires");
INSERT INTO Motifs VALUES (seq_Motifs.nextval, "L'emploi");
INSERT INTO Motifs VALUES (seq_Motifs.nextval, "Les conditions de travail");
INSERT INTO Motifs VALUES (seq_Motifs.nextval, "La sécurité ferroviaire");

INSERT INTO Motifs VALUES (seq_Motifs.nextval, "Changement de service été 2015");


INSERT INTO Nb_Travailleurs VALUES (seq_NbTravailleurs.nextval, 92602.0, 16988.0, 12.3);
INSERT INTO Nb_Travailleurs VALUES (seq_NbTravailleurs.nextval, 3499.0, 375.0, 1.4);
INSERT INTO Nb_Travailleurs VALUES (seq_NbTravailleurs.nextval, 20401.0, 1994.0, NULL);


INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 1, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 2, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 3, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 1, 4, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 2, 1, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 2, 2, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 2, 3, 1);
INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 1, 1, 2, 4, 1);

INSERT INTO Table_Faits VALUES (seq_Fait.nextval, 2, 2, 2, 5, 2);