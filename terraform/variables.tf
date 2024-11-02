# variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1" # Default region, adjust if needed
}

variable "bucket" {
  description = "GCS bucket name where the file is located"
  type        = string
}

variable "file_name" {
  description = "Name of the file in GCS to load into BigQuery"
  type        = string
}

variable "dataset_id" {
  description = "BigQuery dataset ID"
  type        = string
}

variable "table_id" {
  description = "BigQuery table ID where data will be loaded"
  type        = string
}

