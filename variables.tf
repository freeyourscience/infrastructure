variable "gcp_region" {}

variable "gcp_project" {
  description = "The project id e.g. fantastic-bezoar-829874"
}

variable "domain_name" {
  description = "Root level domain name e.g. freeyourscience.org"
}

variable "cloudrun_svc" {
  description = "name for the cloud run service, sometimes also referred to as its route"
}

variable "cloudrun_svc_dev" {
  description = "name for the cloud run service of the dev environment"
}

variable "sherpa_api_key" {
  description = "API key for v2.sherpa.co.uk"
  sensitive   = true
}

variable "s2_api_key" {
  description = "API key for partner.semanticscholar.org/v1"
  sensitive   = true
}
