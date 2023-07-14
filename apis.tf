#------------------------------------------------------------------------------#
#                                    API                                       #
#------------------------------------------------------------------------------#
resource "google_project_service" "cloud_compute_api" {
  service                    = "compute.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false

  depends_on = [
    google_project_service.cloud_dns_api,
    google_project_service.cloud_resource_manager_api,
    google_project_service.iam_api,
  ]
}

resource "google_project_service" "cloud_dns_api" {
  service                    = "dns.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false

    depends_on = [
        google_project_service.cloud_resource_manager_api,
    ]
}

resource "google_project_service" "cloud_resource_manager_api" {
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "iam_api" {
  service                    = "iam.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false

    depends_on = [
        google_project_service.cloud_resource_manager_api,
    ]
}