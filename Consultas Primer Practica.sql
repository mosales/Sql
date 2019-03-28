```.sql
--Mostrar todas las canciones que tengan genero 1 0 5
SELECT "Name" From "Track" WHERE "GenreId" = 1 Or "GenreId"= 5;
--Mostrar nombre y apellido de clientes que son del pais mexico y que fueron atendidos por empleado con identificador 4
SELECT "FirstName","LastName" FROM "Customer" WHERE "Country"='Mexico' AND "SupportRepId"=4;
--Mostar el nombre de los artistas registrados
SELECT "Name" FROM "Artist" ORDER BY "Name" DESC;
--Listar pais, apellido y nombre de clientes en forma descendente
SELECT "LastName","FirstName","Country" FROM "Customer"  ORDER BY "Country" ASC, "LastName" DESC,"FirstName" DESC;
--listar Pais, Apellido y nombre de clientes que no son de brazil
SELECT "Country", "LastName", "FirstName" 
FROM "Customer" 
WHERE "Country" != 'Brazil';

SELECT "Country", "LastName", "FirstName" 
FROM "Customer" 
WHERE  NOT ("Country" = 'Brazil');

--en que años nacieron mis empleados 
SELECT "LastName","FirstName","BirthDate" FROM "Employee";

--mostar empleados nacidos despues de 1955
SELECT "LastName","FirstName","BirthDate" 
FROM "Employee" 
WHERE "BirthDate">'1955-12-31';

--mostrar empleados nacidos en decadas de los 60's
SELECT "LastName","FirstName","BirthDate" 
FROM "Employee" 
WHERE "BirthDate">='1960-01-01'AND "BirthDate"<='1969-12-31';

--Mostrar clientes
SELECT * FROM "Customer";

--Mostar Clientes sin Compañia
SELECT "FirstName", "LastName", "Company" FROM "Customer" WHERE "Company" IS NULL;

--Mostrar Clientes que SI tienen una compañia asignada
SELECT "FirstName", "LastName", "Company" FROM "Customer" WHERE "Company" IS NOT NULL;

----Mostrar Clientes que SI tienen una compañia asignada y la compañia tiene Inc.
SELECT "FirstName", "LastName", "Company" FROM "Customer" WHERE "Company" IS NOT NULL AND "Company" LIKE '%Inc.%';

--Nombre de cancion y genero de aquellas canciones que tienen genero 1,3,5,7
SELECT "Name","GenreId" 
FROM "Track" 
WHERE "GenreId" ='1' OR "GenreId" = '3' OR "GenreId" = '5' OR "GenreId" = '7';

--Nombre de cancion y genero de aquellas canciones que tienen genero 1,3,5,7
SELECT "Name","GenreId" 
FROM "Track" 
WHERE "GenreId" IN (1,3,5,7);

--mostar Nombre, Apellido y FEcha de nacimiento de empleados nacidos en los 60's CON BETWEEN
SELECT "LastName","FirstName","BirthDate" 
FROM "Employee" 
WHERE "BirthDate" BETWEEN '1960-01-01'AND '1969-12-31';

´´´
