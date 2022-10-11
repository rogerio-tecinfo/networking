# Create resource group
# data "azurerm_resource_group" "resourcegroup" {
#   name = var.resourcegroup
# }

# output "resourcegroup_id" {
#   value = azurerm_resource_group.resourcegroup.id
# }

# Create resource group
resource "azurerm_resource_group" "resourcegroup1" {
  name     = var.resourcegroup1
  location = var.location
}

# Create resource group
resource "azurerm_resource_group" "resourcegroup2" {
  name     = var.resourcegroup2
  location = var.location
}

# Create resource group
resource "azurerm_resource_group" "resourcegroup3" {
  name     = var.resourcegroup3
  location = var.location
}

# Create virtual network1
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1
  address_space       = [var.vnetaddress_space1]
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name
  depends_on          = [azurerm_resource_group.resourcegroup1]
}

# Create virtual network2
resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2
  address_space       = [var.vnetaddress_space2]
  location            = azurerm_resource_group.resourcegroup2.location
  resource_group_name = azurerm_resource_group.resourcegroup2.name
  depends_on          = [azurerm_resource_group.resourcegroup2]
}

# Create virtual network3
resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet3
  address_space       = [var.vnetaddress_space2]
  location            = azurerm_resource_group.resourcegroup3.location
  resource_group_name = azurerm_resource_group.resourcegroup3.name
  depends_on          = [azurerm_resource_group.resourcegroup3]
}

# Create subnet0
resource "azurerm_subnet" "subnet0" {
  name                 = var.subnet0
  resource_group_name  = azurerm_resource_group.resourcegroup1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddress_prefixes0]
  depends_on           = [azurerm_resource_group.resourcegroup1, azurerm_virtual_network.vnet1]
}

# Create subnet1
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.resourcegroup1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddress_prefixes1]
  depends_on           = [azurerm_resource_group.resourcegroup1, azurerm_virtual_network.vnet1]
}

# Create subnet-appgw
resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2
  resource_group_name  = azurerm_resource_group.resourcegroup3.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddress_prefixes3]
  depends_on           = [azurerm_resource_group.resourcegroup3, azurerm_virtual_network.vnet1]
}

# Create subnet0
resource "azurerm_subnet" "subnet3" {
  name                 = var.subnet3
  resource_group_name  = azurerm_resource_group.resourcegroup1.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = [var.subnetaddress_prefixes2]
  depends_on           = [azurerm_resource_group.resourcegroup1, azurerm_virtual_network.vnet3]
}

# Create subnet1
resource "azurerm_subnet" "subnet4" {
  name                 = var.subnet4
  resource_group_name  = azurerm_resource_group.resourcegroup1.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = [var.subnetaddress_prefixes2]
  depends_on           = [azurerm_resource_group.resourcegroup1, azurerm_virtual_network.vnet3]
}

#Create vnet peering vnet01 to vnet02
resource "azurerm_virtual_network_peering" "vnet01_to_vnet02" {
  name                         = var.vnet01_to_vnet02
  resource_group_name          = azurerm_resource_group.resourcegroup1.name
  virtual_network_name         = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on                   = [azurerm_virtual_network.vnet1, azurerm_virtual_network.vnet2]
}

resource "azurerm_virtual_network_peering" "vnet02_to_vnet01" {
  name                         = var.vnet02_to_vnet01
  resource_group_name          = azurerm_resource_group.resourcegroup1.name
  virtual_network_name         = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on                   = [azurerm_virtual_network.vnet2, azurerm_virtual_network.vnet1]
}

#Create vnet peering vnet01 to vnet03
resource "azurerm_virtual_network_peering" "vnet01_to_vnet03" {
  name                         = var.vnet01_to_vnet02
  resource_group_name          = azurerm_resource_group.resourcegroup1.name
  virtual_network_name         = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on                   = [azurerm_virtual_network.vnet1, azurerm_virtual_network.vnet3]
}

resource "azurerm_virtual_network_peering" "vnet03_to_vnet01" {
  name                         = var.vnet02_to_vnet01
  resource_group_name          = azurerm_resource_group.resourcegroup1.name
  virtual_network_name         = azurerm_virtual_network.vnet3.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on                   = [azurerm_virtual_network.vnet3, azurerm_virtual_network.vnet1]
}

#Create Route Tables
resource "azurerm_route_table" "route_table1" {
  name                = var.route_table1
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  route {
    name                   = var.route1
    address_prefix         = "10.63.0.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.60.0.4"
  }
}

resource "azurerm_subnet_route_table_association" "route_table1_association" {
  subnet_id      = azurerm_subnet.subnet0.id
  route_table_id = azurerm_route_table.route_table1.id
}

resource "azurerm_route_table" "route_table2" {
  name                = var.route_table2
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  route {
    name                   = var.route2
    address_prefix         = "10.62.0.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.60.0.4"
  }
}

resource "azurerm_subnet_route_table_association" "route_table2_association" {
  subnet_id      = azurerm_subnet.subnet0.id
  route_table_id = azurerm_route_table.route_table2.id
}

# Create network interface to both vms
resource "azurerm_network_interface" "nic0" {
  name                = var.nic0
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  ip_configuration {
    name                          = "${var.name0}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet0.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.publicip0.id
  }
  depends_on = [azurerm_subnet.subnet0]
}
resource "azurerm_network_interface" "nic1" {
  name                = var.nic1
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  ip_configuration {
    name                          = "${var.name1}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.publicip1.id
  }
  depends_on = [azurerm_subnet.subnet1]
}

resource "azurerm_network_interface" "nic2" {
  name                = var.nic2
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  ip_configuration {
    name                          = "${var.name2}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet3.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.publicip1.id
  }
  depends_on = [azurerm_subnet.subnet3]
}

resource "azurerm_network_interface" "nic3" {
  name                = var.nic2
  location            = azurerm_resource_group.resourcegroup1.location
  resource_group_name = azurerm_resource_group.resourcegroup1.name

  ip_configuration {
    name                          = "${var.name2}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet4.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.publicip1.id
  }
  depends_on = [azurerm_subnet.subnet3]
}

# Create public IPs
resource "azurerm_public_ip" "publicip4" {
  name                = var.publicip4
  location            = azurerm_resource_group.resourcegroup2.location
  resource_group_name = azurerm_resource_group.resourcegroup2.name
  allocation_method   = "Dynamic"
  sku                 = var.publicip_sku
  depends_on          = [azurerm_subnet.subnet0]
  tags = {
    environment = "staging"
  }
}

# Create public IPs
resource "azurerm_public_ip" "publicip5" {
  name                = var.publicip5
  location            = azurerm_resource_group.resourcegroup3.location
  resource_group_name = azurerm_resource_group.resourcegroup3.name
  allocation_method   = "Dynamic"
  sku                 = var.publicip_sku
  depends_on          = [azurerm_subnet.subnet1]
  tags = {
    environment = "staging"
  }
}

#Create Network Security Group and rule to open port 80.
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = azurerm_resource_group.resourcegroup2.location
  resource_group_name = azurerm_resource_group.resourcegroup2.name

  security_rule {
    name                       = "AllowRDPInBound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  depends_on = [azurerm_resource_group.resourcegroup2]
}

# Associate the publicip's with the VM nic's 
# resource "azurerm_network_interface_security_group_association" "connectnic0" {
#   network_interface_id      = azurerm_network_interface.nic0.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   depends_on = [azurerm_network_interface.nic0, azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_interface_security_group_association" "connectnic1" {
#   network_interface_id      = azurerm_network_interface.nic1.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   depends_on = [azurerm_network_interface.nic1, azurerm_network_security_group.nsg,
#   azurerm_public_ip.publicip1]
# }

# Create virtual machines
resource "azurerm_windows_virtual_machine" "name0" {
  name                  = var.name0
  location              = azurerm_resource_group.resourcegroup1.location
  resource_group_name   = azurerm_resource_group.resourcegroup1.name
  network_interface_ids = [azurerm_network_interface.nic0.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name0}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name0
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_subnet.subnet0]
}

resource "azurerm_windows_virtual_machine" "name1" {
  name                  = var.name1
  location              = azurerm_resource_group.resourcegroup1.location
  resource_group_name   = azurerm_resource_group.resourcegroup1.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name1}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name1
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_windows_virtual_machine.name0, azurerm_subnet.subnet1]
}

resource "azurerm_windows_virtual_machine" "name2" {
  name                  = var.name3
  location              = azurerm_resource_group.resourcegroup1.location
  resource_group_name   = azurerm_resource_group.resourcegroup1.name
  network_interface_ids = [azurerm_network_interface.nic2.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name2}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name2
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_windows_virtual_machine.name1, azurerm_subnet.subnet3]
}

resource "azurerm_windows_virtual_machine" "name3" {
  name                  = var.name3
  location              = azurerm_resource_group.resourcegroup1.location
  resource_group_name   = azurerm_resource_group.resourcegroup1.name
  network_interface_ids = [azurerm_network_interface.nic3.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name3}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name3
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_windows_virtual_machine.name1, azurerm_subnet.subnet4]
}
