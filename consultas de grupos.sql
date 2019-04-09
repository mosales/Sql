-- Listar la cantidad de compras que ha realizado el cliente con nombre Kara y apellido Nielsen
SELECT COUNT("CustomerId")
FROM "Invoice"
WHERE "CustomerId" = (SELECT "CustomerId" FROM "Customer" WHERE "FirstName"='Kara' AND "LastName"='Nielsen');
-- Listar el identificador de orden y el total de las compras del cliente con nombre Kara y apellido Nielsen
SELECT "InvoiceId",SUM("Quantity"*"UnitPrice") AS Total
FROM "InvoiceLine"
WHERE "InvoiceId" IN (SELECT "InvoiceId"
                       FROM "Invoice"
                       WHERE "CustomerId" = (SELECT "CustomerId" FROM "Customer" WHERE "FirstName"='Kara' AND "LastName"='Nielsen'))
GROUP BY "InvoiceId";   
-- Listar las compras del cliente con nombre Kara y apellido Nielsen que superen o igualen el promedio de las compras registradas
SELECT "InvoiceId",SUM("Quantity"*"UnitPrice") AS Total
FROM "InvoiceLine"
WHERE "InvoiceId" IN (SELECT "InvoiceId"
                       FROM "Invoice"
                       WHERE "CustomerId" = (SELECT "CustomerId" FROM "Customer" WHERE "FirstName"='Kara' AND "LastName"='Nielsen'))
GROUP BY "InvoiceId"
HAVING SUM("Quantity"*"UnitPrice") >= (SELECT AVG(Total) AS A_total
                                       FROM (SELECT SUM("Quantity"*"UnitPrice") AS Total
                                             FROM "InvoiceLine"
                                       GROUP BY "InvoiceId") AS Totales);
-- Listar el nombre de las canciones más compradas
SELECT "Name"
FROM "Track"
WHERE "TrackId" IN (SELECT "TrackId"
                    FROM "InvoiceLine"
                    GROUP BY "TrackId"
                    HAVING SUM("Quantity") = (SELECT MAX(Qty)
                                              FROM (SELECT "TrackId", SUM("Quantity") AS Qty
                                                    FROM "InvoiceLine"
                                              GROUP BY "TrackId") AS times));
-- listar el nombre de los artistas con mas canciones vendidas
SELECT "Artist"."Name",SUM("Quantity") AS Total
FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine"                                           
GROUP BY "Artist"."Name"
HAVING SUM("Quantity") = (SELECT MAX(Total)
                          FROM (SELECT SUM("Quantity") AS Total
                                FROM "Artist" NATURAL JOIN "Album" JOIN "Track" USING ("AlbumId") NATURAL JOIN "Invoice" NATURAL JOIN "InvoiceLine"                                           
                          GROUP BY "ArtistId") AS Totales);                      