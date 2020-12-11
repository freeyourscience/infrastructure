resource "google_project_service" "iam" {
  service                    = "iam.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "gcr" {
  service                    = "containerregistry.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "run" {
  service                    = "run.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}
