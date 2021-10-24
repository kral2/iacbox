/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision an instance for iac development in its own network context
*/

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
}

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

module "instance_iacbox" {
  source  = "kral2/compute-instance/oci"
  version = "2.3.0-RC1"

  # general oci parameters
  compartment_ocid = var.compartment_id
  freeform_tags    = var.freeform_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = var.instance_count
  instance_display_name       = var.instance_display_name
  instance_state              = var.instance_state
  shape                       = var.shape
  source_ocid                 = data.oci_core_images.images.images[0].id
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs # only used if shape is Flex type
  instance_flex_ocpus         = var.instance_flex_ocpus         # only used if shape is Flex type
  # operating system parameters
  ssh_public_keys = var.ssh_public_keys
  user_data       = filebase64(var.user_data)
  # networking parameters
  public_ip    = var.public_ip
  subnet_ocids = [oci_core_subnet.vcn_iacbox_public.id] # var.subnet_ocids
  # storage parameters
  block_storage_sizes_in_gbs = [] # no block volume will be created
}

data "oci_core_images" "images" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  # display_name = var.image_display_name
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}