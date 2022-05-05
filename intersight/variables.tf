# This variables file defines certain environmental
# values related to where the server profile will be
# deployed for this example

variable "site1_syslog_server" {
  description = "Site 1 Syslog Server - Terraform deployed"
  type        = string
  default     = "10.60.180.185"
}

variable "target_organization" {
  description = "Deployment organization for policies - Terraform deployed"
  type        = string
  default     = "Demo-Deployment"
}

variable "intersight_sernum" {
  description = "Intersight Managed Server Serial Number"
  type        = string
  default     = "SERVER_SERIAL"
}

variable "dcnm_password" {
  description = "Password for the local DCNM user"
  type        = string
}
