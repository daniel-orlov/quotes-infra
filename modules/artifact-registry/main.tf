#------------------------------------------------------------------------------#
#                             ARTIFACT REGISTRY API                            #
#------------------------------------------------------------------------------#
resource "google_project_service" "artifact_registry_api" {
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}


#------------------------------------------------------------------------------#
#                                  REPOSITORY                                  #
#------------------------------------------------------------------------------#
resource "google_artifact_registry_repository" "faraway" {
  location      = var.global_region
  repository_id = "faraway-test-${var.repository_name}"
  description   = "Docker repository for Faraway ${upper(var.repository_name)} apps"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  labels = merge(var.default_labels, {
    name = "faraway-${var.environment}-${var.repository_name}-docker-repo"
    tier = "private"
  })

  depends_on = [google_project_service.artifact_registry_api]
}
