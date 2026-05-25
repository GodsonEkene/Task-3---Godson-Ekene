SELECT *
FROM Task3
;



-- SALES TREND OVER TIME
-- How did sales perform over time?

SELECT YEAR(Date) AS Order_Year,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM Task3
WHERE OrderStatus = 'Delivered' -- we are filtering because we are only looking at completed orders
GROUP BY YEAR(Date)
;

SELECT MONTH(Date) AS Order_Month,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM Task3
GROUP BY MONTH(Date)
ORDER BY Order_Month ASC
;

-- How did quantity sold change over time?

SELECT YEAR(Date) AS Order_Year,
	SUM(Quantity) AS Total_Quantity
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY YEAR(Date)
;

SELECT 
	MONTH(Date) AS Order_Month,
	SUM(Quantity) AS Total_Quantity
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY MONTH(Date)
ORDER BY Order_Month ASC
;

-- Which products generated the highest revenue?

SELECT 
	Product,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY Product
;

-- BEST SELLING PRODUCTS

SELECT TOP 1
	Product,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY Product
ORDER BY Total_Sales DESC
;


-- Which payment method generated the most revenue?

SELECT 
	PaymentMethod,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY PaymentMethod
ORDER BY Total_Sales DESC
;

-- How did customer purchasing behavior change over time?

WITH Sales AS (
SELECT 
	YEAR(Date) AS Order_Year,
	COUNT(DISTINCT CustomerID) AS Total_Customer,
	ROUND(SUM(TotalPrice), 2) AS Total_Sales,
	SUM(Quantity) AS Total_Qty_Sold
FROM Task3
WHERE OrderStatus = 'Delivered'
GROUP BY YEAR(Date)
)
SELECT *,
	ROUND((Total_Sales / Total_Customer), 2) AS Avg_TotalSales_Per_Ctmer,
	(Total_Qty_Sold / Total_Customer)  AS Avg_Qty_Per_Ctmer
FROM Sales
;

-- What was the distribution of order statuses?

SELECT
	OrderStatus,
	COUNT(OrderID) OrderStatus_Count
FROM Task3
GROUP BY OrderStatus
ORDER BY OrderStatus_Count DESC
;