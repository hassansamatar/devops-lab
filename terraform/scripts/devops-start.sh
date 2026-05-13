#!/bin/bash

# =========================================================
# DevOps Lab - Terraform Automation Script
# Azure + Terraform + WSL2
# =========================================================

set -euo pipefail

echo "🚀 Starting DevOps Terraform workflow..."

# =========================================================
# Resolve Paths
# =========================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(realpath "$SCRIPT_DIR/../environments/dev")"

# =========================================================
# Navigate to Terraform Environment
# =========================================================

cd "$TERRAFORM_DIR" || {
  echo "❌ ERROR: Cannot enter Terraform directory"
  exit 1
}

echo ""
echo "📁 Working directory:"
pwd

# =========================================================
# Verify Terraform Files
# =========================================================

if [[ ! -f main.tf ]]; then
  echo "❌ ERROR: main.tf not found"
  exit 1
fi

echo ""
echo "📦 Terraform configuration files:"
ls -1 *.tf

# =========================================================
# Azure Authentication
# =========================================================

echo ""
echo "🔐 Checking Azure authentication..."

if ! az account show >/dev/null 2>&1; then
  echo "⚠️ Azure session not found"
  echo "🔑 Starting Azure login..."

  az login --use-device-code \
    --tenant 18ed99ea-84ac-4738-b227-773da6b24321
fi

echo ""
echo "☁️ Active Azure Subscription:"
az account show --output table

# =========================================================
# Terraform Init
# =========================================================

echo ""
echo "⚙️ Initializing Terraform..."

terraform init -upgrade

# =========================================================
# Terraform Format
# =========================================================

echo ""
echo "🎨 Formatting Terraform files..."

terraform fmt -recursive

# =========================================================
# Terraform Validate
# =========================================================

echo ""
echo "🔍 Validating Terraform configuration..."

terraform validate

# =========================================================
# Optional TFLint
# =========================================================

if command -v tflint >/dev/null 2>&1; then
  echo ""
  echo "🧹 Running TFLint..."

  tflint
else
  echo ""
  echo "⚠️ TFLint not installed — skipping"
fi

# =========================================================
# Terraform State Check
# =========================================================

echo ""
echo "📦 Terraform state resources:"

terraform state list || echo "No resources found in state yet."

# =========================================================
# Terraform Plan
# =========================================================

echo ""
echo "📊 Generating Terraform plan..."

terraform plan -out=tfplan

# =========================================================
# Terraform Apply Confirmation
# =========================================================

echo ""
read -p "⚠️ Apply Terraform changes? (yes/no): " CONFIRM

if [[ "$CONFIRM" == "yes" ]]; then

    echo ""
    echo "🚀 Applying Terraform changes..."

    terraform apply tfplan

    echo ""
    echo "✅ Deployment completed successfully!"

else

    echo ""
    echo "❌ Terraform apply cancelled"

fi

# =========================================================
# Workflow Complete
# =========================================================

echo ""
echo "🎉 DevOps Terraform workflow finished!"