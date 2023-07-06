terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.4.0"
    }
  }
}

provider "azuredevops" {
  # Configuration options
}

locals {
   input = jsondecode(file("./principals.json"))
  principals = {for i in local.input : i.id => i}
}

output "principal" {
  value = local.principals
}

module "p22_module" {
  source = "./modules/p20_create_azdo_projects"
  for_each = local.principals
  mail = each.key
  project = each.value.name
}

