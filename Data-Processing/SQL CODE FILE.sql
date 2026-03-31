select * from `workspace`.`default`.`brightsello_coffee_shop_sales` limit 100;

SELECT
----Dates 
transaction_date AS purchase_date,
dayname(transaction_date) AS Day_name,
monthname(transaction_date) as month_name,
dayofmonth(transaction_date) as day_of_month,

CASE
WHEN dayname(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
ELSE 'Weekday'
END AS day_classification,

CASE
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01.Morning'
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '17:59:59' THEN '02.Afternoon'
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '18:00:00' AND '23:59:59' THEN '03.Evening'
END AS purchase_time_period,
store_location AS store,

---ANY VALUE
ANY_VALUE(product_category) AS product_category,
ANY_VALUE(product_type) AS product_type,
ANY_VALUE(product_detail) AS product_detail,

---- Counts of IDS
COUNT(DISTINCT transaction_id) AS number_of_sales,
COUNT(DISTINCT product_id) AS number_of_products,
COUNT(DISTINCT store_id) AS number_of_stores,
COUNT(DISTINCT product_category) AS number_of_product_categories,
COUNT(DISTINCT product_type) AS number_of_product_types,
COUNT(DISTINCT product_detail) AS number_of_product_details,
---Revenue
SUM(Transaction_qty*unit_price) AS revenue_per_day
FROM `workspace`.`default`.`brightsello_coffee_shop_sales`
GROUP BY transaction_date, transaction_time, store_location;