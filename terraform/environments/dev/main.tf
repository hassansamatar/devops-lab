# =========================================================
# RESOURCE GROUP
# =========================================================

resource "azurerm_resource_group" "dev_rg" {
  name     = var.resource_group_name
  location = var.location
}

# =========================================================
# AZURE CONTEXT (OIDC)
# =========================================================

data "azurerm_client_config" "current" {}

# =========================================================
# NETWORK MODULE
# =========================================================

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = var.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes

  nsg_name = var.nsg_name

  tags = var.tags
}

# =========================================================
# KEY VAULT MODULE (RBAC ONLY)
# =========================================================

module "keyvault" {
  source = "../../modules/keyvault"

  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = var.location

  key_vault_name = "${var.vm_name}-kv"
  tenant_id      = data.azurerm_client_config.current.tenant_id

  tags = var.tags
}

# =========================================================
# COMPUTE MODULE
# =========================================================

module "compute" {
  source = "../../modules/compute"

  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = var.location

  subnet_id = module.network.subnet_id

  vm_name        = var.vm_name
  vm_size        = var.vm_size
  admin_username = var.admin_username

  # SSH removed from Key Vault dependency
  ssh_public_key = file("${path.module}/ssh_public_key.pub")

  tags = var.tags
}