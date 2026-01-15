/* =========================================================
  PROJECT: TechCorp Retail Data Analysis
  AUTHOR: [Your Name]
  DESCRIPTION: 
  This script analyzes sales, customer behavior, and 
  employee performance for TechCorp.
  
  DATABASE STRUCTURE:
  - customers, products, orders, orderdetails
  - employees, supporttickets
=========================================================
*/

-- ======================================================
-- SECTION 1: DATABASE SETUP & VALIDATION
-- ======================================================

-- 1. Initialize Database
-- CREATE DATABASE techcorp_retail; -- Uncomment if creating fresh
USE techcorp_retail;

-- 2. Verify Data Import (Quick Audit)
SHOW TABLES FROM techcorp_retail;

-- Check first rows of key tables to ensure data integrity
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM employees;
SELECT * FROM supporttickets;

-- 3. Verify Data Types (Schema Check)
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE orderdetails;
DESCRIBE orders;
DESCRIBE products;
DESCRIBE supporttickets;

-- ======================================================
-- SECTION 2: DATA INTEGRITY (KEY ASSIGNMENTS)
-- Objective: Establish relationships between tables (PK/FK)
-- ======================================================

/* NOTE: Run these commands only once after importing raw data.
*/

-- A. Set Primary Keys (Unique Identifiers)
ALTER TABLE products ADD PRIMARY KEY (product_id);
ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE employees ADD PRIMARY KEY (employee_id);

-- B. Set Relationships (Foreign Keys) for Orders
ALTER TABLE orders
ADD PRIMARY KEY (order_id),
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- C. Set Relationships for Order Details
ALTER TABLE orderdetails
ADD PRIMARY KEY (order_detail_id),
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id),
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- D. Set Relationships for Support Tickets
ALTER TABLE supporttickets
ADD PRIMARY KEY (ticket_id),
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

-- ======================================================
-- SECTION 3: DATA ANALYSIS (CASE STUDIES)
-- ======================================================

/* CASE 1: IDENTIFY TOP VIP CUSTOMERS
  Objective: Find the top 3 customers who have generated the 
  most revenue to target them for loyalty rewards.
*/
SELECT
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_order_amount
FROM customers AS c
JOIN orders AS o 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_order_amount DESC
LIMIT 3;


/* CASE 2: CUSTOMER SPENDING HABITS
  Objective: Calculate the average order value (AOV) for each 
  customer to understand spending patterns.
*/
SELECT
    c.first_name,
    c.last_name,
    ROUND(AVG(o.total_amount), 2) AS avg_total_amount
FROM customers AS c
JOIN orders AS o 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY avg_total_amount DESC;


/* CASE 3: EMPLOYEE PERFORMANCE REVIEW
  Objective: List employees who are performing exceptionally well 
  by resolving more than 4 support tickets.
*/
SELECT 
    e.first_name,
    e.last_name,
    e.department,
    COUNT(s.ticket_id) AS resolved_issues
FROM employees AS e
JOIN supporttickets AS s 
    ON s.employee_id = e.employee_id
WHERE s.status = 'resolved'
GROUP BY e.employee_id
HAVING resolved_issues >= 4;


/* CASE 4: INVENTORY MANAGEMENT (DEAD STOCK)
  Objective: Identify products that have never been sold 
  so we can consider discounting or removing them.
*/
SELECT
    p.product_name,
    p.category,
    p.price
FROM products AS p
LEFT JOIN orderdetails AS od 
    ON od.product_id = p.product_id
WHERE od.order_id IS NULL -- Finds rows where no match exists
GROUP BY p.product_id;


/* CASE 5: REVENUE CALCULATION
  Objective: Calculate the exact total gross revenue generated 
  from all product sales items.
*/
SELECT
    SUM(quantity * unit_price) AS total_sales_revenue
FROM orderdetails;


/* CASE 6: PRICING STRATEGY ANALYSIS (CTE)
  Objective: Find product categories where the average item 
  price is above $500 (High-End Categories).
*/
WITH CategoryStats AS (
    SELECT
        category,
        AVG(price) AS avg_price
    FROM products
    GROUP BY category
)
SELECT * FROM CategoryStats 
WHERE avg_price > 500;


/* CASE 7: HIGH-VALUE TRANSACTION HUNT
  Objective: Find customers who have placed at least one single order 
  worth more than $1,000.
*/

-- Approach A: Using Standard JOIN
SELECT
    c.first_name,
    c.last_name,
    c.customer_id,
    o.total_amount
FROM customers AS c
JOIN orders AS o 
    ON o.customer_id = c.customer_id
WHERE o.total_amount >= 1000;

-- Approach B: Using Subquery (Cleaner for filtering)
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 1000
);