# 2021-10-09

## New features

`Bootstrap.sh` installs new programming language and tooling:

- Go 1.17.2
- pre-commit (latest): A framework for managing and maintaining multi-language Git pre-commit hooks.
- terraform-docs (latest) : Generate Terraform modules documentation in various formats

## Changes

- pre-commit now use the official hook from the terraform-docs Github repo to generate the README
- Ansible is now installed using pip to get more recent versions. Current version: 2.11
