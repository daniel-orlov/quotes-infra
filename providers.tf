#------------------------------------------------------------------------------#
#                                  TERRAFORM                                   #
#------------------------------------------------------------------------------#
terraform {
  required_version = ">= 1.1"
  required_providers {
    google = {
      version = ">= 3.53"
    }
    google-beta = {
      version = ">= 3.53"
    }
  }

  cloud {
    organization = "danorlov"

    workspaces {
      name = "faraway-dev"
    }
  }
}


#------------------------------------------------------------------------------#
#                                  PROVIDERS                                   #
#------------------------------------------------------------------------------#
provider "google" {
  project = var.project_id
  region  = var.global_region
}

provider "google-beta" {
  project = var.project_id
  region  = var.global_region
}
