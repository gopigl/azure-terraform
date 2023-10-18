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
application_gateways = {
  "appgw1" ={
    name = "dev-agw-uks-01"
  }
}
zones = ["1", "2", "3"]
autoscale_configuration = {
  min_capacity = "1"
  max_capacity = "2"
}


frontend_ip_configuration_name = "dev-appgw-feip"
frontend_ip_configuraion = {
  private_ip_address           = "10.0.0.1",
  private_ip_address_allocation = "static"
}

backend_address_pool = [
  {
    name   = "dev-backend-pool-1"
    ip_addresses = ["10.1.1.1"]
  },
  {
    name     = "dev-backend-pool-2"
    fqdn     = "test.com"
  }
]

appgw_config = {
  "listener_dev_1" = {
    host_name                 = "dev.com"
    backedn_address_pool_name = "dev-backend-pool"
    health_probe_path         = "/"
   }
  "listener_dev_2" = {
    host_name                 = "test.com"
    backend_address_pool_name = "dev-backend-pool"
    health_probe_path         = "/"
   }
  "listener_dev_vm-1 = {
    host-name                 = "dev.vm.com"
    backend_address_pool_name = "dev-backend-pool"
    backend_setting_port      = "8080"
    health_probe_path         = "/path"
    request_timeout           = 60
    timeout                   = 60
   }
}  
