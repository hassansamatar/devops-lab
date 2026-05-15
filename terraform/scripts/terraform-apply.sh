#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

ENVIRONMENT="${1:-${TF_ENV:-dev}}"
CLOUD="${2:-${TF_CLOUD:-azure}}"
WORK_DIR="${TERRAFORM_DIR}/environments/${ENVIRONMENT}"
PLAN_FILE="${TERRAFORM_DIR}/.plans/${CLOUD}-${ENVIRONMENT}.tfplan"
TFVARS_FILE="${WORK_DIR}/terraform.tfvars"
CI_TFVARS_FILE="${WORK_DIR}/ci.tfvars.json"
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

BACKEND_CONFIG_ARGS=()
if [ -n "${ARM_TENANT_ID:-}" ]; then
	BACKEND_CONFIG_ARGS+=("-backend-config=tenant_id=${ARM_TENANT_ID}")
fi
if [ -n "${ARM_SUBSCRIPTION_ID:-}" ]; then
	BACKEND_CONFIG_ARGS+=("-backend-config=subscription_id=${ARM_SUBSCRIPTION_ID}")
fi
if [ -n "${ARM_CLIENT_ID:-}" ]; then
	BACKEND_CONFIG_ARGS+=("-backend-config=client_id=${ARM_CLIENT_ID}")
fi
BACKEND_CONFIG_ARGS+=("-backend-config=use_oidc=true")
BACKEND_CONFIG_ARGS+=("-backend-config=use_azuread_auth=true")

terraform init -input=false "${BACKEND_CONFIG_ARGS[@]}"

TFVARS_ARGS=()
if [ -f "${TFVARS_FILE}" ]; then
	TFVARS_ARGS+=("-var-file=${TFVARS_FILE}")
elif [ -f "${CI_TFVARS_FILE}" ]; then
	TFVARS_ARGS+=("-var-file=${CI_TFVARS_FILE}")
fi

echo "Running Terraform apply"
echo "  cloud: ${CLOUD}"
echo "  env:   ${ENVIRONMENT}"

if [ -f "${PLAN_FILE}" ]; then
	echo "Applying saved plan: ${PLAN_FILE}"
	terraform apply -input=false "${PLAN_FILE}"
else
	echo "No saved plan found, applying current configuration."
	if [ "${AUTO_APPROVE}" = "true" ]; then
		terraform apply -input=false -auto-approve "${TFVARS_ARGS[@]}"
	else
		terraform apply -input=false "${TFVARS_ARGS[@]}"
	fi
fi
