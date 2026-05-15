# =========================================================
# RESOURCE GROUP
# =========================================================

resource "azurerm_resource_group" "dev_rg" {
  name     = var.resource_group_name
  location = var.location
}

# =========================================================
# DATA SOURCE (CURRENT AZURE CONTEXT)
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
  admin_ip = var.admin_ip

  tags = var.tags
}

# =========================================================
# KEY VAULT MODULE (RBAC ENABLED INSIDE MODULE)
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
# STORE SSH PUBLIC KEY IN KEY VAULT
# =========================================================

resource "azurerm_key_vault_secret" "ssh_public_key" {
  name  = "ssh-public-key"
  value = file("~/.ssh/id_rsa.pub")

  key_vault_id = module.keyvault.key_vault_id
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

  ssh_public_key = azurerm_key_vault_secret.ssh_public_key.value

  tags = var.tags
}