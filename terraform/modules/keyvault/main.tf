# =========================================================
# Azure Key Vault
# =========================================================

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # OPTION A: Access Policy model (NOT RBAC)
  enable_rbac_authorization = false

  # Security & lifecycle settings
  soft_delete_retention_days = 7
  purge_protection_enabled    = false

  tags = var.tags
}