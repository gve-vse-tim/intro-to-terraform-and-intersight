# Define the Storage Policy
resource "intersight_storage_storage_policy" "intersight_storage" {
  organization {
    moid = intersight_organization_organization.target.moid
  }

  description              = "Terraform deployed"
  name                     = "Intersight_Storage_Policy"
  use_jbod_for_vd_creation = true

  unused_disks_state = "UnconfiguredGood"
  global_hot_spares  = 0

  m2_virtual_drive {
    object_type     = "storage.M2VirtualDriveConfig"
    enable          = true
    controller_slot = "MSTOR-RAID-1,MSTOR-RAID-2"
  }
}
