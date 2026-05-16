# Pipeline Trigger Cheat Sheet

This page explains exactly when each GitHub Actions workflow in this repository runs.

## Current Workflows

- Terraform Plan: `.github/workflows/terraform-plan.yml`
- Terraform Apply: `.github/workflows/terraform-apply.yml`

## Trigger Matrix

| Workflow | Trigger Type | When It Runs | Will README-only commit run it? |
| --- | --- | --- | --- |
| Terraform Plan | `pull_request` with path filters | PR changes include `terraform/**` or `.github/workflows/terraform-plan.yml` | No |
| Terraform Apply | `workflow_dispatch` | Manual run from GitHub Actions UI with inputs | No |

## Quick Rules

1. Pushing commits directly to `main` does not run Terraform Plan in the current setup.
2. Terraform Plan runs from Pull Requests only, and only when matching paths change.
3. Terraform Apply never auto-runs. You must manually trigger it.
4. README or docs-only commits do not trigger either workflow.

## What To Do For Common Cases

### I changed Terraform code and want a plan run

1. Create a branch.
2. Commit and push changes.
3. Open a Pull Request.
4. Ensure changed files are under `terraform/` (or include the plan workflow file).

### I want to apply infrastructure changes

1. Open the Actions tab in GitHub.
2. Select Terraform Apply workflow.
3. Click Run workflow.
4. Choose inputs (environment and cloud).
5. Start the run.

### I changed only README or docs and want CI signal

- In current configuration, no Terraform workflow runs.
- If needed later, add a dedicated docs workflow or broaden plan triggers.

## Fast Validation Checklist

- Did I open a Pull Request?
- Did I change a file under `terraform/`?
- Did I manually run Terraform Apply when needed?
- Am I expecting a run from docs-only changes (which currently do not trigger)?

## Related Docs

- `docs/devops/azure-devops-pipelines.md`
- `docs/devops/github-actions.md`
