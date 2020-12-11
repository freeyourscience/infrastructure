provider "google" {
  project = "stunning-oasis-298115"
  region  = "us-west1"
  version = "3.50.0"
}

provider "github" {
  version =  "4.1.0"
}

resource "google_project_service" "service" {
  for_each = toset([
    "iam.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
  ])

  service = each.key

  disable_on_destroy = false
  disable_dependent_services = false
}

module "gcp_registry" {
  source = "./modules/gcp_registry"
}

module "gcp_sa_gh_actions" {
  source = "./modules/gcp_sa_gh_actions"
}

module "gh_wbf_repo_secrets" {
  source = "./modules/gh_wbf_repo_secrets"
  sa_key = module.gcp_sa_gh_actions.sa_key
  sherpa_api_key = var.sherpa_api_key
}

module "gcp_domainmapping_dev" {
  source = "./modules/gcp_domainmapping_dev"
}
