module cosmos './modules/cosmos-account-with-standard-througput.bicep' = {
  name: 'cosmos'
  params: {
    primaryRegion: 'North Europe'
    secondaryRegion: 'East US'
  }
}

module storedProcedures './modules/cosmos-container-with-server-side.bicep' = {
  name: 'storedProcedures'
  params: {
    containerName: cosmos.outputs.containerName
  }
}
