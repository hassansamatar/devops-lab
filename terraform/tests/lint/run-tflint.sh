#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TERRAFORM_DIR="$(cd "${TESTS_DIR}/.." && pwd)"

ENVIRONMENT="${1:-${TF_ENV:-dev}}"
ENV_DIR="${TERRAFORM_DIR}/environments/${ENVIRONMENT}"

if ! command -v tflint >/dev/null 2>&1; then
	echo "ERROR: tflint is not installed or not on PATH."
	exit 1
fi

if [ ! -d "${ENV_DIR}" ]; then
	echo "ERROR: environment directory not found: ${ENV_DIR}"
	exit 1
fi

echo "Initializing tflint plugins"
tflint --init

echo "Linting environment: ${ENVIRONMENT}"
tflint --chdir "${ENV_DIR}"

echo "Linting modules"
for module_dir in "${TERRAFORM_DIR}"/modules/*; do
	[ -d "${module_dir}" ] || continue
	if ls "${module_dir}"/*.tf >/dev/null 2>&1; then
		echo "  - $(basename "${module_dir}")"
		tflint --chdir "${module_dir}"
	fi
done

echo "Lint completed successfully."
