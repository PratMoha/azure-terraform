terraform {
  required_providers{
    azurerm={
      version="2.44.0"
      source="hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {

  }

}

resource "azurerm_resource_group" "pratyushdemo" {
  name = "PratyushdemoTerra"
  location = "westeurope"
}

# Create app service plan
resource "azurerm_app_service_plan" "service-plan" {
  name = "simple-service-plan"
  location = azurerm_resource_group.pratyushdemo.location
  resource_group_name = azurerm_resource_group.pratyushdemo.name
  kind = "Linux"
  reserved = true
  sku {
    tier = "Standard"
    size = "S1"
  }
  tags = {
    environment = "dev"
  }
}

# Create JAVA app service
resource "azurerm_app_service" "app-service" {
  name = "my-awesome-app-svc-pratyush"
  location = azurerm_resource_group.pratyushdemo.location
  resource_group_name = azurerm_resource_group.pratyushdemo.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    linux_fx_version = "PYTHON|3.9"
  }
  tags = {
    environment = "dev"
  }
}