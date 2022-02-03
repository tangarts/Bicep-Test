param databaseAccounts_cdb_benchmark_name string = 'cdb-benchmark'

resource databaseAccounts_cdb_benchmark_name_resource 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: databaseAccounts_cdb_benchmark_name
  location: 'North Europe'
  tags: {
    defaultExperience: 'Core (SQL)'
    'hidden-cosmos-mmspecial': ''
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'None'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: true
    enableAnalyticalStorage: true
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 305
      maxStalenessPrefix: 100000
    }
    locations: [
      {
        locationName: 'North Europe'
        provisioningState: 'Succeeded'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: []
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 8
        backupStorageRedundancy: 'Geo'
      }
    }
    networkAclBypassResourceIds: []
  }
}

resource databaseAccounts_cdb_benchmark_name_testdb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  parent: databaseAccounts_cdb_benchmark_name_resource
  name: 'testdb'
  properties: {
    resource: {
      id: 'testdb'
    }
  }
}

resource databaseAccounts_cdb_benchmark_name_00000000_0000_0000_0000_000000000001 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' = {
  parent: databaseAccounts_cdb_benchmark_name_resource
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_cdb_benchmark_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource databaseAccounts_cdb_benchmark_name_00000000_0000_0000_0000_000000000002 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2021-10-15' = {
  parent: databaseAccounts_cdb_benchmark_name_resource
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_cdb_benchmark_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource databaseAccounts_cdb_benchmark_name_testdb_testcol 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-10-15' = {
  parent: databaseAccounts_cdb_benchmark_name_testdb
  name: 'testcol'
  properties: {
    resource: {
      id: 'testcol'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/pk'
        ]
        kind: 'Hash'
      }
      uniqueKeyPolicy: {
        uniqueKeys: []
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
    }
  }
  dependsOn: [
    databaseAccounts_cdb_benchmark_name_resource
  ]
}

resource databaseAccounts_cdb_benchmark_name_testdb_testcol_default 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/throughputSettings@2021-10-15' = {
  parent: databaseAccounts_cdb_benchmark_name_testdb_testcol
  name: 'default'
  properties: {
    resource: {
      throughput: 400
    }
  }
  dependsOn: [
    databaseAccounts_cdb_benchmark_name_testdb
    databaseAccounts_cdb_benchmark_name_resource
  ]
}