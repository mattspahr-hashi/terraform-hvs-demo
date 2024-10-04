resource "tfe_project" "tfc_project" {
  name = "hvs-demo-project"
}

resource "tfe_workspace" "tfc_workspace" {
  name       = "hvs-demo-workspace"
  project_id = tfe_project.tfc_project.id
}

resource "tfe_organization_token" "org_token" {
  organization = "mattspahr-sandbox"
}

resource "tfe_variable_set" "hcp_credentials" {
  name         = "HCP Credentials"
  organization = "mattspahr-sandbox"
}

resource "tfe_workspace_variable_set" "service_principal_var_set" {
  workspace_id    = tfe_workspace.tfc_workspace.id
  variable_set_id = tfe_variable_set.hcp_credentials.id
}

resource "tfe_variable" "hcp_project_id" {
  key             = "HCP_PROJECT_ID"
  value           = hcp_project.project.resource_id
  category        = "terraform"
  description     = "Service Principal Project ID"
  variable_set_id = tfe_variable_set.hcp_credentials.id
}

resource "tfe_variable" "hcp_client_id" {
  key             = "HCP_CLIENT_ID"
  value           = hcp_service_principal_key.key.client_id
  category        = "terraform"
  variable_set_id = tfe_variable_set.hcp_credentials.id
}

resource "tfe_variable" "hcp_client_secret" {
  key             = "HCP_CLIENT_SECRET"
  value           = hcp_service_principal_key.key.client_secret
  category        = "terraform"
  sensitive       = true
  variable_set_id = tfe_variable_set.hcp_credentials.id
}
