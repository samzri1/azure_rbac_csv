variable "mail" {
    type = string
    description = "Email de la personne qui sera owner du projet"
}

variable "project" {
    type = string
    description = "Nom du projet"
}

variable "group_name" {
  type = string
  default = "Project Administrators"
  description = "Nom du groupe"
}