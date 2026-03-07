--1. For each purchase platform, return the top 3 customers by the number of purchases and order them within that platform. If there is a tie, break the tie using any order. 

with customer_product_count as (
  select purchase_platform,
    customer_id,
    count(distinct id) as num_purchases
  from core.orders
  group by 1,2),

ranking_cte as (
	select *, 
	  row_number() over (partition by purchase_platform order by num_purchases desc) as order_ranking
	from customer_product_count)

select * 
from ranking_cte 
where order_ranking <= 3
;

--OR

with ranking_cte as (
	select purchase_platform,
    customer_id, 
	  row_number() over (partition by purchase_platform order by count (distinct id) desc) as order_ranking
	from core.orders
  group by 1,2)

select * 
from ranking_cte 
where order_ranking <= 3;

--OR

select purchase_platform,
    customer_id, 
	  row_number() over (partition by purchase_platform order by count (distinct id) desc) as order_ranking
	from core.orders
  group by 1,2
  qualify row_number() over (partition by purchase_platform order by count (distinct id) desc) <= 3
;






--2. What is the count of orders that were either EMEA laptop purchases or Bose purchases from 2019?
select count(distinct orders.id) as order_count
from core.orders
left join core.customers
	on orders.customer_id = customers.id
left join core.geo_lookup
	on geo_lookup.country_code = customers.country_code
where (geo_lookup.region = 'EMEA' and orders.product_name like '%Laptop%')
	or (extract(year from orders.purchase_ts) = 2019 and orders.product_name like '%bose%')
;





--3. Return all of the orders that were a customer’s third order in their purchase history. If there was more than one order on the same day, return all of the orders from that day.
--rank or dense_rank
--use dense_rank instead of rank since rank might skip ranking = 3 if there is a tie on ranking = 2

--rank    dense_rank
--1         1
--2         2
--2         2
--4         3

with ranking as (
	select *,
		dense_rank() over (partition by customer_id order by purchase_ts) as order_ranking
	from core.orders)
	
select * 
from ranking
where order_ranking = 3
;






--4. Return the number of Apple orders per country in 2022, assuming that orders with null countries are from the United States. As a check, return all the original country codes in the query.
--coalesce()

select coalesce(customers.country_code, 'US') as country_clean,
	count(distinct orders.id) as order_count
from core.orders
left join core.customers
on orders.customer_id = customers.id
left join core.geo_lookup
on geo_lookup.country_code = customers.country_code
where lower(product_name) like '%apple%' 
	and extract (year from orders.purchase_ts) = 2022
group by 1
;





--5. Return all of the unique combinations of the currencies and suppliers, separated by a / , in one column
--concat()
select distinct concat(orders.currency, ' / ', suppliers.supplier) as currency_supplier
from core.orders
left join core.suppliers
	on orders.product_id = suppliers.product_id
order by 1






-- 6. Return all the distinct product IDs, distinct product names, and distinct supplier names in one query, ordered alphabetically. Write one query using union distinct, and one query using union all.

--union distinct
select product_id from core.orders
union distinct
select product_name from core.orders
union distinct
select supplier from core.suppliers;

--union all
select distinct product_id from core.orders
union all
select distinct product_name from core.orders
union all
select distinct supplier from core.suppliers
;





-- 7. For each customer, what are the distinct products they’ve bought (one row per customer)?
--string_agg
select customer_id, 
  string_agg(distinct product_name, ", " ) as distinct_products
from core.orders
group by 1;



-- 7.1 For every region, return the country codes associated with that region in alphabetical order.
--sort the geo lookup table first, then concatenate country codes
with sorted_countries as (
  select *
  from core.geo_lookup
  order by country_code asc)

select region, 
  string_agg(country_code, ", ") as country_codes
from sorted_countries
group by 1;





-- 8. Return the count of orders for each brand, assuming you don’t know the capitalization consistency of the product name.
select case when lower(product_name) like '%apple%' or lower(product_name) like '%macbook%' then 'Apple'
  when lower(product_name) like '%thinkpad%' then 'Lenovo'
  when lower(product_name) like '%samsung%' then 'Samsung'
  when lower(product_name) like '%bose%' then 'Bose'
  else 'Unknown' end as brand, 
  count(distinct id) as order_count
from core.orders
group by 1;






-- 9. Return all Apple related orders using one line in the `WHERE` clause.
select *
from core.orders
where lower(product_name) like any ('%apple%', '%macbook%');


-- 10. Find all products IDs that satisfy at least one of the following: **start `0`, end in `c`, or contain a `4`.
select distinct product_id
from core.orders
where product_id like any ('0%', '%c','%4%');





-- 11. Who was the supplier for the product in each order? Use an explicit join on all necessary columns.
select orders.id, 
	orders.product_name, 
	suppliers.supplier
from core.orders
left join core.suppliers
	on orders.product_id = suppliers.product_id
	and orders.product_name = suppliers.product_name;

--with using
select orders.id, 
	orders.product_name, 
	suppliers.supplier
from core.orders
left join core.suppliers
using (product_id, product_name);






































