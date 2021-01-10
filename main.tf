terraform {
  required_providers {
    google = {
      version = "3.50.0"
    }
    google-beta = {
      version = "3.51.1"
    }
    github = {
      version = "4.1.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
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

module "gh_fyscience_repo_secrets" {
  source           = "./modules/gh_fyscience_repo_secrets"
  cloudrun_svc     = var.cloudrun_svc
  cloudrun_svc_dev = var.cloudrun_svc_dev
  sa_key           = module.gcp_sa_gh_actions.sa_key
  sherpa_api_key   = var.sherpa_api_key
  s2_api_key       = var.s2_api_key
  domain_name      = var.domain_name
  gcp_region       = var.gcp_region
  gcp_project      = var.gcp_project
}

module "gcp_domainmapping" {
  source      = "./modules/gcp_domainmapping"
  domain_name = var.domain_name
  route       = var.cloudrun_svc
  dev_route   = var.cloudrun_svc_dev
  gcp_region  = var.gcp_region
  gcp_project = var.gcp_project
}

module "gcp_monitoring" {
  source      = "./modules/gcp_monitoring"
  domain_name = var.domain_name
  gcp_project = var.gcp_project
}

module "gcp_budget" {
  source      = "./modules/gcp_budget"
  gcp_project = var.gcp_project
}