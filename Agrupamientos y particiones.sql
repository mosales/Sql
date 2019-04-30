--mostarr id de factura y total de compra 
SELECT "InvoiceId",SUM ("Quantity"*"UnitPrice") AS TOTAL
FROM "InvoiceLine" 
GROUP BY "InvoiceId"
ORDER BY "InvoiceId" ASC;
--suma los totales de toda la particion y la muestra
SELECT "InvoiceId" ,"TrackId",SUM ("Quantity"*"UnitPrice") OVER (PARTITION BY "InvoiceId")AS TOTAL
FROM "InvoiceLine" 
ORDER BY "InvoiceId" ASC;
--va sumando el total de cada tupla por particion 
SELECT "InvoiceId" ,"TrackId",SUM ("Quantity"*"UnitPrice") OVER (PARTITION BY "InvoiceId" ORDER BY "TrackId" )AS TOTAL
FROM "InvoiceLine" 
ORDER BY "InvoiceId" ASC;

--RANK fn usa una particion y un ordenamiento de la misma --enumera las tuplas de cada partición 
SELECT "InvoiceId" ,"TrackId",RANK() OVER (PARTITION BY "InvoiceId" ORDER BY "TrackId" DESC)AS ORDEN    
FROM "InvoiceLine" 
ORDER BY "InvoiceId" ASC;

--PERCENT_RANK para mostrar el porcentaje de la particion 
SELECT "InvoiceId" ,"TrackId",PERCENT_RANK() OVER (PARTITION BY "InvoiceId" ORDER BY "TrackId" DESC)AS ORDEN    
FROM "InvoiceLine" 
ORDER BY "InvoiceId" ASC;


--listar nombre de artista, cantidad de album, nombre de album, la cantidad de canciones por album ----347 window functions  LEER
SELECT "Artist"."Name",COUNT(("AlbumId"))  OVER (PARTITION BY "Artist"."Name") AS albumes, "Title"
FROM "Artist" natural join "Album" ;
----------------------CORRECTA
SELECT DISTINCT "Artist"."Name",COUNT(("AlbumId"))  OVER (PARTITION BY "Artist"."Name") AS albumes, "Title", COUNT("TrackId") OVER (PARTITION BY "AlbumId") AS nCanciones
FROM "Artist" natural join "Album" join "Track" USING ("AlbumId");

SELECT "Name" , nAlbum, "Title", nTrack
FROM 
(SELECT "Name","AlbumId", COUNT ("Album"."ArtistId") OVER (PARTITION BY "Album"."ArtistId") AS nAlbum
FROM "Artist" NATURAL JOIN "Album") AS AA
NATURAL JOIN
(SELECT DISTINCT "AlbumId", "Title", COUNT ("Track"."AlbumId") OVER (PARTITION BY "Track"."AlbumId") AS nTrack
FROM "Album" NATURAL JOIN "Track") AS AT
ORDER BY  "Name" ASC, "Title" ASC;




--nombre y apellido del empleado, nombre y apellido de cliente, cuantos clientes atiende ese empleado y cuantas compras ha efectuado ese cliente 






