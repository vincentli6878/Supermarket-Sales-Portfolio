-- Do members spend more than non-members to help improve membership benefits?
SELECT branch, customer_type, ROUND(AVG(total), 2) AS avg_sales
FROM sales
GROUP BY branch, customer_type
ORDER BY branch, customer_type;

--When should we target promotions/marketing based on months?
SELECT branch,
	TO_CHAR(date, 'Month') AS month,
    customer_type,
    COUNT(*) AS customer_count
FROM 
    sales
GROUP BY
	branch,
	month, 
    EXTRACT(MONTH FROM date),
    customer_type
ORDER BY
	branch,
	EXTRACT(MONTH FROM date),
    customer_type;

--Customer Demographic Makeup
WITH female_member AS (
    SELECT gender, customer_type, COUNT(*) AS count
    FROM sales
    WHERE gender = 'Female' AND customer_type = 'Member'
    GROUP BY gender, customer_type
),
female_normal AS (
    SELECT gender, customer_type, COUNT(*) AS count
    FROM sales
    WHERE gender = 'Female' AND customer_type = 'Normal'
    GROUP BY gender, customer_type
),
male_member AS (
    SELECT gender, customer_type, COUNT(*) AS count
    FROM sales
    WHERE gender = 'Male' AND customer_type = 'Member'
    GROUP BY gender, customer_type
),
male_normal AS (
    SELECT gender, customer_type, COUNT(*) AS count
    FROM sales
    WHERE gender = 'Male' AND customer_type = 'Normal'
    GROUP BY gender, customer_type
)
SELECT * FROM female_member
UNION ALL
SELECT * FROM female_normal
UNION ALL
SELECT * FROM male_member
UNION ALL
SELECT * FROM male_normal;

--Most Popular Payment Types
SELECT payment, COUNT(*) AS count
FROM sales
GROUP BY payment;

--which time periods are the busiest/slowest to schedule breaks?
SELECT branch, EXTRACT(HOUR FROM time) AS hour, ROUND(AVG(total),2) AS avg_sales
FROM sales
GROUP BY branch, EXTRACT(HOUR FROM time)
ORDER BY branch, EXTRACT(HOUR FROM time);

--which days of the week are the busiest/slowest to schedule staffing?
SELECT branch,
    TO_CHAR(date, 'Day') AS dow, 
    ROUND(AVG(total),2) AS total_sales
FROM 
    sales
GROUP BY
    branch, TO_CHAR(date, 'Day'), EXTRACT(DOW FROM date)
ORDER BY branch,
 	EXTRACT(DOW FROM date);

--which time periods has the most quantity sold and with which products to help with restock?
SELECT branch, product_line, 
EXTRACT(HOUR FROM time) AS hour, SUM(quantity) AS quantity_sold 
FROM sales
GROUP BY branch, product_line, EXTRACT(HOUR FROM time)
ORDER BY branch, EXTRACT(HOUR FROM time);

--which dates/days has the most quantity sold and with which products to help with ordering shipment?
SELECT branch,
       product_line,
       date,
       SUM(quantity) AS quantity_sold
FROM sales
GROUP BY branch, product_line, date
ORDER BY branch, date;

--Top Products Makeup
SELECT product_line, SUM(total)
FROM sales
GROUP BY product_line;

--which time periods has the best/worst rating to improve customer service
SELECT branch, 
EXTRACT(HOUR FROM time) AS hour, ROUND(AVG(rating),1) AS avg_rating
FROM sales 
GROUP BY branch, EXTRACT(HOUR FROM time)
ORDER BY branch, EXTRACT(HOUR FROM time);

--how does average ratings impact total sales to better improve customer service?
SELECT branch, date, ROUND(AVG(rating), 2) AS avg_rating,
SUM(total) AS total_sales
FROM sales
GROUP BY branch, date
ORDER BY branch, date;

--what are the average ratings across the different supermarkets
SELECT branch, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY branch;


