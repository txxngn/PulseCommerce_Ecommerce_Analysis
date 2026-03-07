-- 1. What is the total number of orders by shipping month, sorted from most recent to oldest?
--calculate the month for each shipping timestamp, and then count the order ids for each month, from the order_status, order by the shipping month in desc
select date_trunc(ship_ts, month) as shipping_month, 
  count(distinct order_id) as order_number
from core.order_status
group by 1
order by 1 desc
;




-- 2. What is the average order value by year? Can you round the results to 2 decimals?
 
select date_trunc(purchase_ts, year) as year, 
  round(avg(usd_price),2) as aov
from core.orders
group by 1

;






-- 3. Create a helper column `is_refund`  in the `order_status`  table that returns 1 if there is a refund, 0 if not. Return the first 20 records.

select *,
  case when refund_ts is null then 0 else 1 end as is_refund
from core.order_status
limit 20
;




-- 4. Return the product IDs and product names of all Apple products.
select distinct product_id,
  product_name
from core.orders
where product_name like '%Apple%'
or product_name like 'Macbook%'
;

--select distinct product_name from core.orders






-- 5. Calculate the time to ship in days for each order and return all original columns from the table.

select *,
  date_diff(delivery_ts, ship_ts, day) as shipping_days
from core.order_status
order by shipping_days desc









