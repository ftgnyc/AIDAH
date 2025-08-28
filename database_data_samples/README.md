# AIDAH - Database Data Samples 📊

This folder contains SQL scripts to populate the BigQuery tables with sample data.

### 📁 Content

- `load_data.sql`: This file contains a series of `INSERT` statements to populate the following tables in the `aidah` dataset:
  - `dim_users`
  - `dim_institutions`
  - `dim_agreements`
  - `dim_degree_programs`
  - `dim_courses`
  - `dim_semesters`
  - `fact_user_events`
  - `fact_grades`

### 🚀 How to Use

1.  **Open BigQuery Studio**: Navigate to your BigQuery project in the Google Cloud Console.
2.  **Create a New Query**: Click "Compose new query".
3.  **Copy and Paste**: Copy the entire content from the `load_data.sql` file.
4.  **Execute**: Run the query. The data will be inserted into the corresponding tables in your `aidah` dataset.

> **Note**: This script is intended for **initial setup and populating empty tables**. Do not run it on production data, as it will insert duplicate rows.
