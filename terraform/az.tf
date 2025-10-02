# Provider configuration
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "insecure_rg" {
  name     = "insecure-resources"
  location = "eastus"
}

# Insecure Network
resource "azurerm_virtual_network" "open_vnet" {
  name                = "open-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.insecure_rg.location
  resource_group_name = azurerm_resource_group.insecure_rg.name
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.insecure_rg.name
  virtual_network_name = azurerm_virtual_network.open_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Insecure NSG (allows all traffic)
resource "azurerm_network_security_group" "open_nsg" {
  name                = "open-nsg"
  location            = azurerm_resource_group.insecure_rg.location
  resource_group_name = azurerm_resource_group.insecure_rg.name

  security_rule {
    name                       = "allow_all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range         = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Public IP
resource "azurerm_public_ip" "exposed_ip" {
  name                = "exposed-ip"
  location            = azurerm_resource_group.insecure_rg.location
  resource_group_name = azurerm_resource_group.insecure_rg.name
  allocation_method   = "Static"
  sku                = "Basic"
}

# Insecure Storage Account
resource "azurerm_storage_account" "public_storage" {
  name                     = "publicstorage${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.insecure_rg.name
  location                 = azurerm_resource_group.insecure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # Insecure settings
  allow_blob_public_access = true
  min_tls_version         = "TLS1_0"
  network_rules {
    default_action = "Allow"
    bypass         = ["None"]
  }
}

# Random string for storage account name
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}