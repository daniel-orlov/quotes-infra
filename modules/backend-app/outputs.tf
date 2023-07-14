output "app_cloud_run_service_name" {
  value = google_cloud_run_service.be_app.name
}

output "app_service_account_email" {
  value = google_service_account.be_app_identity.email
}
