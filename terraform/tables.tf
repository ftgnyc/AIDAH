# --- Dimension Tables ---

# Table: dim_users
resource "google_bigquery_table" "dim_users" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_users"
  schema = jsonencode([
    { "name" : "id_user", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "first_name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "second_name", "type" : "STRING" },
    { "name" : "last_name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "email", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "phone", "type" : "STRING" }
  ])
}

# Table: dim_institutions
resource "google_bigquery_table" "dim_institutions" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_institutions"
  schema = jsonencode([
    { "name" : "id_institution", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "code", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "type", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "state", "type" : "STRING" },
    { "name" : "city", "type" : "STRING" }
  ])
}

# Table: dim_agreements
resource "google_bigquery_table" "dim_agreements" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_agreements"
  schema = jsonencode([
    { "name" : "id_agreement", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "code", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "title", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "description", "type" : "STRING" },
    { "name" : "d_valid_since", "type" : "DATE", "mode": "REQUIRED" },
    { "name" : "d_valid_until", "type" : "DATE" }
  ])
}

# Table: dim_degree_programs
resource "google_bigquery_table" "dim_degree_programs" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_degree_programs"
  schema = jsonencode([
    { "name" : "id_degree_program", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "code", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "name", "type" : "STRING", "mode": "REQUIRED" }
  ])
}

# Table: dim_courses
resource "google_bigquery_table" "dim_courses" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_courses"
  schema = jsonencode([
    { "name" : "id_course", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "code", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "type", "type" : "STRING", "mode": "REQUIRED" }
  ])
}

# Table: dim_semesters
resource "google_bigquery_table" "dim_semesters" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_semesters"
  schema = jsonencode([
    { "name" : "id_semester", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "year", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "semester", "type" : "STRING", "mode": "REQUIRED" }
  ])
}

# Table: dim_dates
resource "google_bigquery_table" "dim_dates" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "dim_dates"
  schema = jsonencode([
    { "name" : "date", "type" : "DATE", "mode" : "REQUIRED" },
    { "name" : "year", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "month", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "month_full_name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "month_short_name", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "day", "type" : "INTEGER", "mode": "REQUIRED" }
  ])
}

# --- Fact Tables ---

# Table: fact_user_events
resource "google_bigquery_table" "fact_user_events" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "fact_user_events"
  schema = jsonencode([
    { "name" : "id_enrollment", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "id_user", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "id_institution", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "id_agreement", "type" : "INTEGER" },
    { "name" : "id_degree_program", "type" : "INTEGER" },
    { "name" : "student_id", "type" : "STRING" },
    { "name" : "grade_level", "type" : "INTEGER" },
    { "name" : "d_enrollment", "type" : "DATE" },
    { "name" : "d_expected_graduation", "type" : "DATE" },
    { "name" : "d_graduation", "type" : "DATE" },
    { "name" : "event_type", "type" : "STRING", "mode": "REQUIRED" }
  ])
}

# Table: fact_grades
resource "google_bigquery_table" "fact_grades" {
  dataset_id = google_bigquery_dataset.aidah_schema.dataset_id
  table_id   = "fact_grades"
  schema = jsonencode([
    { "name" : "id_user", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "id_institution", "type" : "INTEGER", "mode" : "REQUIRED" },
    { "name" : "id_degree_program", "type" : "INTEGER" },
    { "name" : "id_course", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "grade", "type" : "STRING", "mode": "REQUIRED" },
    { "name" : "course_year", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "id_semester", "type" : "INTEGER", "mode": "REQUIRED" },
    { "name" : "is_transferred", "type" : "BOOLEAN", "mode": "REQUIRED" },
    { "name" : "date", "type" : "DATE", "mode": "REQUIRED" }
  ])
}