CREATE TABLE raw_sale(
invoiceNo VARCHAR(25),
stockcode VARCHAR(50),
description TEXT,
quantity INTEGER,
invoicedate TIMESTAMP,
unitprice NUMERIC(10,2),
customerid VARCHAR(50),
    country VARCHAR(50)
);
SET datestyle = 'ISO, MDY';
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(customerid) AS null_customers,
    COUNT(*) - COUNT(description) AS null_descriptions,
    SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END) AS negative_qty,
    SUM(CASE WHEN invoiceno LIKE 'C%' THEN 1 ELSE 0 END) AS cancellations,
    SUM(CASE WHEN unitprice <= 0 THEN 1 ELSE 0 END) AS zero_price,
    SUM(CASE WHEN country = 'Unspecified' THEN 1 ELSE 0 END) AS unspecified_country
FROM raw_sale;

CREATE TABLE clean_sales AS
SELECT *
FROM raw_sale
WHERE customerid IS NOT NULL
  AND quantity > 0
  AND unitprice > 0
  AND invoiceno NOT LIKE 'C%'
  AND country != 'Unspecified'
  AND description IS NOT NULL;

SELECT COUNT(*) FROM clean_sales;

1-Total Revenue
SELECT
ROUND(SUM(quantity*unitprice),2) AS total_revenue
FROM clean_sales;

2-Top 10 countries by Revenue
SELECT country,ROUND(SUM(quantity* unitprice),2) AS revenue
FROM clean_sales
GROUP BY country
ORDER BY revenue DESC
LIMIT 10 ;

3-Top 10 Product by Revenue
SELECT description,ROUND(SUM(quantity* unitprice),2) AS revenue
FROM clean_sales
GROUP BY description
ORDER BY revenue DESC
LIMIT 10 ;

4-Monthly revenue trend 
SELECT 
    TO_CHAR(invoicedate, 'YYYY-MM') AS month,
    ROUND(SUM(quantity * unitprice), 2) AS revenue
FROM clean_sales
GROUP BY month
ORDER BY month;

5-Customer-Wise Revenue
SELECT customerid,
ROUND(SUM(quantity*unitprice),2) AS monetary,
COUNT(DISTINCT invoiceno) AS frequency,
 MAX(invoicedate) AS last_purchase,
 (DATE '2011-12-10' - MAX(invoicedate)::date) AS recency_days
FROM clean_sales
GROUP BY customerid
ORDER BY monetary DESC
LIMIT 10;

6-RFM scores

WITH rfm_base AS (
    SELECT 
        customerid,
        ROUND(SUM(quantity * unitprice)::numeric, 2) AS monetary,
        COUNT(DISTINCT invoiceno) AS frequency,
        (DATE '2011-12-10' - MAX(invoicedate)::date) AS recency_days
    FROM clean_sales
    GROUP BY customerid
),
rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_base
)
SELECT *,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'VIP'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customer'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Potential'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC;

7- Segment 

WITH rfm_base AS (
    SELECT 
        customerid,
        ROUND(SUM(quantity * unitprice)::numeric, 2) AS monetary,
        COUNT(DISTINCT invoiceno) AS frequency,
        (DATE '2011-12-10' - MAX(invoicedate)::date) AS recency_days
    FROM clean_sales
    GROUP BY customerid
),
rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_base
)
SELECT 
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'VIP'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customer'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Potential'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(monetary)::numeric, 2) AS avg_revenue
FROM rfm_scores
GROUP BY customer_segment
ORDER BY total_customers DESC;