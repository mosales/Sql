--1
SELECT * FROM "suppliers" ORDER BY "company_name";
--2
SELECT "first_name", "last_name","hire_date" 
FROM "employees" ORDER BY "hire_date" DESC;
--3
SELECT "product_id"
FROM "products"
ORDER BY "product_id" ASC;

--4
SELECT "product_id","product_name","quantity_per_unit","unit_price" 
FROM "products" 
WHERE "supplier_id"='6' ORDER BY "product_name" ASC;
--5
SELECT "product_name","units_in_stock" 
FROM "products" 
WHERE "supplier_id"='2' OR "supplier_id"='3' AND "category_id"='2' ORDER BY "units_in_stock" DESC;
--6
SELECT "title_of_courtesy", "first_name","last_name","city", "region", "country" 
FROM "employees" 
WHERE "reports_to" IS NULL ORDER BY "country" , "region", "city";
--7
SELECT "first_name","last_name","title"
FROM "employees"
WHERE "birth_date" BETWEEN '1960-01-01' AND '1969-12-31' 
AND "hire_date" BETWEEN '1992-01-01'AND '1992-12-31'
AND "country"='USA'
ORDER BY "title" ASC;
--8
SELECT "product_name","quantity_per_unit","unit_price","discontinued" 
FROM "products" 
WHERE "quantity_per_unit" LIKE '%bags%'  AND "unit_price">='100' AND "discontinued"='1' ORDER BY "product_name" ASC;
--9
SELECT "company_name","contact_name","contact_title"
FROM "suppliers"
WHERE "homepage" IS NOT NULL 
AND "fax" IS NULL
AND "contact_title" LIKE 'Marketing%'
ORDER BY "company_name" DESC;
