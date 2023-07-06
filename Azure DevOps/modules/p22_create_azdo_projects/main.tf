terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.4.0"
    }
  }
}



resource "azuredevops_project" "project" {
  name               = var.project
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Projet créé pour ${var.project}"
  features = {
    "testplans" = "disabled"
    "artifacts" = "disabled"
  }
}

resource "azuredevops_user_entitlement" "principal" {
    depends_on = [
      azuredevops_project.project
    ]
  principal_name = var.mail
}

data "azuredevops_group" "group" {
  project_id =azuredevops_project.project.id
  name       = var.group_name
}

resource "azuredevops_group_membership" "asg_user" {
  depends_on = [
    azuredevops_user_entitlement.principal
  ]
  group = data.azuredevops_group.group.descriptor
  members = [
    azuredevops_user_entitlement.principal.descriptor
  ]
}