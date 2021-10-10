# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [0.5.0] - unreleased

### Added

Bootstrap.sh installs new tools:

- project_o : a smart oci-cli wrapper
- GitHub cli
- full HashiCorp stack: Packer, Terraform, Consul, Vault, Nomad

### Changed

- Base image OCID is now dynamically retrieved, using the latest available version for the operating system family

## [0.4.0] - 2021-10-09

### Added

Bootstrap.sh installs new programming language and tools:

- Go 1.17.2
- pre-commit 2.15.0 : A framework for managing and maintaining multi-language Git pre-commit hooks.
- terraform-docs 0.16.0 : Generate Terraform modules documentation in various formats

### Changed

- pre-commit now use the official hook from the terraform-docs Github repo

## [0.3.0] - 2021-10-08

### Added

- add a reserved Public IP to instance

## [0.2.1] - 2021-10-08

### Changed

- Compute module bumped to v2.2.0

## [0.2.0] - 2021-10-06

### Changed

- Compute module bumped to v2.2.0-RC1

### Added

Terraform Cloud compatibility: sensitive variables are passed as string in the TF Cloud workspace

- add `var.private_key`
- add `var.ssh_public_key`

## [0.1.1] - 2021-10-06

Initial release.

Deploys a vcn with a public subnet, and a Linux 8 instance on ARM. The instance comes with these tools installed:

- Terraform
- Packer
- Ansible, oracle.oci collection and usefull roles
- oci-cli
- Python virtualenvwrapper, oci sdkx
