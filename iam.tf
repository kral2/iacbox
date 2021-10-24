/*
Last update : October, 2021
Author: cetin.ardal@oracle.com
Description: provision iam context for iacbox instance
*/

resource "oci_identity_dynamic_group" "iacbox" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "dynamic group for iacbox compute instance"
  matching_rule  = "instance.id = '${module.instance_iacbox.instance_id[0]}'"
  name           = "iacbox_instance"
}

resource "oci_identity_policy" "dynamic_group_iacbox" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "dynamic-group iacbox manage all-resources in tenancy"
  name           = "iacbox_tenancy_admin"
  statements     = local.iacbox_policy_statements
}

locals {
  iacbox_policy_statements = [
    "Allow dynamic-group ${oci_identity_dynamic_group.iacbox.name} to manage all-resources in tenancy"
  ]
}
