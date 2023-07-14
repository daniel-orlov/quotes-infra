#------------------------------------------------------------------------------#
#                                     APPS                                     #
#------------------------------------------------------------------------------#
# REGISTRIES
module "backend_docker_registry" {
  source = "./modules/artifact-registry"

  default_labels  = var.default_labels
  environment     = var.environment
  global_region   = var.global_region
  repository_name = "be"
}

# BACKEND
module "backend_server_app" {
  source = "./modules/backend-app"

  # GLOBAL
  default_labels = var.default_labels
  environment    = var.environment
  global_region  = var.global_region
  project_id     = var.project_id

  # APP
  app_docker_tag            = var.be_app_server_tag
  app_name                  = var.be_app_server_name
  app_sa_display_name       = var.be_app_server_sa_display_name
  app_invokers              = ["allUsers"]

  # APP ENVIRONMENT VARIABLES
  app_env_gin_mode               = var.be_app_env_variables["gin_mode"]
  app_env_log_level              = var.be_app_env_variables["log_level"]
}
