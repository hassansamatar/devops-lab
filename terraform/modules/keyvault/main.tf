resource "azurerm_key_vault" "kv" {
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
  # IMPORTANT: REMOVE NETWORK LAYER
  # =========================
  public_network_access_enabled = true

  tags = var.tags
}