# =========================================================
# Virtual Network
# =========================================================

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnet_address_space

  tags = var.tags
}

# =========================================================
# Subnet
# =========================================================

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = var.subnet_address_prefixes
}

# =========================================================
# Network Security Group
# =========================================================

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # SSH access (restricted)
  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"

    source_port_range         = "*"
    destination_port_range    = "22"

    source_address_prefix     = var.admin_ip
    destination_address_prefix = "*"
  }

  # Outbound internet access
  security_rule {
    name                       = "allow-outbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"

    source_port_range         = "*"
    destination_port_range    = "*"

    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# =========================================================
# NSG Association
# =========================================================

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}