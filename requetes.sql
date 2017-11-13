--Fichier d'insertion des requêtes

SET PAGESIZE 300
SET LINESIZE 300

prompt *******************************************************************
prompt ****************************  REQUETES ****************************
prompt *******************************************************************
prompt
  
prompt ****************************  REQUETE N°1 ****************************
prompt 
prompt 

SELECT annee, date_deb, SUM(nb_grevistes) AS nb_grevistes, GROUPING_ID(annee, date_deb)
FROM 	(SELECT annee, date_deb, date_fin, nb_grevistes
		FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
		GROUP BY (annee, date_deb, date_fin, nb_grevistes))
WHERE nb_grevistes IS NOT NULL AND annee <= 209
GROUP BY ROLLUP (annee, date_deb); 


prompt ****************************  REQUETE N°2 ****************************
prompt Top 10 des plus grosses grèves toutes années confondu
prompt

Column Motifs format a40
Column date_deb format a11
Column date_fin format a11

SELECT *
FROM 
	(SELECT date_deb, date_fin, nb_grevistes, RANK() over(order by nb_grevistes desc) AS Top_10
	FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
	WHERE nb_grevistes IS NOT NULL
	GROUP BY (date_deb, date_fin, nb_grevistes))
WHERE ROWNUM <=10;

/* ROWNUM va être exécuter avant le order by ce qui ici posait soucis, avec ORACLE 12 il existe la commande FETCH qui permet de résoudre le problème*/


prompt ****************************  REQUETE N°3 ****************************
prompt Nombre de grevistes total par an (uniquement les agregats)
prompt

SELECT annee, SUM(nb_grevistes) AS nb_grevistes
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
GROUP BY GROUPING SETS (annee)
ORDER BY annee ASC;


prompt ****************************  REQUETE N°4 ****************************
prompt  % de grève de chaque type chaque année depuis 2002
prompt

/* % de grève de chaque type chaque année depuis 2002
 pour chaque année, chaque categorie faire : nombre de grèves dans cette categorie cette annee/nombre de grèves toute l'année x 100
 modifier le select du nombre de greve par an pour décupler/cloner les */

Column nom_orga format a20
Column categorie_greve format a23

SELECT annee, categorie_greve, ROUND(100*RATIO_TO_REPORT(Total) over (PARTITION BY annee),2) ratio_type_greve
FROM 	(SELECT annee, 'Salaire' AS categorie_greve, COUNT(*) AS Total
		FROM Table_Faits NATURAL JOIN Motifs
		WHERE categorie_greve LIKE('%Salaire%')
		GROUP BY annee
		UNION
		SELECT annee, 'Retraite' AS categorie_greve, COUNT(*) AS Total
		FROM Table_Faits NATURAL JOIN Motifs
		WHERE categorie_greve LIKE('%Retraite%')
		GROUP BY annee
		UNION
		SELECT annee, 'Condition de travail' AS categorie_greve, COUNT(*) AS Total
		FROM Table_Faits NATURAL JOIN Motifs
		WHERE categorie_greve LIKE('%Conditions de travail%')
		GROUP BY annee
		UNION
		SELECT annee, 'Not defined' AS categorie_greve, COUNT(*) AS Total
		FROM Table_Faits NATURAL JOIN Motifs
		WHERE categorie_greve IS NULL
		GROUP BY annee)
GROUP BY (annee, categorie_greve, Total)
ORDER BY annee;


prompt ****************************  REQUETE N°5 ****************************
prompt Affiche le nombre de grèviste par an et par association (uniquement pour CGT, SUD et CFDT) entre 2002 et 2005 en utilisant grouping sets
prompt

/* ne marche pas à cause du multivalues pour les organisation... On a un ID par tuple en faite...*/


SELECT annee, Syndics, SUM(DISTINCT nb_grevistes) AS nb_grevistes
FROM (SELECT annee, 'CGT' AS Syndics, nom_orga, nb_grevistes
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles NATURAL JOIN Nb_Travailleurs
	WHERE nom_orga LIKE('%CGT%')
	GROUP BY annee, nom_orga, nb_grevistes
	UNION
	SELECT annee, 'SUD' AS Syndics, nom_orga, nb_grevistes
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles NATURAL JOIN Nb_Travailleurs
	WHERE nom_orga LIKE('%SUD%')
	GROUP BY annee, nom_orga, nb_grevistes
	UNION
	SELECT annee, 'CFDT' AS Syndics, nom_orga, nb_grevistes
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles NATURAL JOIN Nb_Travailleurs
	WHERE nom_orga LIKE('%CFDT%')
	GROUP BY annee, nom_orga, nb_grevistes)
WHERE annee >= 2002 and annee <= 2005 and nom_orga LIKE '%CGT%'
GROUP BY GROUPING SETS((annee, Syndics), (annee), ())
ORDER BY annee, Syndics;

 
prompt ****************************  REQUETE N°6 ****************************
prompt Affiche le nombre de grèves par saison utilisant group by rollup
prompt

SELECT saison, AVG(taux_grevistes) AS Pourcentage, Count(*) AS nb_greves
FROM Table_Faits NATURAL JOIN Temps
GROUP BY ROLLUP (saison);


prompt ****************************  REQUETE N°7 ****************************
prompt Group By Cube avec les années, les syndicats : CGT et SUD; et les métiers : tractionnaires et agent de manoeuvre pour les année supérieurs ou égales à 2010
prompt

Column nom_orga format a20
Column Syndics format a6

SELECT annee, Syndics, Metier, COUNT(*) AS Total
FROM
	(SELECT annee, 'CGT' AS Syndics, 'tractionnaire' AS Metier
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%CGT%') AND nom_metier LIKE('%tractionnaire%')
	UNION
	SELECT annee, 'SUD' AS Syndics, 'tractionnaire' AS Metier
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%SUD%') AND nom_metier LIKE('%tractionnaire%')
	UNION
	SELECT annee, 'CGT' AS Syndics, 'agent de manoeuvre' AS Metier
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%CGT%') AND nom_metier LIKE('%agent de manoeuvre%')
	UNION
	SELECT annee, 'SUD' AS Syndics, 'agent de manoeuvre' AS Metier
	FROM Table_Faits NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%SUD%') AND nom_metier LIKE('%agent de manoeuvre%'))
WHERE annee >= 2010
GROUP BY CUBE (annee, Syndics, Metier)
ORDER BY annee;


prompt ****************************  REQUETE N°8 ****************************
prompt Top 5 des grèves les plus longues pour lesquelles la CGT était présente
prompt

SELECT *
FROM (SELECT  duree_en_jour, annee, nb_grevistes
	FROM Table_Faits NATURAL JOIN Nb_Travailleurs NATURAL JOIN Organisations
	WHERE nb_grevistes IS NOT NULL AND nom_orga LIKE('%CGT%')
	ORDER By duree_en_jour DESC)
WHERE ROWNUM <=5;


prompt ****************************  REQUETE N°9 ****************************
prompt Group By Cube sur l''année, la catégorie de grève ainsi que la saison
prompt

SELECT annee, categorie_greve, saison, COUNT(*) AS Total 
FROM (SELECT annee, 'Salaire' AS categorie_greve, saison
		FROM Table_Faits NATURAL JOIN Motifs NATURAL JOIN Temps
		WHERE categorie_greve LIKE('%Salaire%')
		UNION
		SELECT annee, 'Retraite' AS categorie_greve, saison
		FROM Table_Faits NATURAL JOIN Motifs NATURAL JOIN Temps
		WHERE categorie_greve LIKE('%Retraite%')
		UNION
		SELECT annee, 'Condition de travail' AS categorie_greve, saison
		FROM Table_Faits NATURAL JOIN Motifs NATURAL JOIN Temps
		WHERE categorie_greve LIKE('%Conditions de travail%'))
WHERE annee >= 2008
GROUP BY CUBE (annee, categorie_greve, saison)
ORDER BY annee;


prompt ****************************  REQUETE N°10 ****************************
prompt Requête avec une window
prompt

SELECT annee, nb_grevistes, SUM(nb_grevistes) over (order by annee rows unbounded preceding) AS Cumul
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
GROUP BY annee, nb_grevistes;