
-- SQL QUERIES FOR SALES PERFORMANCE DASHBOARD
-- ============================================

-- 1. TOTAL SALES AND PROFIT BY MONTH
SELECT 
    DATE_TRUNC('month', Order_Date) AS Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percent
FROM sales_data
GROUP BY DATE_TRUNC('month', Order_Date)
ORDER BY Month DESC;

-- 2. TOP 10 PRODUCTS BY PROFIT
SELECT 
    Sub_Category AS Product,
    Category,
    COUNT(Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Avg_Profit_Per_Order
FROM sales_data
GROUP BY Sub_Category, Category
ORDER BY Total_Profit DESC
LIMIT 10;

-- 3. REGIONAL PERFORMANCE ANALYSIS
SELECT 
    Region,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percent,
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 4. CUSTOMER SEGMENT ANALYSIS
SELECT 
    Segment,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- 5. CATEGORY PERFORMANCE
SELECT 
    Category,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Quantity) AS Units_Sold,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percent
FROM sales_data
GROUP BY Category
ORDER BY Total_Profit DESC;

-- 6. DISCOUNT IMPACT ON PROFITABILITY
SELECT 
    Discount,
    COUNT(Order_ID) AS Order_Count,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Avg_Profit_Per_Order,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percent
FROM sales_data
GROUP BY Discount
ORDER BY Discount;

-- 7. TOP 20 CUSTOMERS BY REVENUE
SELECT 
    Customer_ID,
    Customer_Name,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 20;

-- 8. YEAR-OVER-YEAR GROWTH ANALYSIS
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY EXTRACT(YEAR FROM Order_Date)
ORDER BY Year;

-- 9. SHIPPING MODE ANALYSIS
SELECT 
    Ship_Mode,
    COUNT(Order_ID) AS Order_Count,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Ship_Mode
ORDER BY Order_Count DESC;

-- 10. MONTHLY TRENDS WITH RUNNING TOTALS
SELECT 
    DATE_TRUNC('month', Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(Profit) AS Monthly_Profit,
    SUM(SUM(Sales)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)) AS Cumulative_Sales,
    SUM(SUM(Profit)) OVER (ORDER BY DATE_TRUNC('month', Order_Date)) AS Cumulative_Profit
FROM sales_data
GROUP BY DATE_TRUNC('month', Order_Date)
ORDER BY Month;
