


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }

}
}

provider "azurerm" {
  subscription_id = "8bf2c5d3-f2c9-481c-ba03-71037c37bcc1"
  features {}
}
