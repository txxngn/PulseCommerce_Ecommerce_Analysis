-- 1) What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years? 
-- **Clarify:
-- - Can I assume we want an output that shows the count grouped by quarter, ordered in ascending order?
-- - I’m assuming average order value is the average of the usd price column?

-- **Communicate:
-- - I’ll first join orders to customers, then customers to the geo lookup table
-- - Then I’ll filter to Macbooks in North America, and calculate the metrics grouping by quarter
-- - I’ll also round the metrics for readability, and sort by quarter, most recent to oldest

-- **Code:
select date_trunc(purchase_ts, quarter) as purchase_quarter,
  count(orders.id) as order_count,
  round(sum(orders.usd_price),2) as sales,
  round(avg(orders.usd_price),2) as aov
from core.orders 
left join core.customers 
  on orders.customer_id = customers.id
left join core.geo_lookup 
  on geo_lookup.country_code = customers.country_code 
where region = 'NA'and lower(product_name) like '%macbook%'
group by 1
order by 1 desc
;

--Bonus question: what is the average quarterly order count and total sales for Macbooks sold in North America? (i.e. "For North America Macbooks, average of X units sold per quarter and Y in dollar sales per quarter")

with quarterly_metrics as (
  select date_trunc(orders.purchase_ts, quarter) as purchase_quarter,
    count(distinct orders.id) as order_count,
    round(sum(orders.usd_price),2) as total_sales
  from core.orders
  left join core.customers
    on orders.customer_id = customers.id
  left join core.geo_lookup
    on customers.country_code = geo_lookup.country_code
  where lower(orders.product_name) like '%macbook%'and region = 'NA'
  group by 1
  order by 1 desc
)


select avg(order_count) as avg_quarter_orderes,
  avg(total_sales) as avg_quarter_sales
from quarterly_metrics
;




-- 2) For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver? 
-- **Clarify:
-- - Can I assume time to deliver is calculated as the difference in days between purchase time and deliver time?
-- - Just to clarify, we want 2022 website purchases, as well as mobile purchases?

-- **Communicate:
-- - I’ll join the order status table with orders, then customers and geo lookup
-- - Then I’ll filter to (2022 purchases made on the website) and purchases on mobile
-- - Lastly I’ll calculate the time to deliver using a date diff and take the average per region

-- **Code:
select geo_lookup.region,
  avg(date_diff(order_status.delivery_ts, order_status.purchase_ts, day)) as avg_days_to_deliver
from core.order_status
left join core.orders
  on order_status.order_id = orders.id
left join core.customers
  on customers.id = orders.customer_id
left join core.geo_lookup
  on customers.country_code = geo_lookup.country_code
where (extract (year from order_status.purchase_ts) = 2022 and orders.purchase_platform = 'website')
  or orders.purchase_platform = 'mobile'
group by 1
order by 2 desc
;

--Bonus: Rewrite this query for website purchases made in 2022 or Samsung purchases made in 2021, expressing time to deliver in weeks instead of days 

select geo_lookup.region,
  avg(date_diff(order_status.delivery_ts, order_status.purchase_ts, week)) as avg_weeks_to_deliver
from core.order_status
left join core.orders
  on order_status.order_id = orders.id
left join core.customers
  on customers.id = orders.customer_id
left join core.geo_lookup
  on customers.country_code = geo_lookup.country_code
where (extract (year from order_status.purchase_ts) = 2022 and orders.purchase_platform = 'website')
  or (extract (year from order_status.purchase_ts) = 2021 and lower(orders.product_name) like '%samsung%')
group by 1
order by 2 desc
;


-- 3) What was the refund rate and refund count for each product overall? 
-- **Clarify: No new clarifying questions

-- **Communicate:
-- - I’ll join orders to order status and clean up the product name
-- - I’ll create a “helper column” using a case when statement to code 1 for refunds, 0 if not a refund
-- - Then I’ll take the sum of this for the refund count, and average it for the refund rate
-- - Then I’ll order for highest refund rates first, so we can see those products first

-- **Code:
select orders.product_name,
  sum(case when order_status.refund_ts is not null then 1 else 0 end) as refund_count, 
  avg(case when order_status.refund_ts is not null then 1 else 0 end) as refund_rate
from core.orders
left join core.order_status
on order_status.order_id = orders.id
group by 1
order by 3 desc
;

--Bonus: What was the refund rate and refund count for each product per year? How would you interpreet these rates in English?
select extract(year from orders.purchase_ts) as purchase_year,
  orders.product_name,
  sum(case when order_status.refund_ts is not null then 1 else 0 end) as refund_count, 
  avg(case when order_status.refund_ts is not null then 1 else 0 end) as refund_rate
from core.orders
left join core.order_status
on order_status.order_id = orders.id
group by 1,2
order by 3 desc
;

--We group by the year the purchase was made, not the refund date. If we instead grouped by refund date and only looked at refunded orders, the refund rate would always show as 100%, because every remaining row in that group would be a refund. With this definition, the result reads as: “For orders purchased in this year, X% of them eventually got refunded.”




-- 4) Within each region, what is the most popular product? 
-- **Clarify:
-- - Do we want to define “popular” as the product with the highest order count?

-- **Communicate:
-- - I’ll join orders, customers and geo lookup to match products to regions
-- - I’ll count the total orders per product, per region - I’ll need a CTE for this
-- - I’ll then rank each product and region *by* the total orders in a new CTE
-- - Then I’ll order by this ranking to find the most popular product per region
-- - **Bonus:** Use qualify to filter using the row_number without an extra CTE

-- **Code:
with order_count_cte as (
  select geo_lookup.region,
  orders.product_name,
  count(distinct orders.id) as order_count
from core.orders
left join core.customers
on orders.customer_id = customers.id
left join core.geo_lookup
on geo_lookup.country_code = customers.country_code
group by 1,2)

select *,
  row_number() over( partition by region order by order_count desc) as ranking
from order_count_cte
qualify row_number() over(partition by region order by order_count desc) = 1
;

--=where ranking = 1



-- 5) How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers? 
-- **Clarify:
-- - Can I assume time to purchase should be the days or months between purchase timestamp and customer created timestamp?

-- **Communicate:
-- - I’ll join customers to orders to order status
-- - Then I’ll calculate the date difference between purchase timestamp and account creation in days, and calculate a separate column for months
-- - Then I’ll average these two columns and group by loyalty program

-- **Code:
select customers.loyalty_program,
  avg(date_diff(orders.purchase_ts, customers.created_on, day)) as time_to_purchase_days,
  avg(date_diff(orders.purchase_ts, customers.created_on, month)) as time_to_purchase_months
from core.orders
left join core.customers
on customers.id = orders.customer_id
left join core.order_status
on order_status.order_id = orders.id
group by 1
;

--Bonus: Update this query to split the time to purchase per loyalty program, per purchase platform. Return the number of records to benchmark the severity of nulls.

select orders.purchase_platform, 
  customers.loyalty_program, 
  round(avg(date_diff(orders.purchase_ts, customers.created_on, day)),1) as days_to_purchase,
  round(avg(date_diff(orders.purchase_ts, customers.created_on, month)),1) as months_to_purchase,
  count(*) as row_count
from core.customers
left join core.orders
  on customers.id = orders.customer_id
group by 1,2
;














