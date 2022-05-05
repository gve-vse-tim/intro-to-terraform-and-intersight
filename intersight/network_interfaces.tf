# LAN Connectivity for VMWare Server
resource "intersight_vnic_lan_connectivity_policy" "Intersight_VMware" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description     = "Ethernet HVM Connectivity for IMM System - Terraform deployed"
  name            = "Intersight_VMware"
  target_platform = "FIAttached"
  placement_mode  = "custom"
}

# Create the vNIC interfaces for VMware based, Intersight Managed Hosts
resource "intersight_vnic_eth_if" "hvm_mgmt_a" {
  name             = "hvmMgmtA"
  order            = 0
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmMgmtA"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_mgmt_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_mgmt_b" {
  name             = "hvmMgmtB"
  order            = 1
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmMgmtB"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_mgmt_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_migrate_a" {
  name             = "hvmMigrateA"
  order            = 2
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmMigrateA"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_migrate_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_migrate_b" {
  name             = "hvmMigrateB"
  order            = 3
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmMigrateB"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_migrate_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_storage_a" {
  name             = "hvmStorageA"
  order            = 4
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmStorageA"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_storage_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_storage_b" {
  name             = "hvmStorageB"
  order            = 5
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmStorageB"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_storage_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_vmnet_a" {
  name             = "hvmVMnetA"
  order            = 6
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmVMnetA"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_vmnet_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_eth_if" "hvm_vmnet_b" {
  name             = "hvmVMnetB"
  order            = 7
  failover_enabled = false
  mac_address_type = "POOL"

  mac_pool {
    object_type = "macpool.Pool"
    moid        = intersight_macpool_pool.hvm_fabric_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  cdn {
    nr_source = "vnic"
    value     = "hvmVMnetB"
  }

  usnic_settings {
    nr_count = 0
  }

  vmq_settings {
    enabled = false
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fabric_eth_network_group_policy {
    object_type = "fabric.EthNetworkGroupPolicy"
    moid        = intersight_fabric_eth_network_group_policy.hvm_vmnet_vlan.moid
  }

  # Network Control Policy
  fabric_eth_network_control_policy {
    object_type = "fabric.EthNetworkControlPolicy"
    moid        = intersight_fabric_eth_network_control_policy.cdp_forged_allvlans.moid
  }

  # Adapter Settings
  eth_adapter_policy {
    object_type = "vnic.EthAdapterPolicy"
    moid        = intersight_vnic_eth_adapter_policy.ethernet_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  eth_qos_policy {
    object_type = "vnic.EthQosPolicy"
    moid        = intersight_vnic_eth_qos_policy.best_effort_1500.moid
  }

  lan_connectivity_policy {
    object_type = "vnic.LanConnectivityPolicy"
    moid        = intersight_vnic_lan_connectivity_policy.Intersight_VMware.moid
  }
}
