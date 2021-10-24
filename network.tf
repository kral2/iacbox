/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision network context for iacbox instance
*/

module "vcn_iacbox" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.0.0"

  # general oci parameters
  compartment_id = var.compartment_id

  # vcn parameters
  create_drg               = false           # boolean: true or false
  create_internet_gateway  = true            # boolean: true or false
  lockdown_default_seclist = false           # boolean: true or false
  create_nat_gateway       = false           # boolean: true or false
  create_service_gateway   = false           # boolean: true or false
  vcn_cidrs                = ["10.0.0.0/16"] # List of IPv4 CIDRs
  vcn_dns_label            = "iac"
  vcn_name                 = "iac"
}

resource "oci_core_subnet" "vcn_iacbox_public" {
  #Required
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_iacbox.vcn_id

  #Optional
  display_name               = "public"
  dns_label                  = "public"
  prohibit_public_ip_on_vnic = false
  route_table_id             = module.vcn_iacbox.ig_route_id
}
