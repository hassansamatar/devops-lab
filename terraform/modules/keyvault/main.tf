terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
  }
}

resource "azurerm_key_vault" "kv" {

  # checkov:skip=CKV_AZURE_109: Dev environment allows controlled public access for Terraform + Bastion workflow
  # checkov:skip=CKV_AZURE_189: Public endpoint required for current dev setup; private endpoint will be implemented later
  # checkov:skip=CKV2_AZURE_32: Private endpoint not implemented in current architecture iteration

  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # =========================
  # RBAC ONLY MODE
  # =========================
  rbac_authorization_enabled = true

  # =========================
  # SECURITY SETTINGS
  # =========================
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  # =========================
  # NETWORK CONFIG (DEV MODE)
  # =========================
  public_network_access_enabled = true

  tags = var.tags
}