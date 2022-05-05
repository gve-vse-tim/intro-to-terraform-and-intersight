# LAN Connectivity for VMWare Server
resource "intersight_vnic_san_connectivity_policy" "Intersight_VMware" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description     = "SAN HVM Connectivity for IMM System - Terraform deployed"
  name            = "Intersight_VMware"
  target_platform = "FIAttached"
  placement_mode  = "custom"

  wwnn_address_type = "POOL"
  wwnn_pool {
    object_type = "fcpool.Pool"
    moid        = intersight_fcpool_pool.vmware_wwnn_pool.moid
  }

  #   fc_ifs {
  #     object_type = "vnic.FcIf"
  #     moid        = intersight_vnic_fc_if.hvm_boot_a.moid
  #   }

  #   fc_ifs {
  #     object_type = "vnic.FcIf"
  #     moid        = intersight_vnic_fc_if.hvm_boot_b.moid
  #   }

  #   fc_ifs {
  #     object_type = "vnic.FcIf"
  #     moid        = intersight_vnic_fc_if.hvm_data_a.moid
  #   }

  #   fc_ifs {
  #     object_type = "vnic.FcIf"
  #     moid        = intersight_vnic_fc_if.hvm_data_b.moid
  #   }
}

resource "intersight_vnic_fc_if" "hvm_boot_a" {
  name                = "hvmBootA"
  order               = 8
  persistent_bindings = true
  wwpn_address_type   = "POOL"

  wwpn_pool {
    object_type = "fcpool.Pool"
    moid        = intersight_fcpool_pool.vmware_wwpn_boot_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  # Bind interface via reference to other policies

  # VSAN(s) Assignments
  fc_network_policy {
    object_type = "vnic.FcNetworkPolicy"
    moid        = intersight_vnic_fc_network_policy.vsan_101_a.moid
  }

  # Adapter Settings
  fc_adapter_policy {
    object_type = "vnic.FcAdapterPolicy"
    moid        = intersight_vnic_fc_adapter_policy.fc_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  fc_qos_policy {
    object_type = "vnic.FcQosPolicy"
    moid        = intersight_vnic_fc_qos_policy.fc-qos-default.moid
  }

  san_connectivity_policy {
    object_type = "vnic.SanConnectivityPolicy"
    moid        = intersight_vnic_san_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_fc_if" "hvm_boot_b" {
  name                = "hvmBootB"
  order               = 9
  persistent_bindings = true
  wwpn_address_type   = "POOL"

  wwpn_pool {
    object_type = "fcpool.Pool"
    moid        = intersight_fcpool_pool.vmware_wwpn_boot_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  # Bind interface via reference to other policies

  # VSAN(s) Assignments
  fc_network_policy {
    object_type = "vnic.FcNetworkPolicy"
    moid        = intersight_vnic_fc_network_policy.vsan_201_b.moid
  }

  # Adapter Settings
  fc_adapter_policy {
    object_type = "vnic.FcAdapterPolicy"
    moid        = intersight_vnic_fc_adapter_policy.fc_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  fc_qos_policy {
    object_type = "vnic.FcQosPolicy"
    moid        = intersight_vnic_fc_qos_policy.fc-qos-default.moid
  }

  san_connectivity_policy {
    object_type = "vnic.SanConnectivityPolicy"
    moid        = intersight_vnic_san_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_fc_if" "hvm_data_a" {
  name                = "hvmDataA"
  order               = 10
  persistent_bindings = true
  wwpn_address_type   = "POOL"

  wwpn_pool {
    object_type = "fcpool.Pool"
    moid        = intersight_fcpool_pool.vmware_wwpn_data_a.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  # Bind interface via reference to other policies

  # VSAN(s) Assignments
  fc_network_policy {
    object_type = "vnic.FcNetworkPolicy"
    moid        = intersight_vnic_fc_network_policy.vsan_101_a.moid
  }

  # Adapter Settings
  fc_adapter_policy {
    object_type = "vnic.FcAdapterPolicy"
    moid        = intersight_vnic_fc_adapter_policy.fc_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  fc_qos_policy {
    object_type = "vnic.FcQosPolicy"
    moid        = intersight_vnic_fc_qos_policy.fc-qos-default.moid
  }

  san_connectivity_policy {
    object_type = "vnic.SanConnectivityPolicy"
    moid        = intersight_vnic_san_connectivity_policy.Intersight_VMware.moid
  }
}

resource "intersight_vnic_fc_if" "hvm_data_b" {
  name                = "hvmDataB"
  order               = 11
  persistent_bindings = true
  wwpn_address_type   = "POOL"

  wwpn_pool {
    object_type = "fcpool.Pool"
    moid        = intersight_fcpool_pool.vmware_wwpn_data_b.moid
  }

  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  # Bind interface via reference to other policies

  # VLAN(s) Assignments
  fc_network_policy {
    object_type = "vnic.FcNetworkPolicy"
    moid        = intersight_vnic_fc_network_policy.vsan_201_b.moid
  }

  # Adapter Settings
  fc_adapter_policy {
    object_type = "vnic.FcAdapterPolicy"
    moid        = intersight_vnic_fc_adapter_policy.fc_vmware.moid
  }

  # Ethernet QOS/MTU Policy
  fc_qos_policy {
    object_type = "vnic.FcQosPolicy"
    moid        = intersight_vnic_fc_qos_policy.fc-qos-default.moid
  }

  san_connectivity_policy {
    object_type = "vnic.SanConnectivityPolicy"
    moid        = intersight_vnic_san_connectivity_policy.Intersight_VMware.moid
  }
}
