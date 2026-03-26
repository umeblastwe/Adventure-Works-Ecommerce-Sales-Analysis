SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA, TABLE_NAME;

Select* from FactInternetSales
Select* from DimCustomer
Select* from dimgeography
Select * from dimdate
Select * from DimProduct

-- Top 10 Product By Sales

With top_10 as (
    Select
    p.Englishproductname, sum(f.salesamount) as total_sales
    From factinternetsales F
    join Dimproduct p on
    p.productkey = f.productkey
    Group by englishproductname
)
SELECT Top 10*
FROM Top_10
ORDER BY total_sales Desc

-- Top 5 customers spent the most

with top_10 as (
Select
c.firstname, c.lastname, Sum(f.salesamount) as total_sales_by_customer
From Factinternetsales f
join Dimcustomer c on
c.customerkey = f.customerkey
Group by firstname, lastname
)

Select Top 10 * from top_10
Order by total_sales_by_customer Desc

-- Total Revenue By country

with sales as (
    Select g.englishcountryname, sum(f.salesamount) as Total_sales
    From Factinternetsales f
    join dimcustomer c on 
    f.CustomerKey = c.CustomerKey
    join dimgeography on
    c.GeographyKey = g.GeographyKey
    group by englishcountryname
)
Select Top 10 * from sales
Order by Total_sales desc;

WITH sales AS (
    SELECT 
        g.EnglishCountryRegionName,
        SUM(f.SalesAmount) AS Total_sales
    FROM FactInternetSales f
    JOIN DimCustomer c 
        ON f.CustomerKey = c.CustomerKey
    JOIN DimGeography g 
        ON c.GeographyKey = g.GeographyKey
    GROUP BY g.EnglishCountryRegionName
)
SELECT TOP 10 *
FROM sales
ORDER BY Total_sales DESC;

-- Top 3 Products Rank By year

with sales as (
    select 
    d.Fiscalyear,
    p.englishproductname,
    sum(f.salesamount) as total_sales,
    Dense_rank () over (
        Partition by d.fiscalyear
        order by sum(f.salesamount) desc
        ) as rank_in_year
    From factinternetsales f
    join Dimproduct p on
    p.productkey = f.productkey
    join dimdate d on
    f.orderdatekey = d.datekey
    Group by d.fiscalyear,p.englishproductname
)
SELECT *
FROM sales
WHERE Rank_in_year <= 3
ORDER BY fiscalyear, rank_in_year;

-- Revenue Share in % Per Product

Select 
p.englishproductname,
(sum(f.salesamount) * 100 / sum(sum(f.salesamount)) over()) as revenue_percentage
From FactInternetSales f
join dimproduct p on
p.productkey = f.productkey
group by p.englishproductname
Order by revenue_percentage desc;

-- Monthly Growth rate Revenue

With sales as (
    Select
        CONVERT(nvarchar(7), f.Orderdate, 120) AS year_month,
        sum(f.salesamount) as current_month_sales,
        lag(sum(f.salesamount)) over (
            order by CONVERT(nvarchar(7), f.Orderdate, 120) ASC )
            as previous_month_sales 
    From factinternetsales f
     join DimCustomer c on
    f.CustomerKey = c.CustomerKey
    GROUP BY CONVERT(nvarchar(7), Orderdate, 120)
)
select
year_month,
current_month_sales,
previous_month_sales,
convert(decimal(10,2),(1.0 * (current_month_sales - previous_month_sales) 
    / (previous_month_sales) * 100)) AS monthly_percentage_change
FROM sales
ORDER BY year_month ASC;

-- Finding Repeat and Non Repeat Customers

WITH CustomerFirstDates AS (
    SELECT 
        f.CustomerKey,
        f.OrderDate,
        f.SalesAmount,
        MIN(f.OrderDate) OVER(PARTITION BY f.CustomerKey) AS FirstPurchaseDate
    FROM FactInternetSales f
),
TransactionTagging AS (
    SELECT 
        OrderDate,
        SalesAmount,
        CASE 
            WHEN OrderDate = FirstPurchaseDate THEN 'New'
            ELSE 'Repeat'
        END AS CustomerStatus
    FROM CustomerFirstDates
)
SELECT 
    CONVERT(nvarchar(7), OrderDate, 120) AS YearMonth, -- or CONVERT(nvarchar(7), OrderDate, 120)
    CustomerStatus,
    COUNT(*) AS TotalOrders,
    SUM(SalesAmount) AS TotalRevenue
FROM TransactionTagging
GROUP BY CONVERT(nvarchar(7), OrderDate, 120), CustomerStatus
ORDER BY YearMonth ASC, CustomerStatus DESC;
