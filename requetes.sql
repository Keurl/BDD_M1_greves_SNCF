--Fichier d'insertion des requêtes


prompt *******************************************************************
prompt ****************************  REQUETES ****************************
prompt *******************************************************************

/* idées de requêtes OLAP : 

avec group by cube : de 2002 a 2005, le nombre de grèvistes par grève par année




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
