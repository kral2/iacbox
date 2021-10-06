/*
Last update : February, 2021
Author: cetin.ardal@oracle.com
Description: current config outputs will be printed after plan and apply.
*/

output "instance_iacbox" {
  description = "ocid of created instances."
  value       = module.instance_iacbox.instances_summary
}
