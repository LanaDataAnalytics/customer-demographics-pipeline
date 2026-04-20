# EDA [Customer demographics pipeline]
End-to-end SQL pipeline and EDA dashboard for customer demographics

## Project Objective
Engineered a secure, multi-tier SQL data pipeline to ingest, clean, and standardize 50,000+ raw demographic records, establishing a Single Source of Truth (SSOT) to power regional Exploratory Data Analysis (EDA) and VIP segmentation in Power BI and Tableau.

## Tech Stack
* **Database & Transformation:** SQL (BigQuery/PostgreSQL)
* **Visualization:** Tableau, Power BI
* **Techniques:** PII Cryptographic Hashing, Window Functions, Geospatial Validation, Anomaly Detection

## Pipeline Architecture
1. **Raw Data:** Unstandardized text, missing demographic variables, and unhashed PII.
2. **Staging Layer (Data Cleaning & Security):** Standardized casing (`TRIM(LOWER())`), validated geospatial coordinates (removing "Null Island" artifacts), and secured user identities using deterministic one-way hashing (`FARM_FINGERPRINT`).
3. **Data Mart (Business Logic):** Engineered custom categories utilizing robust `CASE WHEN` bounding logic (`>=`, `<=`) to segment VIPs and isolate data quality anomalies (e.g., Title/Gender mismatch detection).
4. **BI & Analytics Layer:** Replaced computationally expensive `JOIN` operations with set-based Window Functions (`OVER(PARTITION BY)`) to calculate regional part-to-whole percentages in a single database pass before exporting to BI tools.

## Dashboard Previews
*(Insert your high-res screenshots here)*
![Global VIP Map](./dashboards/Global_VIP_Map.png)
![Demographic Target Matrix](./dashboards/Target_Matrix.png)

## Code Highlights
Feel free to explore the `/sql_pipeline` folder to see the underlying architecture:
* [Staging & Anonymization](./sql_pipeline/01_staging_and_anonymization.sql)
* [Data Quality Auditing](./sql_pipeline/03_data_quality_audit.sql)
