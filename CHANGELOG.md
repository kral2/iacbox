# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

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
- Python virtualenvwrapper, oci sdk
