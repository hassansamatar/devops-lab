#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${TERRAFORM_DIR}/.." && pwd)"

ENVIRONMENT="${1:-${TF_ENV:-dev}}"
CLOUD="${2:-${TF_CLOUD:-azure}}"
WORK_DIR="${TERRAFORM_DIR}/environments/${ENVIRONMENT}"
PLAN_DIR="${TERRAFORM_DIR}/.plans"
PLAN_FILE="${PLAN_DIR}/${CLOUD}-${ENVIRONMENT}.tfplan"

if ! command -v terraform >/dev/null 2>&1; then
	echo "ERROR: terraform is not installed or not on PATH."
	exit 1
fi

if [ ! -d "${WORK_DIR}" ]; then
	echo "ERROR: environment directory not found: ${WORK_DIR}"
	exit 1
fi

mkdir -p "${PLAN_DIR}"

echo "Running Terraform plan"
echo "  cloud: ${CLOUD}"
echo "  env:   ${ENVIRONMENT}"
echo "  dir:   ${WORK_DIR}"

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
if [ -n "${ARM_CLIENT_SECRET:-}" ]; then
	BACKEND_CONFIG_ARGS+=("-backend-config=client_secret=${ARM_CLIENT_SECRET}")
fi
BACKEND_CONFIG_ARGS+=("-backend-config=use_azuread_auth=true")

# Keep formatting consistent across modules and environments before planning.
terraform fmt -check -recursive "${REPO_ROOT}/terraform"
terraform init -input=false "${BACKEND_CONFIG_ARGS[@]}"
terraform validate
terraform plan -input=false -out="${PLAN_FILE}"

echo "Plan file generated: ${PLAN_FILE}"
