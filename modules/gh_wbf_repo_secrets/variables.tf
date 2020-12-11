variable "sa_key" {
  description = "Key for the service account to be used by the github actions"
  sensitive   = true
}

variable "sherpa_api_key" {
  description = "API key for v2.sherpa.co.uk"
  sensitive   = true
}
