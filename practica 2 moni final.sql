--1
select distinct shippers. company_name
from customers natural join orders join shippers on orders.ship_via=shippers.shipper_id
where customers.country='Mexico';

--2

select shippers.company_name, order_id, first_name, last_name
from employees natural join orders join shippers on orders.ship_via = shippers.shipper_id join customers on orders.customer_id = customers.customer_id
where customers.company_name='Alfreds Futterkiste'and employee_id in 

(select  j.employee_id from 
employees as s join employees as j on s.employee_id = j.reports_to
where s.first_name='Andrew' and s.last_name='Fuller' and j.birth_date < '1949-12-31')
order by order_id desc;

--3

select distinct customers.company_name, order_id, ship_name, shippers.company_name
from customers natural join orders join shippers on orders.ship_via=shippers.shipper_id
where ship_name <> customers.company_name
order by order_id asc;

--4

select *
from
(select category_name from 
categories natural join products natural join suppliers
where company_name='Exotic Liquids') as a 

 join 

(select category_name from 
categories natural join products natural join suppliers 
where company_name='Pavlova, Ltd.');
--5
select product_name
from products natural join suppliers
where company_name='Exotic Liquids'
order by product_name desc;

