variable "cloudrun_svc_dev" {
  description = "Name of the cloudrun service for the dev deployment."
}

variable "cloudrun_svc" {
  description = "Name of the production cloudrun service."
}

variable "sa_key" {
  description = "Key for the service account to be used by the github actions"
  sensitive   = true
}

variable "sherpa_api_key" {
  description = "API key for v2.sherpa.co.uk"
  sensitive   = true
}

variable "s2_api_key" {
  description = "API key for partner.semanticscholar.org/v1"
  sensitive   = true
}

variable "domain_name" {
  description = "base domain to use"
}

variable "gcp_region" {}

variable "gcp_project" {}
