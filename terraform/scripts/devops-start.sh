#!/bin/bash

set -euo pipefail  # strict mode (best practice)

echo "🚀 Starting DevOps Terraform environment..."

# -----------------------------------
# 1. Navigate to Terraform dev environment (FIXED + SAFE)
# -----------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(realpath "$SCRIPT_DIR/../environments/dev")"

cd "$TERRAFORM_DIR" || {
  echo "❌ ERROR: Cannot enter Terraform directory: $TERRAFORM_DIR"
  exit 1
}

echo "📁 Terraform working directory: $(pwd)"

# Safety check: ensure Terraform files exist
if [[ ! -f main.tf ]]; then
  echo "❌ ERROR: main.tf not found in $TERRAFORM_DIR"
  exit 1
fi

echo "📦 Terraform files found:"
ls -1 *.tf

# -----------------------------------
# 2. Azure Login
# -----------------------------------
echo "🔐 Logging into Azure..."
az login --use-device-code --tenant 18ed99ea-84ac-4738-b227-773da6b24321

echo "☁️ Active Azure subscription:"
az account show

# -----------------------------------
# 3. Terraform Init
# -----------------------------------
echo "⚙️ Initializing Terraform..."
terraform init -upgrade

# -----------------------------------
# 4. Format & Validate
# -----------------------------------
echo "🎨 Formatting Terraform files..."
terraform fmt -recursive

echo "🔍 Validating Terraform configuration..."
terraform validate

# -----------------------------------
# 5. State Check (safe)
# -----------------------------------
echo "📦 Terraform state resources:"
terraform state list || echo "No resources found in state yet."

# -----------------------------------
# 6. Plan
# -----------------------------------
echo "📊 Generating Terraform plan..."
terraform plan -out=tfplan

# -----------------------------------
# 7. Apply Confirmation
# -----------------------------------
echo ""
read -p "⚠️ Do you want to apply this plan? (yes/no): " CONFIRM

if [[ "$CONFIRM" == "yes" ]]; then
    echo "🚀 Applying Terraform changes..."
    terraform apply tfplan
    echo "✅ Deployment completed successfully!"
else
    echo "❌ Apply cancelled by user."
fi

# -----------------------------------
# Done
# -----------------------------------
echo "🎉 DevOps environment finished!"