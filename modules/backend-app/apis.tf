#------------------------------------------------------------------------------#
#                                    API                                       #
#------------------------------------------------------------------------------#
resource "google_project_service" "cloud_resource_manager_api" {
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "cloud_run_api" {
  service            = "run.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy = false

  depends_on = [
    google_project_service.cloud_resource_manager_api
  ]
}
