/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision an instance for iac development in its own network context
*/

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
}

module "vcn_iacbox" {
  source = "oracle-terraform-modules/vcn/oci"

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

module "instance_iacbox" {
  source = "oracle-terraform-modules/compute-instance/oci"
  # general oci parameters
  compartment_ocid = var.compartment_id
  # freeform_tags    = var.freeform_tags
  # defined_tags     = var.defined_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = var.instance_count
  instance_display_name       = var.instance_display_name
  shape                       = var.shape
  source_ocid                 = var.source_ocid
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs # only used if shape is Flex type
  instance_flex_ocpus         = var.instance_flex_ocpus         # only used if shape is Flex type
  # operating system parameters
  ssh_authorized_keys = var.ssh_authorized_keys
  user_data           = filebase64(var.user_data)
  # networking parameters
  assign_public_ip = var.assign_public_ip
  subnet_ocids     = [oci_core_subnet.vcn_iacbox_public.id] # var.subnet_ocids
  # storage parameters
  block_storage_sizes_in_gbs = [] # no block volume will be created
}
