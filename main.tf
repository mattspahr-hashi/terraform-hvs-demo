# Project for HVS Demo
resource "hcp_project" "project" {
  name        = "hvs-demo-project"
  description = "Example project for Demoing HVS"
}

# Service Principal for HCP Terraform lookup
resource "hcp_service_principal" "terraform_run_sp" {
  name   = "terraform-run"
  parent = hcp_project.project.resource_name
}

# Service Principal Keys for Github Actions Auth
resource "hcp_service_principal_key" "key" {
  service_principal = hcp_service_principal.terraform_run_sp.resource_name
}

# Service Principal Role Binding
resource "hcp_project_iam_binding" "sp_role_binding" {
  project_id   = hcp_project.project.resource_id
  principal_id = hcp_service_principal.terraform_run_sp.resource_id
  role         = "roles/admin"
}
