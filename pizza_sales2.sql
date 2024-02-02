USE pizzadb;

SELECT * FROM pizza_sales LIMIT 5;


-- 1. DAILY TRENDS FOR TOTAL ORDERS
SELECT DAYNAME(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d')) AS ORDER_DAY, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY ORDER_DAY
ORDER BY TOTAL_ORDERS DESC;


-- MONTHLY TRENDS FOR TOTAL ORDERS
SELECT MONTHNAME(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d')) AS ORDER_MONTH, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES 
GROUP BY ORDER_MONTH
ORDER BY TOTAL_ORDERS DESC; 

-- 2. HOURLY TRENDS FOR TOTAL_ORDERS
SELECT HOUR(ORDER_TIME) AS SALE_HOUR,PIZZA_CATEGORY,COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY SALE_HOUR,PIZZA_CATEGORY
ORDER BY TOTAL_ORDERS DESC;


-- 3. PERCENTAGE OF SALES BY PIZZA_CATEGORY
SELECT PIZZA_CATEGORY,
		SUM(TOTAL_PRICE) AS TOTAL_SALES,
		SUM(TOTAL_PRICE)*100/(SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES) AS PCT
FROM PIZZA_SALES
GROUP BY PIZZA_CATEGORY
ORDER BY PCT DESC;

-- FILTER DATA BY MONTH
SELECT PIZZA_CATEGORY,
		CAST(SUM(TOTAL_PRICE) AS DECIMAL(10,2)) AS TOTAL_SALES,
		CAST(SUM(TOTAL_PRICE)*100/(SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES WHERE MONTH(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d'))=1) AS DECIMAL(10,2)) AS PCT
FROM PIZZA_SALES
WHERE MONTH(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d'))=1
GROUP BY PIZZA_CATEGORY
ORDER BY PCT DESC;


-- 4. PERCENTAGE OF SALES BY PIZZA_SIZE
SELECT PIZZA_SIZE,
		SUM(TOTAL_PRICE) AS TOTAL_SALES,
		SUM(TOTAL_PRICE)*100/(SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES) AS PCT
FROM PIZZA_SALES
GROUP BY PIZZA_SIZE
ORDER BY PCT DESC;

-- FILTER DATA BY QUARTER
SELECT PIZZA_SIZE,
		CAST(SUM(TOTAL_PRICE) AS DECIMAL(10,2)) AS TOTAL_SALES,
		CAST(SUM(TOTAL_PRICE)*100/(SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES WHERE QUARTER(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d'))=1) AS DECIMAL(10,2)) AS PCT
FROM PIZZA_SALES
WHERE QUARTER(STR_TO_DATE(ORDER_DATE, '%Y-%m-%d'))=1
GROUP BY PIZZA_SIZE
ORDER BY PCT DESC;

-- 5. TOTAL PIZZAS SOLD BY PIZZA_CATEGORY
SELECT PIZZA_CATEGORY,COUNT(QUANTITY) AS TOTAL_PIZZAS
FROM PIZZA_SALES
GROUP BY PIZZA_CATEGORY
ORDER BY TOTAL_PIZZAS DESC;


-- 6. TOP 5 BEST SELLERS BY REVENUE
SELECT PIZZA_NAME,SUM(TOTAL_PRICE) AS TOTAL_REVENUE 
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

-- 7. TOP 5 WORST SELLERS BY REVENUE
SELECT PIZZA_NAME,SUM(TOTAL_PRICE) AS TOTAL_REVENUE 
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE ASC
LIMIT 5;


-- 8. TOP 5 BEST SELLERS BY QUANTITY
SELECT PIZZA_NAME,SUM(QUANTITY) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY DESC
LIMIT 5;

-- 9. TOP 5 WORST SELLERS BY QUANTITY
SELECT PIZZA_NAME,SUM(QUANTITY) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY ASC
LIMIT 5;

-- 10. TOP 5 BEST SELLERS BY TOTAL ORDERS
SELECT PIZZA_NAME,COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS DESC
LIMIT 5;

-- 11. TOP 5 WORST SELLERS BY TOTAL ORDERS
SELECT PIZZA_NAME,COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS ASC
LIMIT 5;





