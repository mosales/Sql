-- Regresar el numero de generos almacenados
SELECT *
FROM "Genre";
SELECT COUNT(*)
FROM "Genre";
SELECT COUNT(*)
FROM "Customer";
SELECT COUNT("Fax")
FROM "Customer";
-- Regresar el total de minutos de las canciones almacenadas
SELECT SUM("Milliseconds"/ 1000.0 / 60.0) AS Total
FROM "Track";
-- Regresar la cantidad de minutos de cancion minima registrada
SELECT MIN("Milliseconds"/ 1000.0 / 60.0) AS Total
FROM "Track";
-- Regresar la cantidad de minutos de cancion maxima registrada
SELECT MAX("Milliseconds"/ 1000.0 / 60.0) AS Total
FROM "Track";
-- Regresar la cantidad de minutos de cancion promedio registrada
SELECT AVG("Milliseconds"/ 1000.0 / 60.0) AS Total
FROM "Track";
-- Regresar la cantidad de minutos de cancion promedio registrada con dos decimales de precision
SELECT CAST(AVG("Milliseconds"/ 1000.0 / 60.0) AS DECIMAL(3,2)) AS Total
FROM "Track";
-- Reportar el nombre de cancion con la menor duracion
SELECT "Name"
FROM "Track"
WHERE "Milliseconds" = (SELECT MIN("Milliseconds")
                        FROM "Track");
-- Reportar cuantos albumes tiene el artista con nombre 'Deep Purple'                        
SELECT COUNT(*) 
FROM "Album"
WHERE "ArtistId" = (SELECT "ArtistId" 
                    FROM "Artist" 
                    WHERE "Name" = 'Deep Purple');
-- Reportar el identificador de artista y la cantidad de albumes que tiene
SELECT "ArtistId", COUNT("AlbumId") AS NumAlbums
FROM "Album"
GROUP BY "ArtistId";                    
-- Reportar el nombre de artista y la cantidad de albumes que tiene
SELECT "Name", NumAlbums
FROM "Artist" NATURAL JOIN (SELECT "ArtistId", COUNT("AlbumId") AS NumAlbums
                            FROM "Album"
                            GROUP BY "ArtistId") AS conteo; 
-- Reportar el nombre de artista y la cantidad de albumes que tiene siempre y cuando tengan mas de 5 albumes
SELECT "Name", NumAlbums
FROM "Artist" NATURAL JOIN (SELECT "ArtistId", COUNT("AlbumId") AS NumAlbums
                            FROM "Album"
                            GROUP BY "ArtistId") AS conteo
WHERE NumAlbums > 5;                             
-- Reportar el identificador de artista y la cantidad de albumes que tiene siempre y cuando tengan mas de 5 albumes
SELECT "ArtistId", COUNT("AlbumId") AS NumAlbums
FROM "Album" AS AA
GROUP BY "ArtistId"
HAVING 5 < (SELECT COUNT("AlbumId")
            FROM "Album"
            WHERE AA."ArtistId" = "ArtistId");        
-- Listar nombre de artista, titulo de album y cantidad de canciones en album
SELECT "Artist"."Name","Title", COUNT("Track"."AlbumId") AS NTracks
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId")
GROUP BY "Title", "Artist"."Name"            
ORDER BY "Artist"."Name","Title";

            