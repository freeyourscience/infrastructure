provider "google" {
  project     = "stunning-oasis-298115"
  region      = "us-west1"
}

resource "google_storage_bucket" "testing-tf" {
  name          = "temp-for-testing"
  location      = "EU"
  force_destroy = true
}