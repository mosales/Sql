--Mostar nombre de artista y titulo de albumes guardados
SELECT "Name","Title"
FROM "Artist", "Album"
WHERE "Artist"."ArtistId"="Album"."ArtistId";

--Nombre de cancion, nombre de album y nombre de artista
SELECT "Artist"."Name","Title","Track"."Name"
FROM "Artist","Album","Track"
WHERE "Artist"."ArtistId"="Album"."ArtistId" 
AND "Album"."AlbumId"="Track"."AlbumId" 
 /* solo los de nirvana o AC/DC*/
AND "Artist"."Name" IN ('Nirvana','AC/DC');

--Nombre de la cancion , nombre del artista, Titulo del album con NATURAL JOIN (cuando se llaman igual )
SELECT "Artist"."Name","Title","Track"."Name"
FROM "Album" NATURAL JOIN "Artist","Track"
WHERE "Album"."AlbumId"="Track"."AlbumId";

--Nombre de la cancion , nombre del artista, Titulo del album con JOIN USING
SELECT "Artist"."Name","Title","Track"."Name"
FROM "Album" NATURAL JOIN "Artist" JOIN "Track" USING ("AlbumId");

--nombre, apellido de empleado y nombre y apellido del empleado al que le reporta 
SELECT e."FirstName",e."LastName", b."FirstName",b."LastName"
FROM "Employee" AS e, "Employee" AS b
WHERE e."ReportsTo" = b."EmployeeId";

--nombre, apellido de empleado y nombre y apellido del empleado al que le reporta 
SELECT e."FirstName",e."LastName", b."FirstName",b."LastName"
FROM "Employee" AS e, "Employee" AS b
WHERE e."ReportsTo" = b."EmployeeId";

--nombre, apellido de empleado y nombre y apellido del empleado al que le reporta con JOIN ON
SELECT e."FirstName",e."LastName", b."FirstName",b."LastName"
FROM "Employee" AS e JOIN "Employee" AS b ON e."ReportsTo" = b."EmployeeId";

-- nombre de cancion y a que play list pertenece
SELECT "Track"."Name", "Playlist"."Name" 
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING ("TrackId");

--seleccionar grupos que tienen cancinones homonimas 
SELECT "Artist"."Name", "Track"."Name"
FROM "Artist" NATURAL JOIN "Album" NATURAL JOIN "Track";

-----------------------------------------------------------------------------------------------------------------
join using tines atributos qe se repiten pero... que no significan lo mismo 

join on  cuando los atributos no tienen el mismo nombre pero lo quieres analizr

natural join  tienen el mismo significado en ambas tablas 
--listar Id empleado, nombre y appleido de todods los empleados que le reportan a NAncy edwars
SELECT e."EmployeeId", e."FirstName", e."LastName" 
FROM "Employee" AS e JOIN "Employee" AS b ON e."ReportsTo" = b."EmployeeId"
WHERE b."FirstName" = 'Nancy' AND b."LastName"= 'Edwards';

--nobres de todas las canciones con genero rock
SELECT "Track"."Name"
FROM "Track"  JOIN "Genre" USING ("GenreId")
WHERE "Genre"."Name"='Rock';

--id cliente , nombre y apellido de todos los que hayan comprado canciones de nirvana
--SELECT "CustomerId", "FirstName", "LastName";


--Nombre e ID de play list que tinen canciones de black savath
SELECT DISTINCt "Playlist"."PlaylistId"
FROM "Artist" NATURAL JOIN "Album" 
JOIN "Track" USING ("AlbumId") 
JOIN "PlaylistTrack" USING ("TrackId") 
JOIN "Playlist" USING ("PlaylistId")
WHERE "Artist"."Name"='Black Sabbath';

--nombe de cancion, album y artiste de las canciones que haya comprado  Daan Peeters 
SELECT DISTINCT "Track"."Name", "Album"."Title", "Artist"."Name"
 FROM "Artist" NATURAL JOIN "Album"
 JOIN "Track" USING ("AlbumId")
NATURAL JOIN "InvoiceLine"
NATURAL JOIN "Invoice" 
NATURAL JOIN "Customer" 
WHERE "FirstName"='Daan' AND "LastName"='Peeters';


--Practica Martes-------------------------------------------------------------------------------------------------------------
--1 Listar nombre de lista de reproducción, nombre de canción, título de álbum
-- y nombre de artista de todas aquellas listas de reproducción que tengan 
--canciones de los artistas con nombre de Bruce Dickinson o Iron Maiden.
SELECT  DISTINCT "Playlist"."Name","Track"."Name","Title","Artist"."Name"
FROM "Artist" NATURAL JOIN "Album" 
JOIN "Track" USING ("AlbumId") 
NATURAL JOIN "PlaylistTrack" 
JOIN "Playlist" USING ("PlaylistId")
WHERE "Artist"."Name"='Bruce Dickinson'OR "Artist"."Name"='Iron Maiden';

--2Listar el nombre, apellido y compañía de los clientes y el identificador 
--y fecha de la factura de aquellas facturas compradas en los años 2010 y 2011
-- con montos totales a $5.00
SELECT "Customer"."FirstName", "Customer"."LastName", "Customer"."Company", "Invoice"."InvoiceId","Invoice"."InvoiceDate"
FROM "Customer" NATURAL JOIN "Invoice"
WHERE ("InvoiceDate" BETWEEN '2010-01-01' AND '2011-12-31') AND "Total"=5.00;

--3 Mostrar el nombre, apellido y compañía de los clientes atendidos por súbditos
-- de la empleada con nombre ‘Nancy’ y apellido ‘Edwards’, 
--además que hayan nacido en los 70’s.
SELECT  DISTINCT "Customer"."FirstName", "Customer"."LastName", "Customer"."Company"
FROM "Employee" AS e JOIN "Employee" AS b ON e."ReportsTo"=b."EmployeeId" 
JOIN "Customer" ON e."EmployeeId"="SupportRepId"
WHERE b."FirstName"='Nancy' AND b."LastName"='Edwards' 
AND (e."BirthDate" BETWEEN '1970-01-01' AND '1979-12-31');

--4 Listar los nombres de canciones y de artistas 
--que tengan en su nombre de canción la cadena ‘Dark’ o ‘dark’.
SELECT DISTINCT "Track"."Name", "Artist"."Name"
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId")
WHERE "Track"."Name" LIKE '%Dark%' OR "Track"."Name" LIKE '%dark%' 
OR "Artist"."Name" LIKE '%Dark%' OR "Artist"."Name" LIKE '%dark%' ;

--5 Listar el nombre, apellido, compañía de los clientes y el identificador 
--de las facturas en las cuales se hayan comprado canciones 
--con el identificador 2 y 4 en la misma factura.
SELECT "FirstName" ,"LastName", "Company", "InvoiceId"
FROM "InvoiceLine" AS L1 JOIN "InvoiceLine" AS L2 USING ("InvoiceId")
NATURAL JOIN "Invoice" NATURAL JOIN "Customer"
WHERE L1."TrackId"=2 AND L2."TrackId" =4;
------------tema---------------------

--mostar titulo de album de todos los albumes de nirvana or black sABATH
SELECT "Title"
FROM "Artist" NATURAL JOIN "Album"
WHERE "Name" IN ('Nirvana','Black Sabbath');

-- con construccion de tablas
SELECT "Title"
FROM "Album" NATURAL JOIN (SELECT "ArtistId"
                           FROM "Artist"
                           WHERE "Name" IN ('Nirvana','Black Sabbath')) AS NBS;
                           
--sub consulta no relacionada  (Para una sola tupla de resultado)
SELECT "Title"
FROM "Album"
WHERE "ArtistId"=(SELECT "ArtistId"
                  FROM "Artist"
                  WHERE "Name"='Nirvana');
                  
----sub consulta no relacionada  (Para mas tuplas de resultado )           
SELECT "Title"
FROM "Album"
WHERE "ArtistId" IN (SELECT "ArtistId"
                     FROM "Artist"
                     WHERE "Name" IN ('Nirvana','Black Sabbath'));

--Consultas para practica No.2
/*
1.Mostrar nombre de canción, titulo de álbum y nombre de artista de las canciones que tienen en común las listas de reproducción con nombre 'Music' y 'Heavy Metal Classic'
2.Mostrar el identificador de factura de todas aquellas en las que se hayan comprado canciones del grupo con nombre 'Deep Purple'
3.Mostrar el identificador de factura de todas aquellas en las que se hayan comprado canciones de los grupos con nombre 'Deep Purple' y 'Led Zeppelin'
4.Mostrar el nombre, apellido de los clientes que hayan comprado canciones de los grupos con nombre 'Deep Purple' y 'Led Zeppelin' pero no de 'Santana'

*/
--1
Select distinct "Track"."Name" , "Title" , "Artist"."Name" , "Playlist"."Name"
from "Playlist" Natural join "PlaylistTrack" join "Track" using ("TrackId") join "Album" using ("AlbumId") join "Artist" using ("ArtistId")
where "Playlist"."Name" in ('Music','Heavy Metal Classic');--3313

--1 NO
Select  "Track"."Name" , "Title" , "Artist"."Name" , "Playlist"."Name"
from "Playlist" Natural join "PlaylistTrack" join "Track" using ("TrackId") join "Album" using ("AlbumId") join "Artist" using ("ArtistId")
where "Track"."Name" in (Select "Track"."Name" from "Playlist" Natural join "PlaylistTrack" join "Track" using ("TrackId") where "Track"."Name" in (
Select "Track"."Name" from "Playlist" Natural join "PlaylistTrack" join "Track" using ("TrackId") where "Playlist"."Name"='Music') and "Playlist"."Name"='Heavy Metal Classic');
--2
select distinct "InvoiceId", "Artist"."Name"
FROM "InvoiceLine" natural join "Track" natural join "Album" join "Artist" using ("ArtistId")
WHERE "Artist"."Name"='Deep Purple'; --10

--3
select "InvoiceId", "Artist"."Name"
FROM "InvoiceLine" natural join "Track" natural join "Album" join "Artist" using ("ArtistId")
WHERE "Artist"."Name"='Deep Purple' and "Artist"."Name"= 'Led Zeppelin'; 

--4
Select "Customer"."FirstName" ,"LastName" 
From "Customer"
where "CustomerId" in (Select "CustomerId"
                        FROM "InvoiceLine"
                        where "InvoiceId" in (Select "InvoiceId"
                                                from "InvoiceLine"
                                                where "TrackId" in (Select "TrackId"
                                                                    from "Track"
                                                                    Where "AlbumId" in (Select "AlbumId"
                                                                                        from "Album"
                                                                                        where "ArtistId" in (Select "ArtistId" 
                                                                                                              from "Artist" 
                                                                                                              where "Name" = 'Led Zeppelin' and "Name" = 'Deep Purple')))));
                                                                                                              
--5 Mostrar nombre, apellido de empleado de los que hayan atendido clientes que hayan comprado alguna cancion de 'Nirvana', 'Apocalyptica' o 'Metallica'                                                                                                               
Select "Employee"."FirstName" , "Employee"."LastName" 
From "Employee" join "Customer" on "EmployeeId"="SupportRepId" natural Join "Invoice" natural join "InvoiceLine" Natural Join "Track" natural join "Album"
Join "Artist" using ("ArtistId")
where "Artist"."Name" in ('Nirvana');
--------------------------------JULY--------------------------------------------------------------------------------------------------------------

--1)Mostrar nombre de canción, titulo de álbum y nombre de artista de las canciones que tienen en común las listas de reproducción con nombre 'Music' y 'Heavy Metal Classic'
SELECT DISTINCT "Track"."Name","Title","Artist"."Name"
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Playlist"."Name" IN ('Music','Heavy Metal Classic');

--2)Mostrar el identificador de factura de todas aquellas en las que se hayan comprado canciones del grupo con nombre 'Deep Purple'
SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" = 'Deep Purple';


--3)Mostrar el identificador de factura de todas aquellas en las que se hayan comprado canciones de los grupos con nombre 'Deep Purple' y 'Led Zeppelin'
SELECT * FROM
(SELECT DISTINCT "InvoiceId","Artist"."Name"
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" = 'Deep Purple') AS DP
NATURAL JOIN
(SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" = 'Led Zeppelin') AS LZ;

--4)Mostrar el nombre, apellido de los clientes que hayan comprado canciones de los grupos con nombre 'Deep Purple' y 'Led Zeppelin' pero no de 'Santana'
SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" = 'Santana';

SELECT DISTINCT "FirstName","LastName"
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "InvoiceLine" NATURAL JOIN "Invoice" NATURAL JOIN "Customer"
WHERE "Artist"."Name" = 'Deep Purple' or "Artist"."Name" = 'Led Zeppelin' AND not "Artist"."Name" = 'Santana';

SELECT DISTINCT "FirstName","LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" NATURAL JOIN "Track" JOIN "Album" Using ("AlbumId") JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" = 'Deep Purple' OR "Artist"."Name" = 'Led Zeppelin' AND NOT "Artist"."Name" = 'Santana';

--5)Mostrar nombre, apellido de empleado de los que hayan atendido clientes que hayan comprado alguna cancion de 'Nirvana', 'Apocalyptica' o 'Metallica'
SELECT "FirstName","LastName"
FROM "Employee"
WHERE "EmployeeId" IN
(SELECT DISTINCT "SupportRepId"
FROM "Customer"
WHERE "CustomerId" IN
(SELECT DISTINCT "CustomerId"
FROM "Invoice"
WHERE "InvoiceId" IN (SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine"
WHERE "TrackId" IN (SELECT "TrackId"
FROM "Track"
WHERE "AlbumId" IN
(SELECT "AlbumId"
FROM "Album"
WHERE "ArtistId" IN
(SELECT "ArtistId"
FROM "Artist"
WHERE "Name" IN ('Metallica','Apocalyptica','Nirvana')))))));

Select "FirstName","LastName"
From "Employee"
where "EmployeeId" in
(Select distinct "SupportRepId"
from "Customer" where "CustomerId" in 
(select distinct "CustomerId" from "Invoice"
where "InvoiceId" in 
(Select distinct "InvoiceId" 
from "InvoiceLine" where "TrackId" in 
(Select "TrackId" from "Track"
where "AlbumId" in
(select "AlbumId" from "Album"
Where "ArtistId" in 
(Select "ArtistId" from "Artist"
WHERE "Name" in ('Metallica','Apocalyptica','Nirvana')))))));

