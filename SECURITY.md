# Security Policy

## Supported Versions

Only the latest commit on the `main` branch is actively maintained.

## Reporting a Vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Report vulnerabilities privately via
[GitHub Security Advisories](https://github.com/NWarila/tdnhq-sim04/security/advisories/new).

Please include:

- A description of the vulnerability
- The affected component (workflow, configuration, tooling)
- Steps to reproduce
- Suggested remediation if known

**Response timeline:** acknowledgement within 48 hours, assessment within 5 business days.

## Security Controls

| Control          | Tool / Mechanism                              |
|------------------|-----------------------------------------------|
| Secret detection | gitleaks (pre-commit + CI)                    |
| IaC scanning     | Trivy (CI, weekly schedule)                   |
| Dependencies     | Dependabot (GitHub Actions weekly updates)    |
| Code review      | CODEOWNERS — all changes require approval     |
| Credentials      | GitHub Actions secrets — never in source      |
| State encryption | S3 backend with `encrypt=true`                |

## Scope

**In scope:** secrets committed to source, insecure workflow permissions,
misconfigured Proxmox/cloud-init settings that expose credentials or attack surface.

**Out of scope:** vulnerabilities in third-party tools (Terraform, Proxmox, Rocky Linux)
— report those upstream.
