# Define the Disk Group policy
resource "intersight_storage_disk_group_policy" "RAID6-Disk-Group" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "RAID6-Disk-Group"
    raid_level = "Raid6"
    use_jbods = true

    span_groups {
        disks {
            slot_number = 1
        }
        disks {
            slot_number = 2
        }
        disks {
            slot_number = 3
        }
        disks {
            slot_number = 4
        }
        disks {
            slot_number = 5
        }
        disks {
            slot_number = 6
        }
        disks {
            slot_number = 7
        }
        disks {
            slot_number = 8
        }
        disks {
            slot_number = 9
        }
        disks {
            slot_number = 10
        }
        disks {
            slot_number = 11
        }
        disks {
            slot_number = 12
        }
    }
}

output "storage_disk_group_moid" {
    value = intersight_storage_disk_group_policy.RAID6-Disk-Group.moid
}

# Define the storage policy
resource "intersight_storage_storage_policy" "server1-Storage" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "server1-Storage"
    retain_policy_virtual_drives = true
    unused_disks_state = "UnconfiguredGood"

    virtual_drives {
        name = "LOCAL_RAID6"
        disk_group_policy = intersight_storage_disk_group_policy.RAID6-Disk-Group.moid
        size = 0
        expand_to_available = true
        boot_drive = true
        access_policy = "ReadWrite"
        drive_cache = "Enable"
        io_policy = "Default"
        strip_size = "Default"
        read_policy = "Default"
        write_policy = "Default"
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.server1.moid
    }
}

output "storage_policy_moid" {
    value = intersight_storage_storage_policy.server1-Storage.moid
}
