variable "rg_name" {
  description = "Name of the resource group which resource will be created"
  type        = string
  default     = ""
}
variable "location" {
  description = "Name of the location which resource needs to be deployed"
  type        = string
  default     = ""
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = ""
}

variable "vnet_address_space" {
  description = "Address Space for Vnet"
  type        = list(string)
}

variable "pip_name" {
  description = "Public IP Name"
  type        = string
}
############## Sub Nets #########################
variable "subnets" {
  description = "List of subnet names and their respective CIDR prefixes"
  type        = list(object({
    name      = string
    prefix    = list(string)
  }))
}

variable "subnet_routes" {
  description   = "List of subnet routes"
  type          = list(object({
    subnet_name = string
    route_name  = string
    next_hop_ip = string
  }))
}

############## NSG Rules ###########################
variable "nsg_rules" {
  description = "List of NSG rules"
  type        = list(object({
    name                  = string
    priority              = number
    direction             = string
    access                = string
    protocol              = string
    source_port_range     = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))
}

################ Traffic Managers ############
variable "profiles" {
  type    = list(object({
    name        = string
    relative_name = string
    endpoint_target = string
  }))
}

################# App Gateway #########################
variable "public_ips" {
  description = "A map of Azure Public IPs."
  type        = map(object({
    name       = string
    sku        = string
    allocation = string
  }))
  default = {}  # Default value is an empty map
}

variable "appgw_name" {
  description  =  "Name of the Application Gateway"
  type         = string
}

variable "gateway_ip_config" {
  description  = "Name of the Gateway IP Config"
  type         = string
}

variable "frontend_ip_config" {
  description  = "Name of the Frontend IP Config"
  type         = string
}

variable "frontend_ports" {
  description = "A map of frontend ports."
  type        = map(object({
    name         = string
    http_port    = number
  }))
  default = {}  # Default value is an empty map
}

variable "backend_address_pools" {
  description = "A map of backend address pool configurations."
  type        = map(object({
    name          = string
    ip_addresses  = list(string)
    fqdns         = list(string)
  }))
}

variable "http_listener" {
  description = "A map of HTTP listener configurations."
  type        = map(object({
    name                  = string
    protocol              = string
  }))
}

variable "backend_http_settings" {
  description = "A map of backend HTTP settings configurations."
  type        = map(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
    request_timeout       = number
  }))
  default = {}  # Default value is an empty map
}

variable "request_routing_rules" {
  description = "A map of request routing rule configurations."
  type        = map(object({
    name                = string
    rule_type           = string
  }))
  default = {}  # Default value is an empty map
}

variable "url_path_map_name" {
  description = "Name of the URL path map"
  type        = string
}

variable "path_rule_name2" {
  description = "Name of the path rule"
  type        = string
}
