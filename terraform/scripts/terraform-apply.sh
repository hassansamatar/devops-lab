#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

ENVIRONMENT="${1:-${TF_ENV:-dev}}"
CLOUD="${2:-${TF_CLOUD:-azure}}"
WORK_DIR="${TERRAFORM_DIR}/environments/${ENVIRONMENT}"
PLAN_FILE="${TERRAFORM_DIR}/.plans/${CLOUD}-${ENVIRONMENT}.tfplan"
AUTO_APPROVE="${TF_AUTO_APPROVE:-false}"

if ! command -v terraform >/dev/null 2>&1; then
	echo "ERROR: terraform is not installed or not on PATH."
	exit 1
fi

if [ ! -d "${WORK_DIR}" ]; then
	echo "ERROR: environment directory not found: ${WORK_DIR}"
	exit 1
fi

cd "${WORK_DIR}"
terraform init -input=false

echo "Running Terraform apply"
echo "  cloud: ${CLOUD}"
echo "  env:   ${ENVIRONMENT}"

if [ -f "${PLAN_FILE}" ]; then
	echo "Applying saved plan: ${PLAN_FILE}"
	terraform apply -input=false "${PLAN_FILE}"
else
	echo "No saved plan found, applying current configuration."
	if [ "${AUTO_APPROVE}" = "true" ]; then
		terraform apply -input=false -auto-approve
	else
		terraform apply -input=false
	fi
fi
