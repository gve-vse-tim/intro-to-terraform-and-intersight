# Common policies between Standalone and Fabric deployments

# /api/v1/vnic/EthAdapterPolicies?$filter=Name%20eq%20VMWare
resource "intersight_vnic_eth_adapter_policy" "ethernet_vmware" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "Ethernet-Adapter-VMware"

  advanced_filter   = false
  geneve_enabled    = false
  interrupt_scaling = false

  vxlan_settings {
    enabled = false
  }

  roce_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = false
  }

  arfs_settings {
    enabled = false
  }

  ptp_settings {
    enabled = false
  }

  # Defaults
  uplink_failback_timeout = 5

  completion_queue_settings {
    nr_count = 2
  }

  interrupt_settings {
    nr_count        = 4
    coalescing_time = 125
    coalescing_type = "MIN"
    mode            = "MSIx"
  }

  rss_settings = false

  rx_queue_settings {
    nr_count  = 1
    ring_size = 512
  }

  tx_queue_settings {
    nr_count  = 1
    ring_size = 256
  }

  tcp_offload_settings {
    large_receive = true
    large_send    = true
    rx_checksum   = true
    tx_checksum   = true
  }
}

resource "intersight_vnic_eth_qos_policy" "best_effort_1500" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description    = "Terraform deployed"
  name           = "Best-Effort-MTU1500"
  mtu            = 1500
  rate_limit     = 0
  cos            = 0
  burst          = 10240
  priority       = "Best Effort"
  trust_host_cos = false
}

# FI Attached/Fabrics Specific Policies
resource "intersight_fabric_eth_network_control_policy" "cdp_forged_allvlans" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description           = "Terraform deployed"
  name                  = "CdpEnabled-ForgedMac-AllMacReg"
  cdp_enabled           = true
  forge_mac             = "allow"
  mac_registration_mode = "allVlans"
  uplink_fail_action    = "linkDown"

  lldp_settings {
    receive_enabled  = true
    transmit_enabled = true
  }
}

# FI Attached Network Definitions
resource "intersight_fabric_eth_network_group_policy" "hvm_mgmt_vlan" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "hvm-mgmt-vlan"

  vlan_settings {
    native_vlan   = 601
    allowed_vlans = "601"
  }
}

resource "intersight_fabric_eth_network_group_policy" "hvm_migrate_vlan" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "hvm-migrate-vlan"

  vlan_settings {
    native_vlan   = 602
    allowed_vlans = "602"
  }
}

resource "intersight_fabric_eth_network_group_policy" "hvm_storage_vlan" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "hvm-storage-vlan"

  vlan_settings {
    native_vlan   = 603
    allowed_vlans = "603"
  }
}

resource "intersight_fabric_eth_network_group_policy" "hvm_vmnet_vlan" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "hvm-vmnet-vlan"

  vlan_settings {
    native_vlan   = 3900
    allowed_vlans = "604"
  }
}

#
# Fabric related Network/Mac Pools
# 

resource "intersight_macpool_pool" "hvm_fabric_a" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "HVM-MacPool-Fabric-A"
  assignment_order = "sequential"

  mac_blocks {
    from = "00:25:B5:A0:00:00"
    to   = "00:25:B5:A0:00:FF"
  }
}

resource "intersight_macpool_pool" "hvm_fabric_b" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "HVM-MacPool-Fabric-B"
  assignment_order = "sequential"

  mac_blocks {
    from = "00:25:B5:B0:00:00"
    to   = "00:25:B5:B0:00:FF"
  }
}
