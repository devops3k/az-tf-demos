variable "vnet_name" {
  description = "The name of the existing VNet. If not provided, a new VNet will be created."
  type = string
  # using a null default value to indicate that the variable is optional
  # if not provided, a new VNet will be created
  default = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the VNet."
  type = string
}

variable "resource_group_location" {
  description = "The location of the resource group in which to create the VNet."
  type = string
}

variable "subnet_prefixes" {
  description = "The list of subnet prefixes to create within the VNet."
  type = list(string)
}