resource "intersight_fcpool_pool" "vmware_wwnn_pool" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "VMware-WWNN-Pool"
  assignment_order = "sequential"
  pool_purpose     = "WWNN"

  id_blocks {
    from = "20:00:00:25:B5:10:00:00"
    to   = "20:00:00:25:B5:10:00:09"
  }
}

resource "intersight_fcpool_pool" "vmware_wwpn_boot_a" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "VMware-WWPN-Boot-A"
  assignment_order = "sequential"
  pool_purpose     = "WWPN"

  id_blocks {
    from = "20:00:00:25:B5:A0:00:00"
    to   = "20:00:00:25:B5:A0:00:09"
  }
}

resource "intersight_fcpool_pool" "vmware_wwpn_boot_b" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "VMware-WWPN-Boot-B"
  assignment_order = "sequential"
  pool_purpose     = "WWPN"

  id_blocks {
    from = "20:00:00:25:B5:B0:00:00"
    to   = "20:00:00:25:B5:B0:00:09"
  }
}

resource "intersight_fcpool_pool" "vmware_wwpn_data_a" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "VMware-WWPN-Data-A"
  assignment_order = "sequential"
  pool_purpose     = "WWPN"

  id_blocks {
    from = "20:00:00:25:B5:A0:00:00"
    to   = "20:00:00:25:B5:A0:00:09"
  }
}

resource "intersight_fcpool_pool" "vmware_wwpn_data_b" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description      = "Terraform deployed"
  name             = "VMware-WWPN-Data-B"
  assignment_order = "sequential"
  pool_purpose     = "WWPN"

  id_blocks {
    from = "20:00:00:25:B5:B0:00:00"
    to   = "20:00:00:25:B5:B0:00:09"
  }
}

resource "intersight_vnic_fc_network_policy" "vsan_101_a" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "VSAN-101-Fabric-A"

  vsan_settings {
    id = 101
  }
}

resource "intersight_vnic_fc_network_policy" "vsan_201_b" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description = "Terraform deployed"
  name        = "VSAN-201-Fabric-B"

  vsan_settings {
    id = 201
  }
}

# /api/v1/vnic/FcAdapterPolicies?$filter=Name%20eq%20VMWare
resource "intersight_vnic_fc_adapter_policy" "fc_vmware" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description                 = "Terraform deployed"
  name                        = "FC-Adapter-VMWare"
  error_detection_timeout     = 2000
  io_throttle_count           = 256
  lun_count                   = 1024
  lun_queue_depth             = 20
  resource_allocation_timeout = 10000

  flogi_settings {
    retries = 8
    timeout = 4000
  }

  plogi_settings {
    retries = 8
    timeout = 20000
  }

  scsi_queue_settings {
    nr_count  = 1
    ring_size = 512
  }

  interrupt_settings {
    mode = "MSIx"
  }

  tx_queue_settings {
    ring_size = 64
  }

  rx_queue_settings {
    ring_size = 64
  }

  error_recovery_settings {
    enabled = false
  }
}

resource "intersight_vnic_fc_qos_policy" "fc-qos-default" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description         = "Terraform deployed"
  name                = "FC-QoS-Default-Policy"
  cos                 = 3
  max_data_field_size = 2112
  rate_limit          = 0
  burst               = 10240
}
