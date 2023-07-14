#------------------------------------------------------------------------------#
#                                BACKEND SERVICE                               #
#------------------------------------------------------------------------------#
resource "google_cloud_run_service" "be_app" {
  name     = "faraway-${var.environment}-${var.global_region}-be-${var.app_name}"
  location = var.global_region

  template {
    spec {
      containers {
#        image = "${var.global_region}-docker.pkg.dev/${var.project_id}/faraway-be/${var.app_name}:${var.app_docker_tag}"
#        Add a simple hello world image for testing purposes
        image = "gcr.io/google-samples/hello-app:1.0"
        # ENVIRONMENT VARIABLES
        env {
          name  = "GIN_MODE"
          value = var.app_env_gin_mode
        }
        env {
          name  = "LOG_LEVEL"
          value = var.app_env_log_level
        }
      }

      service_account_name = google_service_account.be_app_identity.email
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"        = "1"
        "autoscaling.knative.dev/maxScale"        = var.app_instances_max_scale
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_project_service.cloud_run_api,
    google_service_account.be_app_identity
  ]
}

resource "google_service_account" "be_app_identity" {
  account_id   = var.app_name
  display_name = var.app_sa_display_name
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.be_app.location
  project  = google_cloud_run_service.be_app.project
  service  = google_cloud_run_service.be_app.name
  role     = "roles/run.invoker"
  members  = var.app_invokers

  depends_on = [google_cloud_run_service.be_app]
}

resource "google_cloud_run_v2_service" "be_app" {
  name     = "${var.environment}-${var.global_region}-${var.app_name}"
  location = var.global_region

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      startup_probe {
        initial_delay_seconds = 0
        timeout_seconds = 1
        period_seconds = 3
        failure_threshold = 1
        tcp_socket {
          port = 8080
        }
      }
      liveness_probe {
        http_get {
          path = "/"
        }
      }
    }
  }
}