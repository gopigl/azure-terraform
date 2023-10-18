resource "azurerm_subnet" "subnets" {
  count                  = length(var.subnets)
  name                   = var.subnets[count.index].name
  resource_group_name    = var.rg_name
  virtual_network_name   = var.vnet_name
  address_prefixes       = var.subnets[count.index].prefix
  depends_on             = [azurerm_virtual_network.vnet]
}

resource "azurerm_route_table" "subnet_routes" {
  count               = length(var.subnets)
  name                = "subnet-route-table-${var.subnets[count.index].name}"
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name                = "route1"
    address_prefix      = "0.0.0.0/0"
    next_hop_type       = "VirtualAppliance"  # Update as needed
    next_hop_in_ip_address = var.subnet_routes[count.index].next_hop_ip
  }
}


output "subnets" {
  description = "Subnet information"
  value = {
    for subnet in azurerm_subnet.subnets :
    subnet.name => {
      prefix = subnet.address_prefixes
    }
  }
}
