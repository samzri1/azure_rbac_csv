

variable "cvssource" {
    type = string
    default = "users.csv"  
}
locals {
  users = csvdecode( file(var.cvssource))
}

resource "azurerm_resource_group" "rg" {
    for_each = {for user in local.users : user.id => user }
    name = "P22_${split(".", each.value.displayName)[0]}"
    location = "francecentral"
    tags = { User = each.key}
}

resource "azurerm_role_assignment" "rg_owner_user" {
   for_each = azurerm_resource_group.rg

   scope = each.value.id
   role_definition_name = "Owner"
   principal_id = each.value.tags.User

   depends_on = [
     azurerm_resource_group.rg
   ] 

}