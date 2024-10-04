# Terraform Organization API Token - for Secret Sync + HCP Terraform
output "terraform_org_token" {
  value = nonsensitive(tfe_organization_token.org_token.token)
}
