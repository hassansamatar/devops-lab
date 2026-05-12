#!/bin/bash
set -e

echo "🚀 Running full Terraform test suite..."

echo "➡️ Validation..."
bash validation/validate.sh

echo "➡️ Security scan..."
bash security/run-checkov.sh

echo "➡️ Linting..."
bash lint/run-tflint.sh

echo "✅ All tests passed successfully!"