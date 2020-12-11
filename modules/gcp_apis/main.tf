resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "gcr" {
  service = "containerregistry.googleapis.com"
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}
