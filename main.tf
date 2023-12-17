terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }

    /*
      vercel is activated when the frontend has been created
    */

    # vercel = {
    #   source  = "vercel/vercel"
    #   version = "0.14.0"
    # }
  }

  backend "gcs" {
    bucket  = "docpet-infra"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

/*
  vercel is activated when the frontend has been created
*/

# provider "vercel" {
#   api_token = var.vercel_api_token
# }