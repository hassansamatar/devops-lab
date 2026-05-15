#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENVIRONMENT="${1:-${TF_ENV:-dev}}"

echo "Running full Terraform test suite"
echo "Environment: ${ENVIRONMENT}"

echo "Step 1/3: Validation"
bash "${SCRIPT_DIR}/validation/validate.sh" "${ENVIRONMENT}"

echo "Step 2/3: Security scan"
bash "${SCRIPT_DIR}/security/run-checkov.sh"

echo "Step 3/3: Linting"
bash "${SCRIPT_DIR}/lint/run-tflint.sh" "${ENVIRONMENT}"

echo "All Terraform tests passed."