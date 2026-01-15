# TechCorp Retail Database Schema Documentation

This document provides a detailed overview of the database tables, column descriptions, and dataset characteristics for the TechCorp Retail project.

## Table: `customers`

**Description:** Stores personal and contact information for all registered customers.

**Dataset Stats:** 105 rows, 6 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `customer_id` | Integer | Unique identifier for the customer (Primary Key). |
| `first_name` | String/Text | First name of the individual. |
| `last_name` | String/Text | Last name of the individual. |
| `email` | String/Text | Contact email address. |
| `phone` | String/Text | Contact phone number. |
| `address` | String/Text | Physical mailing address. |

---

## Table: `employees`

**Description:** Contains records of company employees, including their roles and contact details.

**Dataset Stats:** 20 rows, 7 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `employee_id` | Integer | Unique identifier for the employee (Primary Key). |
| `first_name` | String/Text | First name of the individual. |
| `last_name` | String/Text | Last name of the individual. |
| `email` | String/Text | Contact email address. |
| `phone` | String/Text | Contact phone number. |
| `hire_date` | String/Text | Date when the employee was hired. |
| `department` | String/Text | Department where the employee works. |

---

## Table: `orderdetails`

**Description:** Detailed breakdown of items within each order, linking products to orders.

**Dataset Stats:** 518 rows, 5 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `order_detail_id` | Integer | Unique identifier for the order line item (Primary Key). |
| `order_id` | Integer | Unique identifier for the order (Primary Key). |
| `product_id` | Integer | Foreign key linking to the Products table. |
| `quantity` | Integer | Number of units purchased. |
| `unit_price` | Decimal/Float | Price per unit at the time of purchase. |

---

## Table: `orders`

**Description:** Tracks high-level order information such as dates and total amounts per customer transaction.

**Dataset Stats:** 507 rows, 4 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `order_id` | Integer | Unique identifier for the order (Primary Key). |
| `customer_id` | Integer | Unique identifier for the customer (Primary Key). |
| `order_date` | String/Text | Date when the order was placed. |
| `total_amount` | Decimal/Float | Total monetary value of the order. |

---

## Table: `products`

**Description:** Catalog of items available for sale, including pricing, categories, and stock levels.

**Dataset Stats:** 355 rows, 6 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `product_id` | Integer | Foreign key linking to the Products table. |
| `product_name` | String/Text | Name of the product. |
| `category` | String/Text | Product category (e.g., Electronics, Accessories). |
| `price` | Decimal/Float | Current list price of the product. |
| `stock_quantity` | Integer | Current number of units in stock. |
| `discount` | Decimal/Float | Applicable discount percentage or amount. |

---

## Table: `supporttickets`

**Description:** Log of customer support requests, their status, and resolution times.

**Dataset Stats:** 63 rows, 7 columns

### Column Descriptions
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `ticket_id` | Integer | Unique identifier for the support ticket (Primary Key). |
| `customer_id` | Integer | Unique identifier for the customer (Primary Key). |
| `employee_id` | Integer | Unique identifier for the employee (Primary Key). |
| `issue` | String/Text | Description of the customer's issue. |
| `status` | String/Text | Current status of the ticket (e.g., open, resolved). |
| `created_at` | String/Text | Timestamp when the ticket was created. |
| `resolved_at` | String/Text | Timestamp when the ticket was resolved. |
