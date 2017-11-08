--Fichier d'insertion des requêtes


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

SELECT  EXTRACT( YEAR FROM date_deb) AS annee, date_deb, SUM(DISTINCT nb_grevistes) 
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
GROUP BY ROLLUP (EXTRACT( YEAR FROM date_deb), date_deb);


/* C'est nul après */ 

--afficher le nombre de grèviste par an et par association entre 2002 et 2005 en utilisant grouping sets

SELECT O.ID_Orga, EXTRACT( YEAR FROM t.date_deb) AS annee, SUM(DISTINCT nb_grevistes)
FROM Table_Faits tf NATURAL JOIN Nb_Travailleurs NbT NATURAL JOIN Temps t NATURAL JOIN Orga O
GROUP BY GROUPING SETS((O.ID_Orga), (EXTRACT( YEAR FROM date_deb) AS annee));

--afficher les nombre de grèves par saison

--SELECT T.saison, Count(tf)
--FROM Table_Faits tf NATURAL JOIN Temps
--GROUP BY ROLLUP (T.saison)
