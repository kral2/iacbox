# 2021-10-13

## New features

`Bootstrap.sh` installs new and tooling:

- project_o : a smart oci-cli wrapper
- GitHub cli
- full HashiCorp stack: Packer, Terraform, Consul, Vault, Nomad, Boundary, Waypoint
- container tooling (podman)

## Changes

- Hashistack-installer bumped to v0.3.1
- Base image OCID is now dynamically retrieved, using the latest available version for the operating system family
