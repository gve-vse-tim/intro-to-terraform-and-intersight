# The parent server profile that aggregates all policies for a given server
# /api/v1/server/Profile (https://intersight.com/apidocs/apirefs/server/Profiles/model/)
resource "intersight_server_profile" "intersight" {
  organization {
    object_type = "organization.Organization"
    moid        = intersight_organization_organization.target.moid
  }

  description       = "Terraform deployed"
  name              = "SrvProf-intersight"
  target_platform   = "FIAttached"
  uuid_address_type = "POOL"

  uuid_pool {
    object_type = "uuidpool.Pool"
    moid        = intersight_uuidpool_pool.intersight_uuid_pool.moid
  }

  policy_bucket {
    object_type = "boot.PrecisionPolicy"
    moid        = intersight_boot_precision_policy.local_boot_order.moid
  }

  policy_bucket {
    object_type = "bios.Policy"
    moid        = intersight_bios_policy.vmware_6_7_U3.moid
  }

  policy_bucket {
    object_type = "vmedia.Policy"
    moid        = intersight_vmedia_policy.fedora.moid
  }

  policy_bucket {
    object_type = "access.Policy"
    moid        = intersight_access_policy.oob_mgmt_access.moid
  }

  policy_bucket {
    object_type = "ipmioverlan.Policy"
    moid        = intersight_ipmioverlan_policy.ipmi_disabled.moid
  }

  policy_bucket {
    object_type = "iam.EndPointUserPolicy"
    moid        = intersight_iam_end_point_user_policy.local_user_policy.moid
  }

  policy_bucket {
    object_type = "kvm.Policy"
    moid        = intersight_kvm_policy.kvm_enabled_insecure.moid
  }

  policy_bucket {
    object_type = "storage.StoragePolicy"
    moid        = intersight_storage_storage_policy.intersight_storage.moid
  }

  policy_bucket {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }

  policy_bucket {
    object_type = "vnic.SanConnectivityPolicy"
    moid        = intersight_vnic_san_connectivity_policy.Intersight_VMware.moid
  }

  policy_bucket {
    object_type = "syslog.Policy"
    moid        = intersight_syslog_policy.local_emergency_remote_notice.moid
  }

  policy_bucket {
    object_type = "sol.Policy"
    moid        = intersight_sol_policy.sol_disabled.moid
  }

  policy_bucket {
    object_type = "snmp.Policy"
    moid        = intersight_snmp_policy.snmp_disabled.moid
  }
}

output "intersight_sp_moid" {
  value = intersight_server_profile.intersight.moid
}
