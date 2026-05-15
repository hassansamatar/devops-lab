terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
  }
}

# =========================================================
# AZURE KEY VAULT (RBAC ENABLED)
# =========================================================

resource "azurerm_key_vault" "kv" {
  #checkov:skip=CKV_AZURE_189:Dev environment keeps public endpoint enabled with IP firewall to allow Terraform runner access.
  #checkov:skip=CKV2_AZURE_32:Private endpoint is planned for shared private DNS rollout in next network iteration.
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # =====================================================
  # RBAC MODE (MODERN BEST PRACTICE)
  # =====================================================
  rbac_authorization_enabled = true

  # =====================================================
  # SECURITY SETTINGS
  # =====================================================
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = var.key_vault_allowed_ip_rules
  }

  # Public endpoint is IP-restricted by firewall rules above.
  public_network_access_enabled = true

  tags = var.tags
}