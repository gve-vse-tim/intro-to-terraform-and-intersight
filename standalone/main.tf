terraform {
    required_version = "~> 1.1.9"
    required_providers {
        intersight = {
        source = "CiscoDevNet/intersight"
        version = "1.0.27"
        }
    }
}

provider "intersight" {
    apikey = var.apikey
    secretkey = var.secretkey
    endpoint = var.endpoint
}

## Get the MO data for the default organization in the account.
# /api/v1/organization/Organizations$filter=(Name eq 'default')
data "intersight_organization_organization" "default" {
    name = "default"
}

output "org_default_moid" {
    value = data.intersight_organization_organization.default.moid
}

# Create a new organization resource for this demo
resource "intersight_organization_organization" "target" {
    description = "Terraform Deployed"
    name = var.target_organization
}

output "org_target_moid" {
    value = intersight_organization_organization.target.moid
}
