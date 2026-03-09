# Contributing

## Getting Started

1. Fork the repository and create a feature branch from `main`
2. Install pre-commit hooks: `pre-commit install --install-hooks`
3. Make your changes to `terraforms.tfvars`
4. Validate locally before pushing (see below)
5. Open a pull request against `main`

## Validation

Run the full validation suite before committing:

```bash
# Format HCL
terraform fmt -recursive .

# Run all pre-commit hooks
pre-commit run --all-files
```

Or use the VSCode task: `Ctrl+Shift+B`

## Commit Messages

This repository follows [Conventional Commits](https://www.conventionalcommits.org/).
The pre-commit hook will enforce this on `commit-msg`.

### Types

| Type       | When to use                                    |
|------------|------------------------------------------------|
| `feat`     | New VM parameter or feature                    |
| `fix`      | Correcting a misconfiguration                  |
| `ci`       | Workflow / pipeline changes                    |
| `docs`     | Documentation only                             |
| `refactor` | Restructuring without functional change        |
| `chore`    | Tooling, dependency updates, maintenance       |
| `security` | Security-related changes                       |

### Scopes

Scopes are optional but encouraged — they narrow the area of change and improve
changelog readability.

| Scope      | When to use                                    |
|------------|------------------------------------------------|
| `vm`       | Core VM parameters (CPU, memory, machine type) |
| `network`  | Network device configuration                   |
| `storage`  | Disk, datastore, or initialization settings    |
| `ci`       | GitHub Actions workflow changes                |
| `security` | Security tooling or policy changes             |
| `deps`     | Dependency or action version bumps             |
| `docs`     | Documentation files only                       |

### Examples

```
feat(vm): increase cpu cores to 16
fix(network): correct ipv4_prefix_length field name
fix(storage): set correct datastore_id for cloud-init drive
ci(security): pin all action versions to commit SHA
chore(deps): bump trivy-action to 0.35.0
docs: update VM specification table in README
```

## Pull Request Guidelines

- Keep PRs focused — one logical change per PR
- Ensure `pre-commit run --all-files` passes
- Never commit `terraforms.tfvars.nocommit` or any file containing secrets
- Update the README if you change configuration structure

## Sensitive Files

`terraforms.tfvars.nocommit` is git-ignored intentionally.
All secrets are managed via GitHub Actions secrets — never hardcode credentials.
