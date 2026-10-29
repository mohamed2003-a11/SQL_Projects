# SQL Projects & Analytics Portfolio

A collection of end-to-end SQL projects, data cleaning pipelines, exploratory data analysis, and relational database designs built using MySQL.

### 1. Data Cleaning Project (`Data_Cleaning_Project.sql`)
* **Dataset:** World Tech Layoffs dataset (`layoffs.csv`)
* **Key Tasks:** Removed duplicate rows using CTEs and `ROW_NUMBER()`, standardized text and date data types (`STR_TO_DATE`), populated missing/blank values via self-joins, and dropped irrelevant records/columns.

### 2. Exploratory Data Analysis (`Exploratory_Data_Analysis.sql`)
* **Objective:** Uncover key business insights and metrics from cleaned layoff data.
* **Key Analyses:** Computed rolling totals over time using Window Functions (`OVER`), aggregated total layoffs by company, industry, and country, and ranked top companies per year using `DENSE_RANK()`.

### 3. Core SQL Mastery Series
* **`SQL_Beginner.sql`:** Fundamentals covering `SELECT`, `WHERE`, filtering with `LIKE`, aggregate functions (`AVG`, `COUNT`), `GROUP BY`, `HAVING`, and sorting (`ORDER BY`).
* **`SQL_Intermediate.sql`:** Multi-table relational joins (`INNER`, `LEFT`, `RIGHT`), `UNION` operations, string functions (`TRIM`, `SUBSTRING`, `CONCAT`), conditional `CASE` statements, subqueries, and window ranking functions.
* **`SQL_Advanced.sql`:** Advanced querying patterns including Common Table Expressions (CTEs), nested CTEs, temporary tables (`CREATE TEMPORARY TABLE`), and stored procedures (`CREATE PROCEDURE`).

### 4. Car Insurance System (`SQL_Car_Insurance_Copmany/`)
* **Objective:** Database schema creation and management simulating a car insurance provider.
* **Features:** Relational design across customers, policies, vehicles, and claims with sample data insertion and XML/XSL data formatting.

---

## 🛠️ Tools & Technologies
* **Database:** MySQL Server / MySQL Workbench
* **Key Techniques:** CTEs, Window Functions, Data Cleaning, Stored Procedures, Aggregations & Joins
