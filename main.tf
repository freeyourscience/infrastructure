provider "google" {
  project = "stunning-oasis-298115"
  region  = "us-west1"
}

provider "github" {}

data "google_project" "project" {
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id = "your-project-id"
  activate_apis = [
    "iam.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

module "gcp_registry" {
  source = "./modules/gcp_registry"
}

module "gcp_sa_gh_actions" {
  source = "./modules/gcp_sa_gh_actions"
}

data "github_actions_public_key" "example_public_key" {
  repository = "wissenschaftsbefreiungsfront"
}


resource "github_actions_secret" "sa_key" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_SA_KEY"
  plaintext_value = module.gcp_sa_gh_actions.sa_key
}

resource "github_actions_secret" "gcp_project_id" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = basename(data.google_project.project.id)
}

resource "github_actions_secret" "gcp_cloudrun_service" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_CLOUDRUN_SERVICE"
  plaintext_value = "wbf-dev"
}

resource "github_actions_secret" "gcp_region" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_REGION"
  plaintext_value = "us-west1"
}
