terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate19257"
    container_name       = "terraform-state"
    key                  = "dev.terraform.tfstate"
  }
}