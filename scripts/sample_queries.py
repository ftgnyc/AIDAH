from google.cloud import bigquery
import os
from dotenv import load_dotenv

def run_bigquery_queries():
    """Runs a series of BigQuery queries and prints the results to the console."""

    load_dotenv()
    project_id = os.getenv("TF_VAR_project_id")
    dataset_id = os.getenv("TF_VAR_dataset_name")

    client = bigquery.Client(project=project_id)

    queries = [
        {
            "title": "Enrollment Count by Institution",
            "query": f"""
                SELECT
                    i.name AS institution_name,
                    COUNT(*) AS enrollment_count
                FROM
                    `{dataset_id}.fact_user_events` AS f
                JOIN
                    `{dataset_id}.dim_institutions` AS i
                ON
                    f.id_institution = i.id_institution
                WHERE
                    f.event_type IN ('HS Enrollment', 'College Enrollment')
                GROUP BY
                    institution_name
                ORDER BY
                    enrollment_count DESC;
            """
        },
        {
            "title": "Expected Graduates in 2027",
            "query": f"""
                SELECT
                    COUNT(DISTINCT id_user) AS expected_graduates_2027
                FROM
                    `{dataset_id}.fact_user_events`
                WHERE
                    EXTRACT(YEAR FROM d_expected_graduation) = 2027
                    AND event_type IN ('HS Enrollment');
            """
        },
        {
            "title": "Students Who Passed in Spring Semesters",
            "query": f"""
                SELECT
                    COUNT(DISTINCT fg.id_user) AS students_passed_in_spring
                FROM
                    `{dataset_id}.fact_grades` AS fg
                JOIN
                    `{dataset_id}.dim_semesters` AS ds
                ON
                    fg.id_semester = ds.id_semester
                WHERE
                    ds.semester = 'Spring'
                    AND fg.grade NOT IN ('F');
            """
        }
    ]

    for q in queries:
        print(f"\n--- {q['title']} ---")
        try:
            query_job = client.query(q['query'])
            results = query_job.result()
            
            results_list = list(results)

            if len(results_list) == 1:
                for row in results_list:
                    header = list(row.keys())[0]
                    value = list(row.values())[0]
                    print(f"✅ {header}: {value}")
            else:
                if len(results_list) > 0:
                    header = list(results_list[0].keys())
                    print(" | ".join(header))
                    for row in results_list:
                        row_values = [str(value) for value in row.values()]
                        print(" | ".join(row_values))
                else:
                    print("No results found.")

        except Exception as e:
            print(f"❌ Error executing the query: {e}")

if __name__ == "__main__":
    run_bigquery_queries()