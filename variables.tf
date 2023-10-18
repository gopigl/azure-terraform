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
variable "application_gateways" {
  description  = "The application gateway in azure works as layer 7 load balancer"
  type  = map(object({
    name  = string
  }))
  default = {}
}
variable "sku" {
  type    = map(string)
  description = "A mapping with the sku configuration of the App Gateway"
  default     = {}
}
variable  "enable_http2" {
  type    = bool
  description = "Is HTTP2 Enabled on the application gateway resource?"
  default   = false
}
