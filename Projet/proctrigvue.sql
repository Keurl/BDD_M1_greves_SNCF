--Fichier d'insertion des procédues, triggers, vues


prompt *******************************************************************
prompt ******************** PROCEDURES/FONCTION **************************
prompt *******************************************************************


CREATE OR REPLACE PROCEDURE nb_moy_points_marque (nom_eq IN VARCHAR2) 
IS
	nom_incorrecte EXCEPTION;
	val_retour NUMBER;
BEGIN
	SELECT AVG(scoreEq) INTO val_retour
	FROM Rencontres NATURAL JOIN EquipesAdverses NATURAL JOIN Equipes 
	WHERE nom_eq = nomEq;
	IF (val_retour IS NULL) THEN
		RAISE nom_incorrecte;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Nombre moyen de points marque par l''equipe ' || nom_eq || ' : ' || val_retour);
	END IF;
	EXCEPTION
		WHEN nom_incorrecte THEN
			raise_application_error(-20001, 'Le nom de l''equipe rentre en parametre n''existe pas');
END nb_moy_points_marque;
/


CREATE OR REPLACE PROCEDURE pourcent_victoire(nom_eq IN VARCHAR2) IS
	pourcent FLOAT;
	nb_matchs INTEGER;
	nb_victoires INTEGER;
BEGIN
	SELECT count(dateEvt) INTO nb_matchs
	FROM Rencontres NATURAL JOIN EquipesAdverses NATURAL JOIN Equipes
	WHERE nomEq = nom_eq;
	SELECT COUNT(dateEvt) INTO nb_victoires
	FROM Rencontres NATURAL JOIN EquipesAdverses NATURAL JOIN Equipes
	WHERE nomEq = nom_eq AND scoreEq > scoreAdv;
	IF nb_victoires > 0 THEN 
		pourcent := nb_victoires/nb_matchs *100;
		dbms_output.put_line('L''equipe ' || nom_eq || ' a remporte : ' || pourcent || '% de ses matchs');
	ELSE
		dbms_output.put_line('L''equipe n''a remporte aucun match');
	END IF;
END;
/


CREATE OR REPLACE PROCEDURE joueurs_sport (nom_sport IN VARCHAR2) IS

CURSOR all_joueurs IS 	SELECT Joueurs.idJou, prenJou, nomJou, posteJou, Joueurs.sexe
						FROM EquipesAdverses INNER JOIN Cles ON EquipesAdverses.equipeAdv = Cles.equipeAdv INNER JOIN Joueurs ON Cles.idJou = Joueurs.idJou
						WHERE nomSpo = nom_sport;
	id Joueurs.idJou%TYPE;
	pren Joueurs.prenJou%TYPE;
	nom Joueurs.nomJou%TYPE;
	poste Joueurs.posteJou%TYPE;
	sex Joueurs.sexe%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Les joueurs qui pratiquent du ' || nom_sport || ' sont :' );
	OPEN all_joueurs;
	LOOP
		FETCH all_joueurs INTO id, pren, nom, poste, sex;
		EXIT WHEN all_joueurs%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('ID : '||id||' | prenom : '||pren|| ' | nom : '||nom|| ' | poste : '||poste|| ' | sexe : '||sex);
	END LOOP;
	CLOSE all_joueurs;
END joueurs_sport;
/


CREATE OR REPLACE PROCEDURE joueurs_equipe (nom_equipe IN VARCHAR2) IS

CURSOR all_joueurs IS 	SELECT Joueurs.idJou, prenJou, nomJou, posteJou, Joueurs.sexe
						FROM Equipes NATURAL JOIN EquipesAdverses INNER JOIN Cles ON EquipesAdverses.equipeAdv = Cles.equipeAdv INNER JOIN Joueurs ON Cles.idJou = Joueurs.idJou
						WHERE nomEq = nom_equipe;
	id Joueurs.idJou%TYPE;
	pren Joueurs.prenJou%TYPE;
	nom Joueurs.nomJou%TYPE;
	poste Joueurs.posteJou%TYPE;
	sex Joueurs.sexe%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Les joueurs qui pratiquent font de l equipe ' || nom_equipe || ' sont :' );
	OPEN all_joueurs;
	LOOP
		FETCH all_joueurs INTO id, pren, nom, poste, sex;
		EXIT WHEN all_joueurs%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE('ID : '||id||' | prenom : '||pren|| ' | nom : '||nom|| ' | poste : '||poste|| ' | sexe : '||sex);
	END LOOP;
	CLOSE all_joueurs;
END joueurs_equipe;
/


prompt *******************************************************
prompt ******************** TRIGGER **************************
prompt *******************************************************


CREATE OR REPLACE TRIGGER equipe_complete
BEFORE INSERT ON Rencontres 
FOR EACH ROW
DECLARE
	equipe_non_complete EXCEPTION;
	nb_joueur_eq INTEGER;
	nb_joueur_spo INTEGER;
	CURSOR cur IS SELECT Equipes.nbJou
					FROM EquipesAdverses INNER JOIN Equipes ON EquipesAdverses.nomSpo = Equipes.nomSpo 
					WHERE EquipesAdverses.equipeAdv = :NEW.equipeAdv;
BEGIN
	SELECT COUNT(Joueurs.idJou) INTO nb_joueur_eq
	FROM Equipes INNER JOIN EquipesAdverses ON EquipesAdverses.nomSpo = Equipes.nomSpo INNER JOIN Cles ON Cles.equipeAdv = EquipesAdverses.equipeAdv INNER JOIN Joueurs ON Cles.idJou = Joueurs.idJou
	WHERE EquipesAdverses.equipeAdv = :NEW.equipeAdv;
	OPEN cur;	
	LOOP	
		FETCH cur INTO nb_joueur_spo;
		EXIT WHEN cur%NOTFOUND;
	END LOOP;
		IF (nb_joueur_spo != nb_joueur_eq) THEN 
		RAISE equipe_non_complete;
	END IF;
EXCEPTION
	WHEN equipe_non_complete THEN
		raise_application_error(-20011, 'L''equipe ne contient pas suffisament de joueur pour pouvoir jouer');
END equipe_complete;
/ 


CREATE OR REPLACE TRIGGER entraineur_exclusif 
	BEFORE INSERT ON Equipes
	FOR EACH ROW
DECLARE
	nb_equipe NUMBER;
	deja_Entraineur EXCEPTION;
BEGIN
	SELECT COUNT(idEntr) into nb_equipe
	FROM Equipes
	WHERE idEntr = :new.idEntr;
	IF nb_equipe > 0 THEN
		RAISE deja_Entraineur;
	END IF;
EXCEPTION
	WHEN deja_entraineur THEN
		raise_application_error( -20012, 'L''entraineur renseigne est deja en charge d une equipe' );
END;
/

prompt ***************************************************
prompt ******************** VUE **************************
prompt ***************************************************

CREATE OR REPLACE VIEW joueurs_de_basket AS
	SELECT nomJou, prenJou
	FROM Cles NATURAL JOIN Equipes NATURAL JOIN EquipesAdverses NATURAL JOIN JOUEURS
	WHERE nomSpo = 'Basket-ball';

CREATE OR REPLACE VIEW score_de_football AS
	SELECT scoreEq, scoreAdv, equipeAdv
	FROM Rencontres;