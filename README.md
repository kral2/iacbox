# IACBOX

## provision an instance for iac development on oci

[![release](https://img.shields.io/github/v/release/kral2/iacbox?colorB=2067b8)](https://github.com/kral2/iacbox/releases)
[![bash](https://img.shields.io/badge/language-bash-89e051.svg?style=flat-square)](https://github.com/kral2/iacbox)
[![hcl](https://img.shields.io/badge/language-hcl-89e051.svg?style=flat-square)](https://github.com/kral2/iacbox)
[![license](https://img.shields.io/github/license/kral2/iacbox?colorB=2067b8)](https://github.com/kral2/iacbox/blob/main/LICENSE)

## Table of Contents

1. [About](#about)
2. [Requirements](#requirements)
3. [Providers](#Providers)
4. [Inputs](#inputs)
5. [Outputs](#outputs)

## About

![diagram](https://github.com/kral2/iacbox/blob/main/files/images/iacbox_about.png?raw=true&sanitize=true)

This module deploys an instance with the necessary tools to start developing Infrastructure as Code solutions on OCI.

General development tooling:

- Git, pre-commit and the GitHub cli
- Python virtualenvwrapper
- Go
- container tooling

IaC tooling:

- HashiCorp Stack: Packer, Terraform, Consul, Vault, Nomad
- terraform-docs
- Ansible and with useful community roles

OCI related tooling and SDKs:

- oci-cli and its smart wrapper `o`
- OCI Python SDK
- ansible-oci collection

This is the deployed infrastructure:

![diagram](https://github.com/kral2/iacbox/blob/main/files/images/deployed_infrastructure.png?raw=true&sanitize=true)

The module also create an OCI Dynamic-Group and the associated OCI Policy to grant API `manage` authorization to the iacbox instance over the instance's compartment.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >=4.40.0 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_iacbox"></a> [instance\_iacbox](#module\_instance\_iacbox) | oracle-terraform-modules/compute-instance/oci | 2.3.0 |
| <a name="module_vcn_iacbox"></a> [vcn\_iacbox](#module\_vcn\_iacbox) | oracle-terraform-modules/vcn/oci | 3.0.0 |
## Resources

| Name | Type |
|------|------|
| [oci_core_subnet.vcn_iacbox_public](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
| [oci_identity_dynamic_group.iacbox](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_dynamic_group) | resource |
| [oci_identity_policy.dynamic_group_iacbox](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_policy) | resource |
| [oci_core_images.images](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_images) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_storage_sizes_in_gbs"></a> [block\_storage\_sizes\_in\_gbs](#input\_block\_storage\_sizes\_in\_gbs) | Sizes of volumes to create and attach to each instance. | `list(string)` | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | compartment ocid where to create all resources | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | predefined and scoped to a namespace to tag the resources created using defined tags. | `map(string)` | `null` | no |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | n/a | `string` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | simple key-value pairs to tag the resources created using freeform tags. | `map(string)` | `null` | no |
| <a name="input_instance_ad_number"></a> [instance\_ad\_number](#input\_instance\_ad\_number) | The availability domain number of the instance. If none is provided, it will start with AD-1 and continue in round-robin. | `number` | `1` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of identical instances to launch from a single module. | `number` | `1` | no |
| <a name="input_instance_display_name"></a> [instance\_display\_name](#input\_instance\_display\_name) | (Updatable) A user-friendly name for the instance. Does not have to be unique, and it's changeable. | `string` | `"iacbox"` | no |
| <a name="input_instance_flex_memory_in_gbs"></a> [instance\_flex\_memory\_in\_gbs](#input\_instance\_flex\_memory\_in\_gbs) | (Updatable) The total amount of memory available to the instance, in gigabytes. | `number` | `6` | no |
| <a name="input_instance_flex_ocpus"></a> [instance\_flex\_ocpus](#input\_instance\_flex\_ocpus) | (Updatable) The total number of OCPUs available to the instance. | `number` | `1` | no |
| <a name="input_instance_state"></a> [instance\_state](#input\_instance\_state) | (Updatable) The target state for the instance. Could be set to RUNNING or STOPPED. | `string` | `"STOPPED"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | n/a | `string` | `null` | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | n/a | `string` | `null` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Whether to create a Public IP to attach to primary vnic and which lifetime. Valid values are NONE, RESERVED or EPHEMERAL. | `string` | `"RESERVED"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_shape"></a> [shape](#input\_shape) | The shape of an instance. | `string` | `"VM.Standard.A1.Flex"` | no |
| <a name="input_source_ocid"></a> [source\_ocid](#input\_source\_ocid) | The OCID of an image or a boot volume to use, depending on the value of source\_type. | `string` | `null` | no |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | The source type for the instance. | `string` | `"image"` | no |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | Public SSH keys to be included in the ~/.ssh/authorized\_keys file for the default user on the instance. To provide multiple keys, see docs/instance\_ssh\_keys.adoc. | `string` | `null` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | n/a | `string` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Provide your own base64-encoded data to be used by Cloud-Init to run custom scripts or provide custom Cloud-Init configuration. | `string` | `null` | no |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | n/a | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_iacbox"></a> [instance\_iacbox](#output\_instance\_iacbox) | ocid of created instances. |

<!-- END_TF_DOCS -->