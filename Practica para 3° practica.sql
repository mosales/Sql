--Listar nombre y apellido de las personas que hayan comprado camciones de 'Led Zeppelin' y 'Deep Purple'
--usando JOINS , subconsultas e INTERSECT
--NO SALIO 
SELECT   DISTINCT "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") JOIN "Album" USING ("AlbumId") JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Led Zeppelin' AND "Artist"."Name"='Deep Purple';
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") JOIN "Album" USING ("AlbumId") JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Led Zeppelin'
INTERSECT
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") JOIN "Album" USING ("AlbumId") JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Deep Purple';

SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Led Zeppelin'
INTERSECT
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Deep Purple';

--Listar identificador y nombre de lista de reproduccion de aquellas que tengan canciones de artistas con nirvana, Metallica o Iron Maiden
--usando Union y otra version usando JOINS (5) in()
SELECT DISTINCT "PlaylistId", "Playlist"."Name"
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING  ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" IN('Nirvana','Metallica','Iron Maiden');
----------------------------------------------------------------------------------------
SELECT DISTINCT "PlaylistId", "Playlist"."Name"
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING  ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Nirvana'
UNION
SELECT DISTINCT "PlaylistId", "Playlist"."Name"
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING  ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" ='Metallica'
UNION
SELECT DISTINCT "PlaylistId", "Playlist"."Name"
FROM "Playlist" NATURAL JOIN "PlaylistTrack" JOIN "Track" USING  ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name" ='Iron Maiden';

--Listar nombre y apellido de las personas que hayan comprado camciones de 'Led Zeppelin' y 'Deep Purple' pero no de 'Black Sabbath
--usando joins y/o subconsultas y EXCEPT(6)
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Led Zeppelin'
INTERSECT
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Deep Purple'
EXCEPT
SELECT  "FirstName", "LastName"
FROM "Customer" NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine" JOIN "Track" USING ("TrackId") NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
WHERE "Artist"."Name"='Black Sabbath';

--listar identificador nombre y apellido y antiguedad de los empleados DATE_PART
SELECT "EmployeeId","FirstName","LastName",
DATE_PART('year' ,current_date)- DATE_PART('year',"HireDate") AS ANT
FROM "Employee"

