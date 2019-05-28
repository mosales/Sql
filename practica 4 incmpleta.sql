--1. Calcular el total de todas la compras registradas (renombrar el atributo calculado con la función de agregación como tb).
-- (1 resultado, 1354458.590441227).
SELECT  distinct SUM(a) over() as tb
from
(SELECT  order_id,((unit_price*quantity)/**(1-discount)*/)AS a
FROM order_details) AS B;
--
SELECT sum((quantity*unit_price) * 1 - discount) AS tb
FROM order_details;
--
SELECT SUM(quantity*unit_price) AS tb
from order_details;

--2. Listar el identificador de empleado y la cantidad de órdenes que ha tenido (renombrar el atributo calculado con la función de agregación co). Ordenar en forma ascendente por identificador de empleado. 
--(9 resultados, employee_id = 1, co = 123).
SELECT employee_id, count(order_id) AS co
FROM employees NATURAL JOIN orders
GROUP BY employee_id
ORDER BY employee_id ASC;
--
SELECT distinct employee_id, count (order_id)over(partition by employee_id) as co
from orders
order by employee_id;

--3. Listar el identificador de cliente y cantidad de órdenes (renombrar el tributo calculado con la función de agregación co) de aquellos clientes que tengan el máximo número de ordenes levantadas. Ordenar por identificador de cliente de forma ascendente.
--(1 resultado, customer_id = SAVEA, co = 31).
--saber cuantos compras tiene cada cliente, obtener el max de esas compras, descubrir quien tiene igua a ese cliente
SELECT customer_id, count(order_id) AS CO
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = (SELECT MAX(CO)
                          FROM (SELECT customer_id, count(order_id) AS CO
                                FROM orders
                                GROUP BY customer_id) AS maximo);
                                
--Para poder visualizar lo que hicimos, separamos la consulta:
--PASO 2 
SELECT MAX(CC)
FROM (SELECT customer_id, COUNT(order_id) AS CC
FROM orders
GROUP BY customer_id) AS tmp;
--PASO 1
SELECT customer_id, COUNT(order_id) AS CC
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 31;


--4. Listar el identificador de orden, identificador de producto, precio unitario, cantidad, descuento y la proporción del subtotal del producto con respecto al total de la orden (renombrar el atributo calculado por spr). Ordenar de forma ascendente por identificador de orden y producto.
--(2155 resultados).
SELECT order_id, product_id, unit_price, quantity, discount,((quantity*unit_price)*1-discount) / sum ((quantity*unit_price)*1-discount) OVER (PARTITION BY order_id) AS SPR
FROM order_details
GROUP BY order_id, product_id
ORDER BY order_id, product_id ASC;

--
select *, ((unit_price*quantity)*(1-discount))/ sum ((unit_price*quantity)*(1-discount)) over (partition by order_id) as spr
from order_details
order by order_id, product_id asc;
--5. Listar el nombre de compañía de cliente y el total de su orden más cara. Ordenar por nombre de compañía en orden ascendente.
--(89 resultados, Trail’s Head Gourmet Provisioners, Max_total = 764.299991607666).

SELECT DISTINCT company_name,MAX(Total) OVER (PARTITION BY company_name) AS max_total
FROM (SELECT customer_id,order_id,company_name,SUM(quantity*unit_price*(1-discount)) AS Total
FROM customers NATURAL JOIN orders NATURAL JOIN order_details
GROUP BY order_id, company_name,customer_id) AS Totales
ORDER BY company_name ASC;
-- EL RESULTADO DE MAX_TOTAL ESTA BIEN PERO NO SALE COMO EN LA CAPTURA DEL EXAMEN

select DISTINCT company_name, MAX(total) OVER (PARTITION BY company_name) AS max_total
FROM (SELECT company_name,customer_id,order_id, SUM (unit_price*quantity*(1-discount)) as total
FROM orders NATURAL JOIN order_details NATURAL JOIN customers
GROUP BY order_id,company_name) as tmp;


------------------------------------------------------------------------------------------------------------------------------------------------------
--1. Listar la cantidad de albumes registrados.
SELECT COUNT("AlbumId") AS CantAlbumes
FROM "Album";
--2. Listar el número de compras (no canciones, sino facturas registradas) por día.
SELECT "InvoiceDate",COUNT("InvoiceId") OVER (PARTITION BY "InvoiceDate") AS ComprasXDia
FROM "Invoice";
--3. Listar los identificadores de clientes que hayan efectuado más de una compra.
SELECT "CustomerId",count("InvoiceId") AS cantidad_compra
FROM "Invoice"
GROUP BY "CustomerId"
HAVING COUNT ("InvoiceId") > 1
ORDER BY "CustomerId";
--4. Listar el nombre de artista y la cantidad de canciones que se han vendido de cada uno.
SELECT "Name", tracks_vendidos
FROM "Artist" NATURAL JOIN (SELECT "ArtistId",SUM("Quantity") AS tracks_vendidos
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album"
GROUP BY "ArtistId") AS artista;


SELECT DISTINCT "Artist"."Name", SUM("Quantity") OVER (PARTITION BY "Artist"."ArtistId") AS t_sold
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album" JOIN "Artist" USING ("ArtistId")
ORDER BY "Artist"."Name" ASC;

SELECT "Name", t_sold
FROM "Artist" NATURAL JOIN (
SELECT DISTINCT "ArtistId", SUM("Quantity") AS t_sold
FROM "InvoiceLine" NATURAL JOIN "Track" NATURAL JOIN "Album"
GROUP BY "ArtistId") AS summary;

--5. Listar el nombre de playlist, el nombre de artista y la proporción de cantidad de canciones que tiene dicho artista con base al total de canciones en la lista.

SELECT PN, AN, TotalXArtista, total,(TotalXArtista/Total::float)AS proporción
FROM (SELECT DISTINCT "Playlist"."Name" AS PN, "Artist"."Name" AS AN,COUNT("TrackId") OVER (PARTITION BY "Artist"."ArtistId") AS TotalXArtista,COUNT("PlaylistTrack"."TrackId") OVER (PARTITION BY "PlaylistId") AS total
FROM"Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "PlaylistTrack" JOIN "Playlist" USING ("PlaylistId")) AS conteo_general;

SELECT DISTINCT P, A, COUNT(T) OVER (PARTITION BY A), Total, (COUNT(T) OVER (PARTITION BY A) / Total::float) AS p
FROM
(SELECT  "Playlist"."Name" AS P, "Artist"."Name" AS A, "PlaylistTrack"."TrackId" AS T, COUNT("PlaylistTrack"."TrackId") OVER (PARTITION BY "PlaylistId") AS Total 
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "PlaylistTrack" JOIN "Playlist" USING ("PlaylistId")) AS t_sum;







