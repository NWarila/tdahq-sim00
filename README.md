# TDNHQ-SIM04

> Hero Wars Simulation Server — Infrastructure as Code via Terraform on Proxmox VE

[![Deploy](https://github.com/NWarila/tdnhq-sim04/actions/workflows/terraform.yml/badge.svg)](https://github.com/NWarila/tdnhq-sim04/actions/workflows/terraform.yml)
[![Security Scan](https://github.com/NWarila/tdnhq-sim04/actions/workflows/security.yml/badge.svg)](https://github.com/NWarila/tdnhq-sim04/actions/workflows/security.yml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/NWarila/tdnhq-sim04/badge)](https://securityscorecards.dev/viewer/?uri=github.com/NWarila/tdnhq-sim04)

## Overview

This repository contains the Terraform variable configuration for `tcnhq-sim04`, a Hero Wars
simulation server hosted on Proxmox VE. All deployments are executed through GitHub Actions
using [proxmox-terraform-framework](https://github.com/NWarila/proxmox-terraform-framework)
as the Terraform execution layer — no Terraform code lives here, only configuration.

## Architecture

```text
┌─────────────────────────┐
│   tdnhq-sim04 (this)    │  terraforms.tfvars
│   VM Configuration      │──────────────────────────────────┐
└─────────────────────────┘                                   │
                                                              ▼
                                              ┌───────────────────────────────┐
                                              │  proxmox-terraform-framework  │
                                              │  Terraform execution layer    │
                                              └───────────────┬───────────────┘
                                                              │ terraform apply
                                                              ▼
                                              ┌───────────────────────────────┐
                                              │  Proxmox VE (tcnhq-prxmx01)  │
                                              │  VM: tcnhq-sim04 [ID: 204]   │
                                              └───────────────────────────────┘
```

## VM Specification

| Property         | Value                    |
|------------------|--------------------------|
| **VM ID**        | 204                      |
| **Hostname**     | tcnhq-sim04              |
| **Node**         | tcnhq-prxmx01            |
| **Pool**         | svc-herowars-core        |
| **Template**     | rocky_linux_9_x64        |
| **IP Address**   | 10.69.12.24/24           |
| **Gateway**      | 10.69.12.1               |
| **CPU**          | 8 cores (host type)      |
| **Memory**       | 16 GB                    |
| **Disk**         | 100 GB (nvme-pool)       |
| **Machine Type** | q35 + OVMF (UEFI)        |

## Prerequisites

| Tool                                                                    | Version  | Purpose                    |
|-------------------------------------------------------------------------|----------|----------------------------|
| [pre-commit](https://pre-commit.com)                                    | ≥ 4.0.0  | Local hook runner          |
| [terraform](https://developer.hashicorp.com/terraform/install)          | ≥ 1.10   | HCL formatting             |
| [gitleaks](https://github.com/gitleaks/gitleaks)                        | ≥ 8.0    | Secret detection           |
| [yamllint](https://github.com/adrienverge/yamllint)                     | ≥ 1.35   | YAML linting               |

## Repository Structure

```text
tdnhq-sim04/
├── .config/
│   ├── .markdownlint.json       # Markdown linting rules
│   └── .yamllint.yaml           # YAML linting rules
├── .github/
│   ├── ISSUE_TEMPLATE/          # Bug report template
│   ├── workflows/
│   │   ├── terraform.yml        # Deploy workflow
│   │   ├── security.yml         # Trivy + gitleaks scanning
│   │   └── scorecard.yml        # OpenSSF Scorecard analysis
│   ├── CODEOWNERS               # Review enforcement
│   ├── dependabot.yml           # Automated Action updates
│   └── pull_request_template.md
├── .vscode/                     # Shared IDE settings
├── terraforms.tfvars            # VM configuration (committed)
├── terraforms.tfvars.nocommit   # Local overrides (git-ignored)
├── CONTRIBUTING.md
├── SECURITY.md
└── README.md
```

## Local Development

### Initial Setup

```bash
# Install pre-commit hooks
pre-commit install --install-hooks

# Verify all hooks pass
pre-commit run --all-files
```

### Making Configuration Changes

1. Edit `terraforms.tfvars` with your changes
2. Run `terraform fmt -recursive .` to format HCL
3. Run `pre-commit run --all-files` to validate
4. Commit using [Conventional Commits](https://www.conventionalcommits.org/) with scope:

   ```text
   fix(network): correct ipv4_prefix_length for network device
   feat(vm): increase cpu cores to 16
   ```

5. Push to `main` — GitHub Actions deploys automatically

### Local Overrides

Copy `terraforms.tfvars` to `terraforms.tfvars.nocommit` for local testing.
This file is git-ignored and will never be committed.

### VSCode Tasks

Press `Ctrl+Shift+B` to run Full Validation (format → lint → pre-commit).
Individual tasks are available via `Terminal → Run Task`.

## Deployment

Deployments trigger automatically on push to `main` via the
[Deploy workflow](.github/workflows/terraform.yml). The workflow:

1. Assumes an AWS OIDC role for S3 state backend access
2. Checks out this repo and the Terraform framework
3. Copies `terraforms.tfvars` into the framework
4. Runs `terraform init → validate → plan → apply`

State is stored in S3 at `tdnhq-sim04/terraform.tfstate`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Security

See [SECURITY.md](SECURITY.md). Do not open public issues for security vulnerabilities.

## License

[MIT](LICENSE)
