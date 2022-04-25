# Enable SSH policy
resource "intersight_ssh_policy" "EnableSSH" {
    organization {
        object_type = "organization.Organization"
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "EnableSSH"
    enabled = true
    port = 22
    timeout = 1800

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "enable_ssh_policy_moid" {
    value = intersight_ssh_policy.EnableSSH.moid
}

# Disable SSH policy
resource "intersight_ssh_policy" "DisableSSH" {
    organization {
        object_type = "organization.Organization"
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "DisableSSH"
    enabled = false
    port = 22
    timeout = 1800
}

output "disable_ssh_policy_moid" {
    value = intersight_ssh_policy.EnableSSH.moid
}

# Enable IP KVM policy
resource "intersight_kvm_policy" "EnableIPKVM" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "EnableIPKVM"
    enabled = true
    enable_local_server_video = true
    enable_video_encryption = false
    remote_port = 2068
    maximum_sessions = 4

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "kvm_policy_moid" {
    value = intersight_kvm_policy.EnableIPKVM.moid
}

# Configure NTP policy
resource "intersight_ntp_policy" "local_ntp" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "local_ntp"
    enabled = true
    ntp_servers = [ var.local_ntp_server ]
    timezone = var.local_time_zone

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "ntp_policy_moid" {
    value = intersight_ntp_policy.local_ntp.moid
}

# Configure DNS ("Network Connectivity") policy
resource "intersight_networkconfig_policy" "local_dns_server" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "local_dns_server"
    preferred_ipv4dns_server = var.ipv4_dns_server_1
    alternate_ipv4dns_server = var.ipv4_dns_server_2
    enable_ipv6 = false
    enable_ipv6dns_from_dhcp = false
    enable_dynamic_dns = false

    # GitHub Issue #15: https://github.com/CiscoDevNet/terraform-provider-intersight/issues/15
    # Must comment out on initial creation, then uncomment on
    # subsequent 'terraform apply' to prevent updates.

    # preferred_ipv6dns_server = "::"
    # alternate_ipv6dns_server = "::"


    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "dns_policy_moid" {
    value = intersight_networkconfig_policy.local_dns_server.moid
}
