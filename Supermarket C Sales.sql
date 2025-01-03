-- Do members spend more than non-members to help improve membership benefits?
SELECT customer_type, ROUND(AVG(total),2) AS avg_sales
FROM sales
WHERE branch = 'C'
GROUP BY branch, customer_type;

--When should we target promotions/marketing based on months?
SELECT
	TO_CHAR(date, 'Month') AS month,
    customer_type,
    COUNT(*) AS customer_count
FROM 
    sales
WHERE branch = 'C'
GROUP BY 
	month, 
    EXTRACT(MONTH FROM date),
    customer_type
ORDER BY 
	EXTRACT(MONTH FROM date),
    customer_type;

--which time periods are the busiest/slowest to schedule breaks?
SELECT EXTRACT(HOUR FROM time) AS hour, ROUND(AVG(total),2) AS avg_sales
FROM sales
WHERE branch = 'C'
GROUP BY EXTRACT(HOUR FROM time)
ORDER BY EXTRACT(HOUR FROM time);

--which days of the week are the busiest/slowest to schedule staffing?
SELECT
    TO_CHAR(date, 'Day') AS dow, 
    ROUND(AVG(total),2) AS total_sales
FROM 
    sales
WHERE branch = 'C'
GROUP BY
    TO_CHAR(date, 'Day'), EXTRACT(DOW FROM date)
ORDER BY 
 	EXTRACT(DOW FROM date);

--which time periods has the most quantity sold and with which products to help with restock?
SELECT product_line, 
EXTRACT(HOUR FROM time) AS hour, SUM(quantity) AS quantity_sold 
FROM sales 
WHERE branch = 'C'
GROUP BY product_line, EXTRACT(HOUR FROM time)
ORDER BY EXTRACT(HOUR FROM time);

--which dow has the most quantity sold and with which products to help with ordering shipment?
SELECT
	product_line,
    TO_CHAR(date, 'Day') AS dow, 
    SUM(quantity) AS quantity_sold
FROM 
    sales
WHERE branch = 'C'
GROUP BY product_line,
    	TO_CHAR(date, 'Day'), EXTRACT(DOW FROM date)
ORDER BY 
 	EXTRACT(DOW FROM date);


--which time periods has the best/worst rating to improve customer service
SELECT  
EXTRACT(HOUR FROM time) AS hour, ROUND(AVG(rating),1) AS avg_rating
FROM sales 
WHERE branch = 'C'
GROUP BY EXTRACT(HOUR FROM time)
ORDER BY EXTRACT(HOUR FROM time);

--which dow has the best/worst rating to improve customer service
SELECT
    TO_CHAR(date, 'Day') AS dow, 
    ROUND(AVG(rating),1) AS avg_rating
FROM 
    sales
WHERE branch = 'C'
GROUP BY
    TO_CHAR(date, 'Day'), EXTRACT(DOW FROM date)
ORDER BY 
 	EXTRACT(DOW FROM date);
