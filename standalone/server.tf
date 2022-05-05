# Create the Server Profile
resource "intersight_server_profile" "standalone" {
  organization {
    object_type = "organization.Organization"
    moid        = intersight_organization_organization.target.moid
  }

  description     = "Terraform deployed"
  name            = "SrvProf-standalone"
  target_platform = "Standalone"
}

output "standalone_sp_moid" {
  value = intersight_server_profile.standalone.moid
}
