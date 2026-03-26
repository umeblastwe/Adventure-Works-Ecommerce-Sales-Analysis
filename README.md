# Adventure-Works-Ecommerce-Sales-Analysis
This project performs a deep dive into the AdventureWorks DW (Data Warehouse) to extract actionable business intelligence. The analysis focuses on three core pillars: Sales Performance, Product Hierarchy, and Customer Retention.
I took the classic AdventureWorks dataset and moved beyond simple SELECT * statements to find the actual stories in the data. This project is all about answering real business questions using SQL.

What I Answered:
Who are our VIPs? Found the top 5 customers by total spend.

What's actually selling? Ranked the top 10 products and their % share of total revenue.

Are we growing? Calculated Month-over-Month (MoM) growth rates to spot trends.

Are customers coming back? Built logic to separate "New" vs. "Repeat" buyers to check business health.

🛠️ The "Techy" Side:
To get these answers, I used:

CTEs for clean, readable code.

Window Functions (DENSE_RANK, LAG, OVER) for complex rankings and growth logic.

Joins across Fact and Dimension tables to connect sales with geography and dates.
