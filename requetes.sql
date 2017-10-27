--Fichier d'insertion des requêtes


prompt *******************************************************************
prompt ****************************  REQUETES ****************************
prompt *******************************************************************

SELECT  EXTRACT( YEAR FROM date_deb) AS annee, date_deb, SUM(DISTINCT nb_grevistes) 
FROM Table_Faits NATURAL JOIN Temps NATURAL JOIN Nb_Travailleurs
GROUP BY ROLLUP (EXTRACT( YEAR FROM date_deb), date_deb);