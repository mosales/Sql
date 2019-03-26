--listar el nombre de la compañia de proveedor, de categoria y de producto de todos los productos   **ordenar asc y desc**
select * from products;

select company_name, category_name, product_name
from categories, products, suppliers
where categories.category_id=products.category_id  AND products.supplier_id= suppliers.supplier_id;

--1 
select company_name, category_name,product_name
from categories natural join products natural join suppliers;

--2listar nombre de compañia de repartidor, el identific de orden y nombre de compañia de cliente de todas las ordenes   
select shippers.company_name, order_id, customers. company_name 
from shippers join orders on shipper_id=ship_via join customers using (customer_id);

-- 3 lsitar el id, nombre de compañia y de contacto de los clientes registrados que nno han efectuado ninguna orden OUTER JOIN CONTRUCCION DE TABLAS
select customers.customer_id, company_name, contact_name
from customers left outer join 
        (select distinct customer_id from orders)as b
on customers.customer_id = b.customer_id
where b.customer_id is null;

--3 lsitar el id, nombre de compañia y de contacto de los clientes registrados que nno han efectuado ninguna orden con SUBCONSULTAS
select customers.customer_id, company_name, contact_name
from customers
where customer_id not in (select distinct customer_id from orders);

--4 listar los datos de los clientes que hayan comprado algun producto de la categoria "SeaFood" y el nombre de la compañia del proovedor del prod sea 
-- "New England Seafood Cannery"
 select *
 from customers
 where customer_id in 
                       (select distinct customer_id
                       from orders
                       where order_id in
                                        (select distinct order_id
                                         from order_details
                                         where product_id in 

                                                              (select product_id
                                                               from products
                                                               where category_id =(select category_id
                                                                                   from categories
                                                                                   where category_name='Seafood')
                    
                                                               AND supplier_id = (Select supplier_id
                                                                                  from suppliers
                                                                                  where company_name='New England Seafood Cannery'))));
                                                                                  
                                                                                  
--5 listar nombre de los dif productos, nombre de compañia de proveedor y nombre de categoria de productos que han comprado clientes de mexico y que no tienen 
--fax registrado 
select product_name, company_name, category_name
from 
(select distinct product_id
from order_details
where order_id in
                (select distinct order_id
                from orders
                where customer_id in
                                     (select customer_id 
                                      from customers
                                      where country = 'Mexico' and fax is null)))as pm
natural join products natural join categories natural join suppliers;

                   
--6 listar datos de los subditos de l empleado Andrew Fuller que hayan atendido compras de clientes del pais mexico y que no tengan fax registrado 


