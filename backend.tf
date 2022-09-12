terraform {
  backend "gcs" {
    credentials = "gcpLearn.json"
    bucket      = "lyrical-marker-362301-terraform-state"
    prefix      = "terraform/state"
  }
}


