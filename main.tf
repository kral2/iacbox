/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision an instance for iac development in its own network context
*/

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
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
  extended_metadata = {
    tenancy_id     = var.tenancy_ocid
    compartment_id = var.compartment_id
  }
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