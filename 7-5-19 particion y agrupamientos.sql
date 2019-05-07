--agrupaminetos group by 
--particion o agrupamiento 
---listar el id de factura y cuantos items se compraron en esa factura
--Agrupamientos
SELECT "InvoiceId", SUM ("Quantity") AS compras
FROM "InvoiceLine"
GROUP BY "InvoiceId"
ORDER BY "InvoiceId";
--particiones
SELECT DISTINCT "InvoiceId", SUM ("Quantity") OVER (PARTITION BY "InvoiceId")
FROM "InvoiceLine"
ORDER BY "InvoiceId";

---------------------------


SELECT ct."InvoiceId", "TrackId", Compras
FROM "InvoiceLine" NATURAL JOIN (SELECT "InvoiceId", SUM("Quantity") AS Compras
                                 FROM "InvoiceLine"
                                 GROUP BY "InvoiceId") AS ct
ORDER BY ct."InvoiceId", "TrackId";

SELECT DISTINCT "InvoiceId", "TrackId",SUM("Quantity") OVER (PARTITION BY "InvoiceId")
FROM "InvoiceLine"
ORDER BY "InvoiceId","TrackId";



------LISTAR EL ID DEL CLIENTE, nombre y apellido del cliente, cantidad de compas efectuada por cliente y proporcion con el total


SELECT "CustomerId", "FirstName" , "LastName", Compras, Compras/ (SUM(Compras) OVER ()) ::float AS porcentaje
FROM "Customer" NATURAL JOIN
                                (SELECT "CustomerId", COUNT("InvoiceId") AS Compras
                                FROM "Invoice"
                                GROUP BY "CustomerId") AS a
                                
--------------------------------CONSULTA CLASE ANTERIOR 
-----nombre y apellido del empleado, nombre y apellido de cliente, cuantos clientes atiende ese empleado y cuantas compras ha efectuado ese cliente 
SELECT *
FROM
(SELECT "EmployeeId", "Employee"."FirstName" AS eFN, "Employee"."LastName" AS eLN, "Customer"."FirstName" AS cFN, "Customer"."LastName" AS cLN, "CustomerId", COUNT("CustomerId") OVER (PARTITION BY "EmployeeId") as tcus
FROM "Employee" JOIN "Customer" ON "EmployeeId" = "SupportRepId") AS s_emp
NATURAL JOIN
(SELECT "Customer"."CustomerId", COUNT("InvoiceId") AS tinv
FROM "Customer" NATURAL JOIN "Invoice"
GROUP By "Customer"."CustomerId") AS s_inv

