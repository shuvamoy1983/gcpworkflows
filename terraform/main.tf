provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "workflow_sa" {
  account_id   = "workflow-sa2"
  display_name = "Workflow Service Account"
}

resource "google_project_iam_member" "bigquery_job_user" {
  project = var.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.workflow_sa.email}"
}

resource "google_project_iam_member" "bigquery_data_editor" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"  # Optional: Add only if modifying datasets/tables
  member  = "serviceAccount:${google_service_account.workflow_sa.email}"
}

resource "google_project_iam_member" "storage_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.workflow_sa.email}"
}

resource "google_project_iam_member" "workflow_invoker" {
  project = var.project_id
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.workflow_sa.email}"
}

resource "google_workflows_workflow" "load_data_workflow" {
  name            = "load-data-workflow"
  region          = var.region
  service_account = "workflow-sa2@genial-venture-439605-i2.iam.gserviceaccount.com"

  description = "Workflow to load data from GCS to BigQuery"

  source_contents = templatefile("load_data_workflow.yaml", {
    project_id = var.project_id,
    bucket     = var.bucket,
    file_name  = var.file_name,
    dataset_id = var.dataset_id,
    table_id   = var.table_id
  })
}

output "workflow_name" {
  value = google_workflows_workflow.load_data_workflow.name
}

