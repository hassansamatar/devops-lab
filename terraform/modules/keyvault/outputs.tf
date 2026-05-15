# =========================================================
# KEY VAULT OUTPUTS
# =========================================================

output "key_vault_id" {
  description = "Key Vault resource ID"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "Key Vault URI (vault endpoint)"
  value       = azurerm_key_vault.kv.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID associated with Key Vault"
  value       = azurerm_key_vault.kv.tenant_id
}