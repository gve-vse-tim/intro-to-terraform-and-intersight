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

# Create the Server Profile
resource "intersight_server_profile" "server1" {
    organization {
        object_type = "organization.Organization"
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "SrvProf-Server1"

    # After configuring serial number in devices.tf, uncomment this
    # assigned_server block accordingly.

    # assigned_server {
    #     object_type = "compute.RackUnit"
    #     moid = data.intersight_compute_rack_unit.server1.moid
    # }

    # GitHub Issue #16: https://github.com/CiscoDevNet/terraform-provider-intersight/issues/16

    # To trigger an actual deployment of the profile onto the assigned server
    # below, you must uncomment the action line here. However, with current,
    # provider design, you must (a) run 'apply' first without 'Deploy', (b)
    # change action to 'Deploy' and run 'apply' again, (c) change action back
    # to 'No-op' (or comment it out).

    # action = "Deploy"
}

output "server1_sp_moid" {
    value = intersight_server_profile.server1.moid
}

# Configure Boot Order ("boot precision") policy
resource "intersight_boot_precision_policy" "Local-Boot-Order" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Boot vDVD and local HDD - Terraform deployed"
    name = "Local-Boot-Order"
    configured_boot_mode = "Legacy"
    enforce_uefi_secure_boot = false

    # boot_devices examples found here:
    #   https://github.com/CiscoDevNet/terraform-provider-intersight/blob/master/examples/server_configurations/boot_precision_policy.tf
    # object_type found here:
    #   https://intersight.com/apidocs/apirefs/boot/PrecisionPolicies/model/
    boot_devices {
        name = "RemoteDVD"
        enabled = true
        object_type = "boot.VirtualMedia"
        class_id = "boot.VirtualMedia"
        additional_properties = jsonencode({
            Subtype = "kvm-mapped-dvd"
        })
    }

    # /api/v1/boot/PrecisionPolicies/{Moid} to get existing policy values
    boot_devices {
        name = "LocalHDD"
        enabled = true
        object_type = "boot.LocalDisk"
        additional_properties = jsonencode({
            Slot = "HBA"
        })
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.server1.moid
    }
}

output "boot_policy_moid" {
    value = intersight_boot_precision_policy.Local-Boot-Order.moid
}

# Configure BIOS policy
resource "intersight_bios_policy" "ESX-67U3-BIOS" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "ESX-67U3-BIOS"

    # NIC settings
    cdn_enable = "enabled"
    cdn_support = "enabled"
    lom_ports_all_state = "enabled"
    lom_port0state = "Legacy Only"
    lom_port1state = "Legacy Only"
    lom_port2state = "Legacy Only"
    lom_port3state = "Legacy Only"
    onboard10gbit_lom = "enabled"
    onboard_gbit_lom = "enabled"
    pci_option_ro_ms = "enabled"

    # Memory settings
    numa_optimized = "enabled"
    direct_cache_access = "enabled"

    # CPU Settings
    cpu_energy_performance = "balanced-performance"
    cpu_power_management = "energy-efficient"
    cpu_performance = "custom"

    # Intel/Virtualization Settings
    enhanced_intel_speed_step_tech = "enabled"
    execute_disable_bit = "enabled"
    intel_hyper_threading_tech = "enabled"
    intel_speed_select = "Base"
    intel_virtualization_technology = "enabled"
    intel_vt_for_directed_io = "enabled"
    intel_vtd_coherency_support = "enabled"
    intel_vtd_pass_through_dma_support = "enabled"
    llc_prefetch = "disabled"
    processor_c1e = "enabled"
    processor_c3report = "enabled"
    processor_c6report = "enabled"
    processor_cstate = "enabled"
    pstate_coord_type = "HW ALL"
    sr_iov = "enabled"

    # Miscellaneous
    serial_port_aenable = "enabled"
    snc = "disabled"

    # Required to permit idempotency
    memory_size_limit = "platform-default"
    partial_mirror_percent = "platform-default"
    partial_mirror_value1 = "platform-default"
    partial_mirror_value2 = "platform-default"
    partial_mirror_value3 = "platform-default"
    partial_mirror_value4 = "platform-default"
    patrol_scrub_duration = "platform-default"

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.server1.moid
    }
}
