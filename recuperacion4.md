
```sql
--1 listar precio unitario mas barato de los productos registrados
SELECT MIN (unit_price)
FROM products;

--2 listar identificador de categoria y cantidad de productos en cada categoria (renombrar como pCat.) ordenar por identificador de categoria en forma ascendente
select category_id, count (product_id)
from categories natural join products
group by category_id
order by category_id asc;

--3
SELECT customer_id, count(order_id) AS ocus
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >5
order by customer_id asc ;

--4
select product_name, category_name
from products natural join categories
where product_id =
                   (select product_id
                   from order_details
                   group by product_id
                   having sum(quantity) =(select max(suma)from
                           (select product_id, sum(quantity) as suma
                           from order_details
                           group by product_id) as table1));

--5
select category_name, count (product_id)/ sum(count (product_id)) over() as pprod
from categories natural join products
group by category_id
order by category_id asc;
```
