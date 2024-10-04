# Github App for Github Actions Secret Sync
resource "hcp_vault_secrets_app" "github-app" {
  project_id  = hcp_project.project.resource_id
  app_name    = "github-app"
  description = "Example app for Github Actions Secret Sync"
}

# Terraform App for HCP Terraform Secret Sync
resource "hcp_vault_secrets_app" "terraform-app" {
  project_id  = hcp_project.project.resource_id
  app_name    = "terraform-app"
  description = "Example app for HCP Terraform Secret Sync"
}

# App for retrieval using service principal
resource "hcp_vault_secrets_app" "retrieval-app" {
  project_id  = hcp_project.project.resource_id
  app_name    = "retrieval-app"
  description = "Example app for direct lookup on application secrets"
}

resource "random_uuid" "api_token" {}

# Secret for TF Retrieval
resource "hcp_vault_secrets_secret" "demo_app_secret" {
  app_name     = hcp_vault_secrets_app.retrieval-app.app_name
  project_id   = hcp_project.project.resource_id
  secret_name  = "STRIPE_API_KEY"
  secret_value = random_uuid.api_token.result
}

# Secret for HCP Terraform Sync
resource "hcp_vault_secrets_secret" "terraform_db_user" {
  app_name     = hcp_vault_secrets_app.terraform-app.app_name
  project_id   = hcp_project.project.resource_id
  secret_name  = "DATABASE_USERNAME"
  secret_value = "root"
}

# Secret for HCP Terraform Sync
resource "hcp_vault_secrets_secret" "terraform_db_password" {
  app_name     = hcp_vault_secrets_app.terraform-app.app_name
  project_id   = hcp_project.project.resource_id
  secret_name  = "DATABASE_PASSWORD"
  secret_value = "rootpassword"
}

# Secret for Github Actions Sync
resource "hcp_vault_secrets_secret" "gh_actions_sync_secret" {
  app_name     = hcp_vault_secrets_app.github-app.app_name
  project_id   = hcp_project.project.resource_id
  secret_name  = "TF_API_TOKEN"
  secret_value = ""
}
