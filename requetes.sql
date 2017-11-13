--Fichier d'insertion des requêtes

SET PAGESIZE 300
SET LINESIZE 300

prompt *******************************************************************
prompt ****************************  REQUETES ****************************
prompt *******************************************************************

/* idées de requêtes OLAP : 

avec group by cube : de 2002 a 2005, le nombre de grèvistes par grève par année

*top 10 des plus grosses grèves toutes années confondu
*afficher le nombre de grèviste par an et pas association entre 2002 et 2005 en utilisant grouping sets
* requête avec peu d'intérêt : en utilisant WINDOW, le cumul total des grèvistes depuis 2002



idées d'Ivan :

toutes grèves qui ont eu lieu en 2014 avec le nom des syndicats

pourçentage moyen de grèvistes sur l'ensemble du dataset

liste des métiers cible en 2013 sans doublon

nombre total de grèvistes depuis 2011

durée moyenne des grèves en 2010

  */
prompt ****************************  REQUETE N°1
prompt 

SELECT annee, date_deb, SUM(nb_grevistes) AS nb_grevistes
FROM 	(SELECT annee, date_deb, date_fin, nb_grevistes
		FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
		GROUP BY (annee, date_deb, date_fin, nb_grevistes))
WHERE nb_grevistes IS NOT NULL
GROUP BY ROLLUP (annee, date_deb); 


prompt ****************************  REQUETE N°2
prompt Top 10 des plus grosses grèves toutes années confondu
prompt

Column Motifs format a40
Column date_deb format a11
Column date_fin format a11

SELECT *
FROM 
	(SELECT date_deb, date_fin, nb_grevistes, rank() over(order by nb_grevistes desc) AS top_10
	 FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
	WHERE nb_grevistes IS NOT NULL)
WHERE ROWNUM <=10;

/* ROWNUM va être exécuter avant le order by ce qui ici posait soucis, avec ORACLE 12 il existe la commande FETCH qui permet de résoudre le problème*/


prompt ****************************  REQUETE N°3
prompt Nombre de grevistes total par an (uniquement les agregats)
prompt

SELECT annee, SUM(nb_grevistes)
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
GROUP BY GROUPING SETS (annee)
ORDER BY annee ASC;


prompt ****************************  REQUETE N°4
prompt  % de grève de chaque type chaque année depuis 2002
prompt

/* % de grève de chaque type chaque année depuis 2002
 pour chaque année, chaque categorie faire : nombre de grèves dans cette categorie cette annee/nombre de grèves toute l'année x 100
 modifier le select du nombre de greve par an pour décupler/cloner les
 s'aider de ça : https://www.developpez.net/forums/d349204/bases-donnees/oracle/sql/10g-express-edition-calculer-pourcentage-simple-select/
 */

/* SELECT annee, categorie_greve,  ((SELECT COUNT(*) 
				  FROM Table_Faits NATURAL JOIN Motifs 
				  GROUP BY (annee,categorie_greve)) /
				((SELECT COUNT(*)/3 
				  FROM Table_Faits JOIN Tally ON Tally.Table_Faits <= 3 
				  GROUP BY annee)*100)) AS ratio_type_greve
FROM Table_Faits NATURAL JOIN Motifs NATURAL JOIN Temps 
GROUP BY GROUPING SETS (annee,categorie_greve);

annee = entreprise
categorie = satisfaction */




SELECT annee, categorie_greve, ROUND(100*RATIO_TO_REPORT(COUNT(*)) over (PARTITION BY annee),2) ratio_type_greve
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Motifs
GROUP BY GROUPING SETS (annee, categorie_greve);


prompt ****************************  REQUETE N°5
prompt Affiche le nombre de grèviste par an et par association entre 2002 et 2005 en utilisant grouping sets
prompt

/* ne marche pas à cause du multivalues pour les organisation... On a un ID par tuple en faite...*/

SELECT ID_Organisations, annee, SUM(DISTINCT nb_grevistes)
FROM Table_Faits NATURAL JOIN Nb_Travailleurs NATURAL JOIN Temps NATURAL JOIN Organisations
WHERE annee >= 2002 and annee <= 2005
GROUP BY GROUPING SETS((annee, ID_Organisations), (annee), ())
ORDER BY annee, ID_Organisations;


prompt ****************************  REQUETE N°6
prompt Affiche le nombre de grèves par saison utilisant group by rollup
prompt

SELECT saison, Count(*)
FROM Table_Faits NATURAL JOIN Temps
GROUP BY ROLLUP (saison);


prompt ****************************  REQUETE N°7
prompt Group By Cube avec les années, les syndicats : CGT et SUD; et les métiers : tractionnaires et agent de manoeuvre pour les année supérieurs ou égales à 2010
prompt

Column nom_orga format a20
Column Syndics format a6

SELECT annee, Syndics, Metier, COUNT(*) AS total
FROM
	(SELECT annee, 'CGT' AS Syndics, 'tractionnaire' AS Metier, COUNT(*) AS total
	FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%CGT%') AND nom_metier LIKE('%tractionnaire%')
	GROUP BY annee
	UNION
	SELECT annee, 'SUD' AS Syndics, 'tractionnaire' AS Metier,  COUNT(*) AS total
	FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%SUD%') AND nom_metier LIKE('%tractionnaire%')
	GROUP BY annee
	UNION
	SELECT annee, 'CGT' AS Syndics, 'agent de manoeuvre' AS Metier, COUNT(*) AS total
	FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%CGT%') AND nom_metier LIKE('%agent de manoeuvre%')
	GROUP BY annee
	UNION
	SELECT annee, 'SUD' AS Syndics, 'agent de manoeuvre' AS Metier,  COUNT(*) AS total
	FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Organisations NATURAL JOIN Metiers_Cibles
	WHERE nom_orga LIKE('%SUD%') AND nom_metier LIKE('%agent de manoeuvre%')
	GROUP BY annee)
WHERE annee >= 2010
GROUP BY CUBE (annee, Syndics, Metier)
ORDER BY annee;

/* requête n°8 : WINDOW */

SELECT annee, nb_grevistes, SUM(nb_grevistes) over (order by annee rows unbounded preceding) AS Cumul
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
Group by annee, nb_grevistes;
