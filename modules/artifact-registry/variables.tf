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

# LABELS
variable "default_labels" {
  description = "Map of default labels."
  type        = map(string)
}


#------------------------------------------------------------------------------#
#                                     REPO                                     #
#------------------------------------------------------------------------------#
variable "repository_name" {
  description = "Repository name."
  type        = string
}
