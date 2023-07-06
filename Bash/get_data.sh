#!/bin/bash
az ad user list --out tsv > users.csv
az group list --out tsv > groups.csv
az role definition list --query "[].{name:name, roleType:roleType, roleName:roleName}" --output tsv
