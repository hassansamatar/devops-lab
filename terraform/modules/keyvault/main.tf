# =========================================================
# AZURE KEY VAULT
# =========================================================

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # RBAC MODE (recommended for DevOps pipelines)
  enable_rbac_authorization = true

  soft_delete_retention_days = 7
  purge_protection_enabled    = false

  public_network_access_enabled = true

  tags = var.tags
}