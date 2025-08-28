# Scripts 💻

This folder contains Python scripts designed to interact with the project's data warehouse on BigQuery. These scripts serve as operational examples for data analysis and reporting.

### 📜 Script: `sample_queries.py`

The `sample_queries.py` script connects to BigQuery using the Python client library and executes a series of predefined queries. It's a simple example of how to automate data retrieval and display results directly in the terminal.

#### Query Objectives:

- **Enrollment Count by Institution**: Calculates the number of enrollments for both high school and college students, grouped by institution.
- **Expected Graduates in 2027**: Counts the unique number of students with an expected graduation date in the year 2027.
- **Students Who Passed in Spring Semesters**: Counts the unique number of students who received a passing grade (not 'F') in any 'Spring' semester.

### ⚙️ Prerequisites

To run this script, ensure you have the following:

-   A `.env` file in the project's root directory with the following variables:
    ```
    TF_VAR_project_id="your-gcp-project-id"
    TF_VAR_dataset_name="your-big-query-dataset-name"
    ```
-   The required Python libraries installed:
    ```bash
    pip install google-cloud-bigquery python-dotenv
    ```
-   Your Google Cloud credentials configured via `gcloud auth application-default login`.

### 🚀 Usage

From the project's root directory, execute the script from your terminal:

```bash
python scripts/sample_queries.py
