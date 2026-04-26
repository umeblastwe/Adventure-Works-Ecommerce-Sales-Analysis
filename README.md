# Adventure-Works-Ecommerce-Sales-Analysis
This project performs a deep dive into the AdventureWorks DW (Data Warehouse) to extract actionable business intelligence. The analysis focuses on three core pillars: Sales Performance, Product Hierarchy, and Customer Retention.
I took the classic AdventureWorks dataset and moved beyond simple SELECT * statements to find the actual stories in the data. This project is all about answering real business questions using SQL.

### Preview:
<img width="988" height="595" alt="Screenshot 1" src="https://github.com/user-attachments/assets/0dadb1fd-3da3-4af4-bb9b-e55676b33931" />
<img width="1020" height="546" alt="Screenshot 2" src="https://github.com/user-attachments/assets/acefc496-6336-49fd-9e1e-f17313ccb401" />
<img width="1022" height="582" alt="Screenshot 3" src="https://github.com/user-attachments/assets/409bf89b-ef21-4679-ab20-258c8b294d20" />
<img width="1024" height="697" alt="Screenshot 4" src="https://github.com/user-attachments/assets/58d6460d-0996-4165-921b-86b329532c01" />



### What I Answered:
Who are our VIPs? Found the top 5 customers by total spend.

What's actually selling? Ranked the top 10 products and their % share of total revenue.

Are we growing? Calculated Month-over-Month (MoM) growth rates to spot trends.

Are customers coming back? Built logic to separate "New" vs. "Repeat" buyers to check business health.

🛠️ The "Techy" Side:
To get these answers, I used:

CTEs for clean, readable code.

Window Functions (DENSE_RANK, LAG, OVER) for complex rankings and growth logic.

Joins across Fact and Dimension tables to connect sales with geography and dates.
