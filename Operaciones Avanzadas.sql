--UNION junta todos los elementos de A con todos los de B pero que no se repiten  
--UNION ALL junta todos los elementos de A y de B aunque esten repetidos
--Except es como el anterior --elemntos de A que no sean comunes con B
--INTERSECT muestra elementos en comun de A y B 

select "ArtistId"
From "Artist"
Where "Name" in ('Nirvana','Deep Purple');
-------------------------------------------------------------------------------------------
select "ArtistId"
From "Artist"
Where "Name" ='Nirvana'

UNION

select "ArtistId"
From "Artist"
Where "Name" ='Deep Purple';
------------------------------------------------------------------------------------------------
SELECT "FirstName", "LastName"
FROM "Customer" 

UNION

SELECT "FirstName", "LastName"
FROM "Employee";
-------------------------------------------------------------------------------------------------
SELECT "Track"."TrackId", "Name"
FROM "Track" left outer join (Select distinct "TrackId" from "InvoiceLine") as B on "Track"."TrackId" = B. "TrackId"
where B."TrackId" is null;

----similar------
SELECT "TrackId", "Name"
FROM "Track" 
WHERE "TrackId" NOT IN (SELECT DISTINCT "TrackId" FROM "InvoiceLine");

-----except-----------------------
--elemntos de A que no sean comunes con B

SELECT "TrackId"
FROM "Track"

EXCEPT

SELECT DISTINCT "TrackId"
FROM "InvoiceLine";
-------------------------------------------
SELECT "TrackId", "Name"
FROM "Track"
WHERE "TrackId" IN (SELECT "TrackId"
                    FROM "Track"    

                    EXCEPT

                    SELECT DISTINCT "TrackId"
                    FROM "InvoiceLine");
                    
-----Exist ----se utiliza enn el where y se complementa con una sub consulta  CORRELACIONADA y si la subconsulta tiene por lo menos un elemento entonces entra el exist
--listar nombre e Id de todas las canciones que SI me han comprado 
--NOT EXISTS niega todo lo del exists
SELECT "TrackId", "Name" 
FROM "Track"
WHERE "TrackId" IN (SELECT DISTINCT "TrackId"           
                    FROM "InvoiceLine");

---
SELECT t."TrackId", t."Name"
FROM "Track" AS t
WHERE EXISTS (SELECT *
              FROM "InvoiceLine"
              WHERE t."TrackId" = "TrackId");
              
--mostar facturas donde se hallan comprado las canciones 2 y 4
--INTERSECT muestra elementos en comun de A y B 

SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine"
WHERE "TrackId" = 2

INTERSECT

SELECT DISTINCT "InvoiceId"
FROM "InvoiceLine"
WHERE "TrackId" = 4;

--ANY se utiliza como el IN pero tambien se pone un =
SELECT "TrackId", "Name"
FROM "Track"
WHERE "TrackId" IN (SELECT DISTINCT "TrackId" FROM "InvoiceLine");

SELECT "TrackId", "Name"
FROM "Track"
WHERE "TrackId" = ANY (SELECT DISTINCT "TrackId" FROM "InvoiceLine");

--OPERACIONES ARITMETICAS ---------------------------------------------------------
SELECT "InvoiceId","TrackId", "Quantity","UnitPrice"
FROM "InvoiceLine";
              
SELECT "InvoiceId","TrackId", "Quantity","UnitPrice"*"Quantity" AS Subtotal
FROM "InvoiceLine";

--nombre de todas las canciones y duracion en minuto 
SELECT "Name", ("Milliseconds"/1000.0)/60.0 AS Minutos
FROM "Track";






