# Define the server devices here

# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/compute_rack_unit
data "intersight_compute_rack_unit" "server1" {
    serial = "SERIAL_NUMBER"
}

output "server1_compRack_moid" {
    value = data.intersight_compute_rack_unit.server1.moid
}
