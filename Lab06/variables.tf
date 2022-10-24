variable "resourcegroup1" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "az104-06-rg1"
}

variable "resourcegroup2" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "az104-06-rg4"
}

variable "resourcegroup3" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "az104-06-rg5"
}

variable "location" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "eastus2"
}

variable "vnet1" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-vnet01"
}

variable "vnet2" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-vnet02"
}

variable "vnet3" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-vnet03"
}

variable "subnet0" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet0"
}

variable "subnet1" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet1"
}

variable "subnet2" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "subnet-appgw"
}

variable "subnet3" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet0"
}

variable "subnet4" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet1"
}

variable "vnet01_to_vnet02" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-vnet01_to_az104-06-vnet2"
}

variable "vnet02_to_vnet01" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-vnet02_to_az104-06-vnet1"
}

variable "vnet01_to_vnet03" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-vnet01_to_az104-06-vnet3"
}

variable "vnet03_to_vnet01" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-vnet03_to_az104-06-vnet1"
}

variable "route_table1" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-rt23"
}

variable "route1" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-route-vnet2-to-vnet3"
}

variable "route_table2" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-rt32"
}

variable "route2" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "az104-06-route-vnet3-to-vnet2"
}

variable "vnetaddress_space1" {
  type        = string
  description = "Address space used for all resources. Recommend subnet config /20"
  default     = "10.60.0.0/20"
}

variable "vnetaddress_space2" {
  type        = string
  description = "Address space used for all resources. Recommend subnet config /20"
  default     = "10.62.0.0/20"
}

variable "vnetaddress_space3" {
  type        = string
  description = "Address space used for all resources. Recommend subnet config /20"
  default     = "10.63.0.0/20"
}

variable "subnetaddress_prefixes0" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.60.0.0/24"
}

variable "subnetaddress_prefixes1" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.60.1.0/24"
}

variable "subnetaddress_prefixes2" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.62.0.0/24"
}

variable "subnetaddress_prefixes3" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.63.0.0/24"
}

variable "subnetaddress_prefixes4" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.63.3.224/27"
}

variable "nic0" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-06-nic0"
}

variable "nic1" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-06-nic1"
}

variable "nic2" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-06-nic2"
}

variable "nic3" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-06-nic3"
}

variable "publicip4" {
  type        = string
  description = "Publicip used for two virtual machines."
  default     = "az104-06-pip4"
}

variable "publicip5" {
  type        = string
  description = "Publicip used for two virtual machines."
  default     = "az104-06-pip5"
}

variable "publicip_sku" {
  type        = string
  description = "The public IP sku: Default Basic"
  default     = "Basic"
}

variable "lb" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-lb4"
}

variable "back_pool" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "BackEndAddressPool"
}

variable "lbnat_pool" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "PublicIPAddress"
}

variable "lb_probe" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "http-probe"
}

variable "app_gateway" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-appgw5"
}

variable "app_back_gateway" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-06-appgw5-be1"
}

variable "nsg" {
  type        = string
  description = "Network Security Group Name used for all resources"
  default     = "az104-04-nsg1"
}

variable "private_domain_name" {
  type        = string
  description = "Private DNS Service Domain"
  default     = "tisolution.local"
}

variable "domain_name" {
  type        = string
  description = "DNS Service Domain"
  default     = "tisolution.tech"
}

variable "dns_zone_link" {
  type        = string
  description = "DNS Service Domain"
  default     = "az104-04-vnet1-link"
}

variable "size" {
  type        = string
  description = "Virtual Machine size, Default: Standard_DS1_v2"
  default     = "Standard_B2s"
}

variable "storage_account_type" {
  type        = string
  description = "Virtual Machine Disk type, Default: Standard_LRS"
  default     = "Standard_LRS"
}

variable "name0" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm0"
}

variable "name1" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm1"
}

variable "name2" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm2"
}

variable "name3" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm3"
}

variable "source_image_reference_publisher" {
  type        = string
  description = "Virtual Machine Publisher, Default: MicrosoftWindowsServer"
  default     = "MicrosoftWindowsServer"
}

variable "source_image_reference_offer" {
  type        = string
  description = "Virtual Machine Offer, Default: WindowsServer"
  default     = "WindowsServer"
}

variable "source_image_reference_sku" {
  type        = string
  description = "Virtual Machine Sku, Default: 2019-Datacenter"
  default     = "2019-Datacenter"
}

variable "source_image_reference_version" {
  type        = string
  description = "Virtual Machine Version, Default: latest"
  default     = "latest"
}

variable "user" {
  type        = string
  description = "User Name to connect on the VM."
  default     = "lab.azuser"
}

variable "password" {
  type        = string
  description = "password to connect on the VM."
  default     = "Q1w2e3r4t5%y"
}



