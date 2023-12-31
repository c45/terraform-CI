terraform {
  required_version = "~> 1.5.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.64.0"
    }
  }
  cloud {
    organization = "c45"

    workspaces {
      name = "Actions"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}


resource "azurerm_resource_group" "rg" {
  name     = join("-", ["rg", var.name])
  location = var.region
}

resource "azurerm_storage_account" "sa" {
  name                     = "sa${var.name}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
