terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0, < 5.0"
    }
  }
}

# =========================================================
# VIRTUAL NETWORK
# =========================================================

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnet_address_space

  tags = var.tags
}

# =========================================================
# APPLICATION SUBNET (VMs)
# =========================================================

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = var.subnet_address_prefixes
}

# =========================================================
# BASTION SUBNET (REQUIRED NAME)
# =========================================================

resource "azurerm_subnet" "bastion_subnet" {
  #checkov:skip=CKV2_AZURE_31:AzureBastionSubnet is service-managed; NSG hardening is tracked separately to avoid breaking Bastion control-plane traffic.
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.2.0/27"]
}

# =========================================================
# NETWORK SECURITY GROUP (ONLY FOR VM SUBNET)
# =========================================================

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# =========================================================
# NSG ASSOCIATION (ONLY APPLICATION SUBNET)
# =========================================================

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# =========================================================
# BASTION PUBLIC IP
# =========================================================

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

# =========================================================
# AZURE BASTION HOST
# =========================================================

resource "azurerm_bastion_host" "bastion" {
  name                = "dev-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tunneling_enabled      = true
  ip_connect_enabled     = true
  shareable_link_enabled = false

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  tags = var.tags
}