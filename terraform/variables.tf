variable "project_id" {
  type        = string
  description = "The ID of your Google Cloud project."
}

variable "location" {
  type        = string
  description = "The location where BigQuery resources will be created."
}

variable "dataset_name" {
  type        = string
  description = "The name of the BigQuery dataset."
}