#!/usr/bin/env/ sh

az group create --name cosmic-acr --location northeurope

az deployment group create --resource-group cosmic-bicep --template-file modules/deploy/acr.bicep 

# az acr show --resource-group acrrtixgjehiudtq

az bicep publish --file modules/cosmos-container-with-server-side.bicep --target br:acrrtixgjehiudtq.azurecr.io/bicep/modules/cosmos/stored-procedures:v1

az bicep publish --file modules/cosmos-account-with-standard-througput.bicep --target br:acrrtixgjehiudtq.azurecr.io/bicep/modules/cosmos/storage:v1

az bicep publish --file modules/cosmos-account-with-aad-and-rbac.bicep --target br:acrrtixgjehiudtq.azurecr.io/bicep/modules/cosmos/rbac:v1