#------------------------------------------------------------------------------#
#                                GLOBAL SETTINGS                               #
#------------------------------------------------------------------------------#
variable "global_region" {
  description = "The region Terraform operates against."
  type        = string
#  default     = "europe-north1" # Finland
}
variable "environment" {
  description = "Global Terraform project environment."
  type        = string
}
variable "project_id" {
  description = "The project Terraform operates on."
  type        = string
}
variable "project_number" {
  description = "The project number Terraform operates on."
  type        = number
}


# LABELS
variable "default_labels" {
  type        = map(string)
  description = "Map of default labels"
}


#------------------------------------------------------------------------------#
#                                    NETWORK                                   #
#------------------------------------------------------------------------------#
variable "network_environment_prefix" {
  type        = string
  description = "Prefix to use in subdomains for TLS certs"
}

#------------------------------------------------------------------------------#
#                                     APPS                                     #
#------------------------------------------------------------------------------#
# BACKEND
# SERVER APP
variable "be_app_server_tag" {
  description = "BE server app Docker tag."
  type        = string
}

variable "be_app_server_name" {
  description = "BE server app name."
  type        = string
}

variable "be_app_server_sa_display_name" {
  description = "BE server app service account display name."
  type        = string
#  default     = "Backend Server"
}

variable "be_app_env_variables" {
  description = "BE server app environment variables map."
  type        = map(string)
}

