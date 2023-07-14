#------------------------------------------------------------------------------#
#                                     VPC                                      #
#------------------------------------------------------------------------------#
resource "google_compute_network" "main_vpc" {
  name                    = "faraway-${var.environment}-${var.global_region}-main-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.cloud_compute_api]
}


#------------------------------------------------------------------------------#
#                                   SUBNETS                                    #
#------------------------------------------------------------------------------#
resource "google_compute_subnetwork" "backend-neg-subnet" {
  name          = "faraway-${var.environment}-${var.global_region}-be-neg-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.global_region
  network       = google_compute_network.main_vpc.id
}

#------------------------------------------------------------------------------#
#                                     NEG                                      #
#------------------------------------------------------------------------------#
resource "google_compute_region_network_endpoint_group" "backend-server-neg" {
  name                  = "faraway-${var.environment}-${var.global_region}-be-server-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.global_region
  cloud_run {
    service = module.backend_server_app.app_cloud_run_service_name
  }
}


#------------------------------------------------------------------------------#
#                               LOAD BALANCERS                                 #
#------------------------------------------------------------------------------#
module "lb-http-be-server" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "9.1.0"

  project = var.project_id
  name    = "faraway-${var.environment}-${var.global_region}-be-server-lb"

  ssl                             = true
  managed_ssl_certificate_domains = ["${var.network_environment_prefix}dantestaway.com"]
  https_redirect                  = true
  create_address                  = true
  backends                        = {
    be-server = {
      description             = "Main faraway BE server deployed in Cloud Run."
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = null


      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group = google_compute_region_network_endpoint_group.backend-server-neg.id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}


#------------------------------------------------------------------------------#
#                                     ROUTER                                   #
#------------------------------------------------------------------------------#
resource "google_compute_router" "router" {
  name     = "faraway-${var.environment}-${var.global_region}-router"
  provider = google-beta
  region   = var.global_region
  network  = google_compute_network.main_vpc.id
}


#------------------------------------------------------------------------------#
#                                     NAT                                      #
#------------------------------------------------------------------------------#
resource "google_compute_router_nat" "router_nat" {
  name                               = "faraway-${var.environment}-${var.global_region}-nat"
  provider                           = google-beta
  region                             = var.global_region
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}
