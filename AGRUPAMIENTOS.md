```sql
--consultas con agrupamientos
--funciones de agregación

--regresar el numero de géneros almacenados
SELECT* 
FROM "Genre";

SELECT COUNT(*)
FROM "Genre";
------------------------------------------------------COUNT------------------------------------------------------------------
--reportar cunatos clientes tengo registrados 

SELECT COUNT(*)
FROM "Customer";

--reportar cunatos clientes tengo registrados con fax

SELECT COUNT("Fax")
FROM "Customer";
 
 -----------------------------------------------------SUM---------------------------------------------------------------------
 --regresar el total de minutos de las canciones almacenadas
 SELECT SUM("Milliseconds"/1000.0/60.0) AS Total
 FROM "Track";

-------------------------------------------------------MIN------------------------------------------------------------------

--regresar la cantidad de minutos de canción minima registrada
 SELECT MIN("Milliseconds"/1000.0/60.0) AS minutos
 FROM "Track";
 
 ------------------------------------------------------MAX----------------------------------------------------------------------
 --regresar la cantidad de minutos de canción MAXIMA registrada
  SELECT MAX("Milliseconds"/1000.0/60.0) AS minutos
 FROM "Track";
 
 ------------------------------------------------------AVG------------------------------------------------------------------------------
 --regresar la cantidad de minutos promedio de canciones registradas
 SELECT AVG("Milliseconds"/1000.0/60.0) AS minutos
 FROM "Track";

-------------------------------------------------------CAST------------------------------------------------------------------------------
 --regresar la cantidad de minutos promedio de canciones registradas con DOS decimales
 SELECT CAST(AVG("Milliseconds"/1000.0/60.0) AS DECIMAL(5,2)) AS minutos
 FROM "Track";
 
 
 --nombre de la cancion registrada con la menor cantidad de minutos 
 select * from "Track" where "Milliseconds"/1000.0/60.0 =( SELECT MIN("Milliseconds"/1000.0/60.0) AS minutos
 FROM "Track");
 ------------------
 SELECT "Name"
 FROM "Track"
 WHERE "Milliseconds" = (SELECT MIN("Milliseconds") 
                         FROM "Track");
                         
--Listar # de albumes que tiene el artista con nombre 'Deep Purple'
SELECT COUNT(*)
FROM "Album"
WHERE "ArtistId" =( SELECT "ArtistId"
                    FROM "Artist"
                    WHERE "Name" = 'Deep Purple');    
------------------------------------------------------------GROUP BY-----------------------------------------------------------------------------                                 
--reportar id de artista y  # de albumes que tiene cada uno
SELECT "ArtistId",COUNT ("AlbumId") AS NumAlbums
FROM "Album"
GROUP BY "ArtistId";

--reportar nombre de artista y  # de albumes que tiene cada uno
SELECT "Name",NumAlbums
FROM "Artist" NATURAL JOIN (SELECT "ArtistId", COUNT ("AlbumId") AS NumAlbums
                            FROM "Album"
                            GROUP BY "ArtistId") AS Conteo;


--NOMBRE DE ARTISTA Y CANTIDAD DE ALBUMES QUE TIENEN MAS DE 5 ALBUMES
SELECT "Name",NumAlbums
FROM "Artist" NATURAL JOIN (SELECT "ArtistId", COUNT ("AlbumId") AS NumAlbums
                            FROM "Album" 
                            GROUP BY "ArtistId") AS Conteo
WHERE NumAlbums>5;

--reportar el id de artista y la cantidad de albumes, de los artistas que tienen mas de 5 albumes

SELECT "ArtistId",COUNT ("AlbumId") AS NumAlbums
FROM "Album" AS AA
GROUP BY "ArtistId"
HAVING 5< (SELECT COUNT ("AlbumId")
           FROM "Album"
           WHERE AA."ArtistId"="ArtistId");
           
--nombre de artista y de album y cantidad de canciones que tiene el album
SELECT "Name", "Title", B.NumCanciones
FROM "Artist" NATURAL JOIN "Album"  NATURAL JOIN 

(SELECT "AlbumId",COUNT ("TrackId") AS NumCanciones
FROM "Track"
GROUP BY "AlbumId")as B;
-------------------
SELECT "Artist"."Name" AS Artist,"Title", COUNT("Track"."AlbumId") AS NTracks
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId")
GROUP BY "Title", "Artist"."Name";        



--nombre de artista numero de albumes que tiene y cantidad de canciones que tiene.   
--deep purple tiene 11 albumes y 92 canciones en total    FALTA DE RESOLVER

SELECT "Artist"."Name",COUNT("Album"."ArtistId") AS NUM_ALBUM, COUNT ("Track"."AlbumId") AS NUM_CANCIONES
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId")
GROUP BY  "Artist"."Name";

select distinct *
from "Artist"
WHERE "Artist"."Name" ='Deep Purple';

select count(*)
from "Artist" natural join "Album" join "Track" using ("AlbumId")
WHERE "Artist"."Name" ='Deep Purple';
```
