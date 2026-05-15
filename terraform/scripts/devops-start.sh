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

if ! az account show >/dev/null 2>&1 || ! az account get-access-token >/dev/null 2>&1; then
  echo "⚠️ Azure session not found or expired"
  echo "🔑 Starting Azure login..."

  az login --use-device-code \
    --tenant 18ed99ea-84ac-4738-b227-773da6b24321
fi

echo ""
echo "☁️ Active Azure Subscription:"
az account show --output table

# =========================================================
# 🔁 Auto‑update admin_ip in terraform.tfvars
# =========================================================

TFVARS_FILE="terraform.tfvars"
if [[ -f "$TFVARS_FILE" ]]; then
    echo ""
    echo "🌐 Fetching your current public IP address..."
    CURRENT_IP=$(curl -s ifconfig.me)

    if [[ -z "$CURRENT_IP" ]]; then
        echo "⚠️ WARNING: Could not detect public IP. Skipping auto‑update."
    else
        echo "   Detected IP: $CURRENT_IP"
        # Build the new line with /32 CIDR
        NEW_ADMIN_IP="admin_ip = \"${CURRENT_IP}/32\""
        
        # Check if admin_ip line already exists
        if grep -q "^admin_ip[[:space:]]*=" "$TFVARS_FILE"; then
            # Replace the existing line
            sed -i "s/^admin_ip[[:space:]]*=.*/${NEW_ADMIN_IP}/" "$TFVARS_FILE"
        else
            # Append at the end of the network section (or end of file)
            echo "$NEW_ADMIN_IP" >> "$TFVARS_FILE"
        fi
        echo "✅ Updated $TFVARS_FILE with current IP."
        # Show the change (optional)
        grep "^admin_ip" "$TFVARS_FILE"
    fi
else
    echo ""
    echo "⚠️ $TFVARS_FILE not found. Skipping IP auto‑update."
fi

# =========================================================
# Terraform Init
# =========================================================

echo ""
echo "⚙️ Initializing Terraform..."

terraform init -upgrade -input=false

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
echo "📦 Terraform state resources..."

terraform state list || echo "No resources found in state yet."

# =========================================================
# Terraform Plan
# =========================================================

echo ""
echo "📊 Generating Terraform plan..."

PLAN_FILE="tfplan-$(date +%Y%m%d-%H%M%S)"
terraform plan -out="$PLAN_FILE"

# =========================================================
# Apply Confirmation
# =========================================================

echo ""
read -p "⚠️ Apply Terraform changes? (yes/no): " CONFIRM

if [[ "$CONFIRM" == "yes" ]]; then

    if [[ ! -f "$PLAN_FILE" ]]; then
        echo "❌ ERROR: Plan file not found"
        exit 1
    fi

    echo ""
    echo "🚀 Applying Terraform changes..."

    terraform apply "$PLAN_FILE"

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