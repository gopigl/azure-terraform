resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"  # Use "Standard" for the Standard SKU
}

output "vnet_name" {
  description = "Name of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "Address space of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}
