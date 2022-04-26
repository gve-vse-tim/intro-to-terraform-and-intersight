# Define Adapter Configuration policy for standalone
resource "intersight_adapter_config_policy" "standalone-Networking" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "standalone-Networking"

    # First Adapter
    settings {
        slot_id = "MLOM"

        # Ethernet Settings
        eth_settings {
            lldp_enabled = true
        }

        # FC Settings
        fc_settings {
            fip_enabled = false
        }

        # PC Settings
        port_channel_settings {
            enabled = false
        }

        # Default DCE settings
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 0
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 1
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 2
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 3
        }
    }

    # Second Adapter
    settings {
        slot_id = "2"

        # Ethernet Settings
        eth_settings {
            lldp_enabled = true
        }

        # FC Settings
        fc_settings {
            fip_enabled = false
        }

        # PC Settings
        port_channel_settings {
            enabled = false
        }

        # Default DCE settings
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 0
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 1
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 2
        }
        dce_interface_settings {
            fec_mode = "Off"
            interface_id = 3
        }
    }

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "adapter_config_moid" {
    value = intersight_adapter_config_policy.standalone-Networking.moid
}

# Configure Default Ethernet adapter settings
resource "intersight_vnic_eth_adapter_policy" "Default-Ethernet" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "Default-Ethernet"

    interrupt_scaling = false
    advanced_filter = false

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

    # Defaults
    uplink_failback_timeout = 5

    completion_queue_settings {
        nr_count = 5
    }

    interrupt_settings {
        nr_count = 8
        coalescing_time = 125
        coalescing_type = "MIN"
        mode = "MSIx"
    }

    rss_settings = true

    rss_hash_settings {
        ipv4_hash = true
        ipv6_ext_hash = false
        ipv6_hash = true
        tcp_ipv4_hash = true
        tcp_ipv6_ext_hash = false
        tcp_ipv6_hash = true
        udp_ipv4_hash = false
        udp_ipv6_hash = false
    }

    rx_queue_settings {
        nr_count = 4
        ring_size = 512
    }

    tx_queue_settings{
        nr_count = 1
        ring_size = 256
    }

    tcp_offload_settings {
        large_receive = true
        large_send = true
        rx_checksum = true
        tx_checksum = true
    }
}

output "eth_adapter_policy_moid" {
    value = intersight_vnic_eth_adapter_policy.Default-Ethernet.moid
}

# Define Ethernet vNIC QoS Policy with MTU 1500
resource "intersight_vnic_eth_qos_policy" "Default-QoS-MTU1500" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "Default-QoS-MTU1500"
    mtu = 1500
    cos = 0
    rate_limit = 0
    priority = "Best Effort"
    trust_host_cos = false
}

output "eth_qos_policy_moid" {
    value = intersight_vnic_eth_qos_policy.Default-QoS-MTU1500.moid
}

# Define Ethernet vNIC network policy - trunks
resource "intersight_vnic_eth_network_policy" "Trunk-Native0" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "Terraform deployed"
    name = "Trunk-Native0"
    target_platform = "Standalone"

    vlan_settings {
        default_vlan = 0
        mode = "TRUNK"
    }
}

output "eth_ntwk_policy_moid" {
    value = intersight_vnic_eth_network_policy.Trunk-Native0.moid
}

# Define the LAN vNICs for standalone - MLOM eth0
resource "intersight_vnic_eth_if" "MLOM_eth0" {
    name = "eth0"
    order = 0

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "VIC-MLOM-eth0"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.standalone-DirectPorts.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.Default-Ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.Trunk-Native0.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.Default-QoS-MTU1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

resource "intersight_vnic_eth_if" "MLOM_eth1" {
    name = "eth1"
    order = 1

    placement {
        id = "MLOM"
        pci_link = 0
        uplink = 1
    }

    cdn {
        nr_source = "user"
        value = "VIC-MLOM-eth1"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.standalone-DirectPorts.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.Default-Ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.Trunk-Native0.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.Default-QoS-MTU1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

resource "intersight_vnic_eth_if" "PCI_slot2_eth0" {
    name = "eth0"
    order = 0

    placement {
        id = "2"
        pci_link = 0
        uplink = 0
    }

    cdn {
        nr_source = "user"
        value = "VIC-2-eth0"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.standalone-DirectPorts.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.Default-Ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.Trunk-Native0.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.Default-QoS-MTU1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

resource "intersight_vnic_eth_if" "PCI_slot2_eth1" {
    name = "eth1"
    order = 1

    placement {
        id = "2"
        pci_link = 0
        uplink = 1
    }

    cdn {
        nr_source = "user"
        value = "VIC-2-eth1"
    }

    lan_connectivity_policy {
        moid = intersight_vnic_lan_connectivity_policy.standalone-DirectPorts.moid
    }

    eth_adapter_policy {
        moid = intersight_vnic_eth_adapter_policy.Default-Ethernet.moid
    }

    eth_network_policy {
        moid = intersight_vnic_eth_network_policy.Trunk-Native0.moid
    }

    eth_qos_policy {
        moid = intersight_vnic_eth_qos_policy.Default-QoS-MTU1500.moid
    }

    usnic_settings{
        nr_count = 0
        cos = 5
    }

    vmq_settings {
        enabled = false
        multi_queue_support = false
        num_interrupts = 16
        num_sub_vnics = 64
        num_vmqs = 4
    }
}

# Define the LAN Connectivity policy
resource "intersight_vnic_lan_connectivity_policy" "standalone-DirectPorts" {
    organization {
        moid = intersight_organization_organization.target.moid
    }

    description = "1:1 mapping of vNIC to external port for MLOM and PCIe Slot 2 - Terraform deployed"
    name = "standalone-DirectPorts"
    target_platform = "Standalone"
    placement_mode = "custom"

    profiles {
        object_type = "server.Profile"
        moid = intersight_server_profile.standalone.moid
    }
}

output "lcp_moid" {
    value = intersight_vnic_lan_connectivity_policy.standalone-DirectPorts.moid
}
