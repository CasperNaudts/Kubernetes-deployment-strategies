provider "azurerm" {
  version = "2.5.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = "research-terraform"
    storage_account_name  = "k8sresearch"
    container_name        = "tstate"
    key                   = "terraform.tfstate"
  }
}