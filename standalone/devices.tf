# Define the server devices here

# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/compute_rack_unit
data "intersight_compute_rack_unit" "standalone" {
  serial = var.standalone_sernum
}

output "standalone_compRack_moid" {
  value = data.intersight_compute_rack_unit.standalone.moid
}
