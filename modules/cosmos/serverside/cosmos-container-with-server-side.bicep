@description('Name of the container for server side procedures')
param containerName string

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-10-15' existing = {
  name: containerName
}

resource accountName_databaseName_containerName_myStoredProcedure 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/storedProcedures@2021-04-15' = {
  parent: container
  name: 'myStoredProcedure'
  properties: {
    resource: {
      id: 'myStoredProcedure'
      body: 'function () { var context = getContext(); var response = context.getResponse(); response.setBody(\'Hello, World\'); }'
    }
  }
}

resource accountName_databaseName_containerName_myPreTrigger 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/triggers@2021-04-15' = {
  parent: container
  name: 'myPreTrigger'
  properties: {
    resource: {
      id: 'myPreTrigger'
      triggerType: 'Pre'
      triggerOperation: 'Create'
      body: 'function validateToDoItemTimestamp(){var context=getContext();var request=context.getRequest();var itemToCreate=request.getBody();if(!(\'timestamp\'in itemToCreate)){var ts=new Date();itemToCreate[\'timestamp\']=ts.getTime();}request.setBody(itemToCreate);}'
    }
  }
}

resource accountName_databaseName_containerName_myUserDefinedFunction 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/userDefinedFunctions@2021-04-15' = {
  parent: container
  name: 'myUserDefinedFunction'
  properties: {
    resource: {
      id: 'myUserDefinedFunction'
      body: 'function tax(income){if(income==undefined)throw\'no input\';if(income<1000)return income*0.1;else if(income<10000)return income*0.2;else return income*0.4;}'
    }
  }
}

resource myNewUserDefinedFunction 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/userDefinedFunctions@2021-04-15' = {
  parent: container
  name: 'myNewUserDefinedFunction'
  properties: {
    resource: {
      id: 'myNewUserDefinedFunction'
      body: 'function sayhello() { return "Hello" ;}'
    }
  }
}
