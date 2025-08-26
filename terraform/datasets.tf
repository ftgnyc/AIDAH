resource "google_bigquery_dataset" "aidah_schema" {
  dataset_id = var.dataset_name
  project    = var.project_id
  location   = var.location
}