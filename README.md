# TechCorp Retail Data Analysis
This project is a comprehensive SQL-based data analysis of **TechCorp**, a fictional retail company selling electronics and gadgets. 

The primary objective of this project is to simulate a real-world database environment to answer critical business questions. By executing **complex SQL queries** (including CTEs, Subqueries, Joins, and Aggregations), this project derives actionable insights regarding customer behavior, product performance, and employee efficiency.

### Key Objectives:
- **Database Management:** Designing a relational schema with proper Primary and Foreign Keys.
- **Data Cleaning:** Handling raw data imports and ensuring data integrity.  
- **Business Intelligence:** Solving **8 key business problems** to aid decision-making.

## Database Schema & Table Overview

The database consists of 6 relational tables containing data on sales, inventory, and support.

![EER DIAGRAM](https://github.com/nindykaro/techcorp-retail-sql-analysis/raw/main/EER%20Diagram.png
)  
_diagram1. EER Diagram from MySQL Workbench_

## Table Dictionary
| Table Name      | Description                                      | Key Columns                                   |
|-----------------|--------------------------------------------------|-----------------------------------------------|
| products        | Catalog of items, prices, and stock levels.      | product_id, category, price, stock_quantity  |
| customers       | Personal data of registered clients.             | customer_id, first_name, email, address      |
| orders          | Header information for every transaction.        | order_id, customer_id, order_date, total_amount |
| orderdetails    | Line-item specific data (SKUs per order).        | order_detail_id, product_id, quantity, unit_price |
| employees       | Internal staff data and departments.             | employee_id, department, hire_date           |
| supporttickets  | Log of customer complaints and resolutions.      | ticket_id, status, created_at, resolved_at   |

---

## Business Questions & SQL Solutions
I analyzed the dataset to answer 8 specific business questions. Below are the queries used to derive these insights.

### 1. Identify the Top 3 VIP Customers
Goal: Find the top 3 customers by total spending to target them for exclusive loyalty rewards.

```sql
SELECT
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;
```

### 2. Analyze Customer Average Order Value (AOV)
Goal: Determine the average spending behavior per customer to adjust marketing strategies.

```sql
SELECT
    c.first_name,
    c.last_name,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY avg_order_value DESC;
```

### 3. Employee Performance Review
Goal: List employees who have successfully resolved more than 4 support tickets.

```sql
SELECT 
    e.first_name,
    e.last_name,
    e.department,
    COUNT(s.ticket_id) AS resolved_tickets
FROM employees e
JOIN supporttickets s ON s.employee_id = e.employee_id
WHERE s.status = 'resolved'
GROUP BY e.employee_id
HAVING resolved_tickets >= 4;
```

### 4. Identify "Dead Stock" (Unsold Products)
Goal: Find products that have never been ordered to clear inventory.

```sql
SELECT
    p.product_name,
    p.category,
    p.price
FROM products p
LEFT JOIN orderdetails od ON od.product_id = p.product_id
WHERE od.order_id IS NULL
GROUP BY p.product_id;
```

### 5. Calculate Total Gross Revenue
Goal: Verify financial records by calculating total revenue from line items.

```sql
SELECT SUM(quantity * unit_price) AS total_revenue
FROM orderdetails;
```

### 6. High-End Product Categories (Using CTE)
Goal: Identify which categories have an average product price exceeding $500.

```sql
WITH CategoryStats AS (
    SELECT
        category,
        AVG(price) AS avg_price
    FROM products
    GROUP BY category
)
SELECT * FROM CategoryStats WHERE avg_price > 500;
```

### 7. High-Value Transaction Hunt (Using Subquery)
Goal: Find all customers who have made at least one single purchase worth over $1,000.

```sql
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 1000
);
```

### 8. Most Popular Product Category by Volume
Goal: Determine which product category sells the highest quantity of units.

```sql
SELECT 
    p.category, 
    SUM(od.quantity) as total_units_sold
FROM orderdetails od
JOIN products p ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_units_sold DESC
LIMIT 1;
```

---

## Installation & Usage
1. Clone the Repo:
```Bash
git clone [https://github.com/nindykaro/techcorp-retail-sql-analysis.git](https://github.com/nindykaro/techcorp-retail-sql-analysis.git)
```

2. Import Data:
- Open MySQL Workbench (or your preferred SQL tool).
- Run the script.sql to set up the schema.
- Import the CSV files located in the data folder using the Table Data Import Wizard.

## Future Improvements
Visualization: Connect this database to Tableau or PowerBI to visualize the "Dead Stock" vs. "Top Sellers".
Automation: Create Stored Procedures to automatically update VIP lists every month.

Created by [nindykarona] | Data Analysis Portfolio
