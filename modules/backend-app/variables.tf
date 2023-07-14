#------------------------------------------------------------------------------#
#                                   GLOBAL                                     #
#------------------------------------------------------------------------------#
variable "environment" {
  description = "Global Terraform project environment."
  type        = string
}

variable "global_region" {
  description = "The region Terraform operates against."
  type        = string
}

variable "project_id" {
  description = "The project Terraform operates on."
  type        = string
}

# LABELS
variable "default_labels" {
  description = "Map of default labels."
  type        = map(string)
}


#------------------------------------------------------------------------------#
#                                     APP                                      #
#------------------------------------------------------------------------------#
variable "app_docker_tag" {
  description = "Backend app Docker tag."
  type        = string
  default     = "latest"
}

variable "app_instances_max_scale" {
  description = "Maximum number of app instances."
  type        = string
  default     = "1"
}

variable "app_invokers" {
  description = "List of principals that are allowed to access the app."
  type        = list(string)
}

variable "app_name" {
  type = string
}

variable "app_sa_display_name" {
  description = "Service account display name."
  type        = string
}

# Application environment variables
variable "app_env_gin_mode" {
  description = "App environment variable - sets gin engine mode (release, test, debug)."
  type        = string
}

variable "app_env_log_level" {
  description = "App environment variable - sets app logging level."
  type        = string
}
