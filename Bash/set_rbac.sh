#!/bin/bash

while IFS="," read -r group_id user_id rbac_id 
do
  echo "group : $group_id"
  echo "user: $user_id"
  echo "rbac_id: $rbac_id"
  echo "set right"
  az role assignment create --assignee "$user_id" \
    --role "$rbac_id" \
    --scope "$group_id"

done < <(tail -n +0 matrice.csv)