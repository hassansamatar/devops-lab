# =========================================================
# RESOURCE GROUP
# =========================================================

resource "azurerm_resource_group" "dev_rg" {
  name     = var.resource_group_name
  location = var.location
}

# =========================================================
# AZURE CONTEXT -implementing IODC for deb branch
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
# KEY VAULT MODULE (FIXED)
# =========================================================

module "keyvault" {
  source = "../../modules/keyvault"

  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = var.location

  key_vault_name = "${var.vm_name}-kv"
  tenant_id       = data.azurerm_client_config.current.tenant_id
  key_vault_allowed_ip_rules = var.key_vault_allowed_ip_rules
  key_vault_default_action   = var.key_vault_default_action

  tags = var.tags
}

# =========================================================
# SSH PUBLIC KEY IN KEY VAULT
# =========================================================

resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  value        = trimspace(var.ssh_public_key)
  key_vault_id = module.keyvault.key_vault_id
  content_type = "application/x-ssh-public-key"
  expiration_date = "2030-01-01T00:00:00Z"
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