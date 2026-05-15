#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TERRAFORM_DIR="$(cd "${TESTS_DIR}/.." && pwd)"

if ! command -v checkov >/dev/null 2>&1; then
	echo "ERROR: checkov is not installed or not on PATH."
	exit 1
fi

echo "Running Checkov scan against Terraform code"
checkov -d "${TERRAFORM_DIR}" --framework terraform

echo "Security scan completed successfully."
