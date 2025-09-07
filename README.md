📝 Overview

RFM segmentation is a popular customer analytics technique that classifies customers based on:

Recency (R): How recently a customer made a purchase

Frequency (F): How often they purchase

Monetary (M): How much they spend

The goal is to group customers into actionable segments like Champions, Loyal Customers, At Risk, and Lost Customers, helping businesses make data-driven marketing and retention decisions.

⚙️ Tech Stack

SQL: Used to clean, transform, and calculate RFM scores from the raw sales data.

Power BI: Used to create interactive dashboards for customer segmentation insights.

🧩 SQL Workflow

The SQL script performs the following steps:

Data Preparation: Loads and queries sales_data.

CLV Calculation: Computes Recency, Frequency, and Monetary values per customer.

RFM Scoring: Assigns R, F, and M scores using NTILE(5) for quintile ranking.

Segmentation: Categorizes customers into groups like Champions, Loyal Customers, At Risk, etc.

Example snippet from the SQL file:

NTILE(5) OVER (ORDER BY RECENCY_VALUE DESC) AS R_Score,
NTILE(5) OVER (ORDER BY FREQUENCY_VALUE ASC) AS F_Score,
NTILE(5) OVER (ORDER BY MONETARY_VALUE ASC) AS M_Score

📊 Power BI Dashboard

The Power BI report provides:

Customer Segmentation Overview: Distribution of customers across RFM segments

Sales Analysis: Total sales, average sales, and quantity ordered per segment

Drilldowns: Ability to explore customer-level details for deeper insights

🚀 How to Run

SQL Setup:

Import your sales dataset into a database (MySQL used in this project).

Run the SQL script RFM Segmentation.sql to create the RFM view and segmentation results.

Power BI Setup:

Open RFM Segmentation.pbix in Power BI Desktop.

Update the data source settings to point to your database (if using a different environment).

Refresh the data to load the latest segmentation results.

🔑 Key Customer Segments
Segment	Description
Champions	Recent, frequent, and high spenders
Loyal Customers	Regular buyers with high engagement
Promising	New or growing customers
At Risk	Customers whose activity is declining
Lost Customers	Inactive for a long time
📈 Insights & Use Cases

Identify high-value customers for loyalty programs

Target at-risk customers with re-engagement campaigns

Prioritize marketing spend on the most profitable segments

Monitor customer churn trends over time
