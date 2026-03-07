-- 1. What is the date of the earliest and latest order, returned in one query?

select min(purchase_ts) as earliest_order,
  max(purchase_ts) as lastest_order 
from core.orders;




-- 2. What is the average order value for purchases made in USD? What about average order value for purchases made in USD in 2019?

--select average usd_price from orders table and filter to where currency = use, and filter to where purchase_ts is in the year 2019
select avg(usd_price) as aov_usd,
from core.orders
where currency = "USD"
and extract (year from purchase_ts) = 2019
;




-- 3. Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.
select id as customer_id,
  loyalty_program as is_loyalty_customer,
  created_on as created_date
from core.customers_orig
where account_creation_method = 'desktop'
or account_creation_method = 'mobile'
;




-- 4. What are all the unique products that were sold in AUD on website, sorted alphabetically?

select distinct product_name
from core.orders
where currency = "AUD"
and purchase_platform = "website"
order by 1
;


-- 5. What are the first 10 countries in the North American region, sorted in descending alphabetical order?

select country_code
from core.geo_lookup
where region = "NA"
order by 1 desc
limit 10
;
-- select distinct region
-- from core.geo_lookup



