resource "azurerm_traffic_manager_profile" "profile" {
  count                  = length(var.profiles)
  name                   = var.profiles[count.index].name
  resource_group_name    = var.rg_name
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = var.profiles[count.index].relative_name
    ttl           = 30
  }

  monitor_config {
    protocol                    = "HTTPS"
    port                        = 443
    path                        = "/"
    expected_status_code_ranges = ["200-202", "301-302"]
  }
}

resource "azurerm_traffic_manager_external_endpoint" "endpoint" {
  count             = length(var.profiles)
  profile_id        = azurerm_traffic_manager_profile.profile[count.index].id
  name              = "endpoint"
  target            = var.profiles[count.index].endpoint_target
  endpoint_location = var.location
  weight            = 50
}
