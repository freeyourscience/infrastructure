resource "google_storage_bucket" "log-bucket" {
  name          = "prod-log-bucket"
  storage_class = "ARCHIVE"
}

resource "google_logging_project_sink" "instance-sink" {
  name        = "prod-sink-to-archive-bucket"
  description = "Longterm retentention of production logs"
  destination = "storage.googleapis.com/${google_storage_bucket.log-bucket.name}"
  filter      = "resource.type = cloud_run_revision AND resource.labels.service_name = prod"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.log-bucket.name
  role   = "roles/storage.objectCreator"
  members = [
    "serviceAccount:cloud-logs@system.gserviceaccount.com",
  ]
}
