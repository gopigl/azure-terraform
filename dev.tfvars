# Resource Group
rg_name             = "dev"
location            = "eastus"

# Virtual Network
vnet_name      = "dev-eus-vnet-01"
vnet_address_space  = ["10.0.0.0/16"]

pip_name       = "dev-pip"
subnets = [
  {
    name = "subnet1"
    prefix = ["10.0.1.0/24"]
  },
  {
    name = "subnet2"
    prefix = ["10.0.2.0/24"]
  }
]

subnet_routes = [
  {
    subnet_name = "subnet1"
    route_name  = "route1"
    next_hop_ip = "10.0.1.1"  # Replace with the actual next hop IP
  },
  {
    subnet_name = "subnet2"
    route_name  = "route2"
    next_hop_ip = "10.0.2.1"  # Replace with the actual next hop IP
  }
]

################## NSG Rules #############################
nsg_rules = [
  {
    name                  = "allow-ssh-from-office"
    priority              = 100
    direction             = "Inbound"
    access                = "Allow"
    protocol              = "Tcp"
    source_port_range     = "*"
    destination_port_range = "22"
    source_address_prefix = "10.0.0.0/23"  # Replace with your specific IP range
    destination_address_prefix = "*"
  },
  {
    name                  = "allow-http-from-anywhere"
    priority              = 200
    direction             = "Inbound"
    access                = "Allow"
    protocol              = "Tcp"
    source_port_range     = "*"
    destination_port_range = "80"
    source_address_prefix = "10.0.0.0/22"
    destination_address_prefix = "*"
  }
  # Add more NSG rules for different scenarios as needed
]

######################### Traffic Managers ##############################
profiles = [
  {
    name           = "dev-tm-1"
    relative_name  = "dev-tm-1"
    endpoint_target = "www.contoso.com"
  },
  {
    name           = "dev-tm-2"
    relative_name  = "dev-tm-2"
    endpoint_target = "www.example.com"
  },
  {
    name           = "dev-tm-3"
    relative_name  = "dev-tm-4"
    endpoint_target = "www.anotherdomain.com"
  }
]

######################### App Gateway ###############################
public_ips = {
  "pip1" = {
    name       = "dev-uks-pip-01"
    sku        = "Standard"
    allocation = "Static"
  }
  # Add more public IPs with their configurations as needed
}

appgw_name  = "dev-uks-appgw-01"

gateway_ip_config = "dev-uks-gwip-01"

frontend_ip_config = "dev-uks-feip-01"

frontend_ports = {
  "webserver-port" = {
    name       = "uks-webserver-port"
    http_port  = 80
  }
  # Add more frontend ports as needed
}

backend_address_pools = {
  "pool1" = {
    name         = "dev-uks-pool1"
    ip_addresses = ["10.0.0.1", "10.0.0.2"]
    fqdns        = ["api.example.com", "sample.com"]
  },
  "pool2" = {
    name         = "dev-uks-pool2"
    ip_addresses = ["10.0.0.3", "10.0.0.4"]
    fqdns        = ["services.example.com", "app.example.com"]
  }
  # Add more pools as needed
}

http_listener = {
  "listener-1" = {
    name                  = "dev-uks-listener-1"
    protocol              = "Http"
  }
  #"listener-2"  = {
  #  name                  = "dev-uks-listener-2"
  #  protocol              = "Http"
  #}
}

backend_http_settings = {
  "http-settings-1" = {
    name                  = "http-settings-1"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
  "http-settings-2" = {
    name                  = "http-settings-2"
    cookie_based_affinity = "Disabled"
    port                  = 8080
    protocol              = "Http"
    request_timeout       = 45
  }
  # Add more backend HTTP settings as needed
}

request_routing_rules = {
  #"rule-1" = {
  #  name                = "dev-uks-rule-1"
  #  rule_type           = "Basic"
  #}
  "rule-2" = {
    name                = "dev-uks-rule-2"
    rule_type           = "PathBasedRouting"
  }
  # Add more request routing rules as needed
}

url_path_map_name     = "dev-url-path-map"

path_rule_name2       = "dev-rule-2"
