terraform {
  required_providers {
    google = {
      version = "3.50.0"
    }
    github = {
      version = "4.1.0"
    }
  }
}

locals {
  gcp_region       = "us-west1"
  gcp_project      = "stunning-oasis-298115"
  domain_name      = "freeyourscience.org"
  cloudrun_svc_dev = "wbf-dev"
}

provider "google" {
  project = local.gcp_project
  region  = local.gcp_region
}

provider "github" {
}

resource "google_project_service" "service" {
  for_each = toset([
    "iam.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
  ])

  service = each.key

  disable_on_destroy         = false
  disable_dependent_services = false
}

module "gcp_registry" {
  source = "./modules/gcp_registry"
}

module "gcp_sa_gh_actions" {
  source = "./modules/gcp_sa_gh_actions"
}

module "gh_wbf_repo_secrets" {
  source           = "./modules/gh_wbf_repo_secrets"
  cloudrun_svc_dev = local.cloudrun_svc_dev
  sa_key           = module.gcp_sa_gh_actions.sa_key
  sherpa_api_key   = var.sherpa_api_key
  s2_api_key       = var.s2_api_key
  domain_name      = local.domain_name
  gcp_region       = local.gcp_region
  gcp_project      = local.gcp_project
}

module "gcp_domainmapping_dev" {
  source      = "./modules/gcp_domainmapping_dev"
  domain_name = local.domain_name
  dev_route   = local.cloudrun_svc_dev
  gcp_region  = local.gcp_region
  gcp_project = local.gcp_project
}

module "gcp_monitoring" {
  source      = "./modules/gcp_monitoring"
  domain_name = local.domain_name
  gcp_project = local.gcp_project
}
