// AKS deployment using Azure Verified Modules (AVM)
// Deploys an AKS managed cluster using `avm/res/container-service/managed-cluster` module

targetScope = 'resourceGroup'

@description('Location for all resources')
param location string = resourceGroup().location

@description('AKS cluster name')
param name string = 'avm-aks-cluster'

@description('Primary agent pool configuration (required)')
param primaryAgentPoolProfiles array = [
  {
    name: 'systempool'
    mode: 'System'
    vmSize: 'Standard_DS2_v2'
    count: 1
    // vnetSubnetResourceId can be set per-pool; optional and will be overridden below if top-level param provided
  }
]

@description('Optional: enable managed identities (system assigned)')
param managedIdentities object = {
  systemAssigned: true
}

@description('Optional: network plugin')
param networkPlugin string = 'azure'

@description('Optional: vnet subnet resource id for agent pools (leave empty for default)')
param vnetSubnetResourceId string = ''

module managedCluster 'br/public:avm/res/container-service/managed-cluster:0.10.0' = {
  name: 'managedClusterDeployment'
  params: {
  name: name
  location: location
    managedIdentities: managedIdentities
    networkPlugin: networkPlugin
    // If a top-level subnet is provided, inject it into the first agent pool's vnetSubnetResourceId
    primaryAgentPoolProfiles: [
      for (pool, i) in primaryAgentPoolProfiles: union(
        pool,
        i == 0 && length(vnetSubnetResourceId) > 0 ? { vnetSubnetResourceId: vnetSubnetResourceId } : {}
      )
    ]

  // Basic defaults: no flux configs by default (user can enable via params)
  fluxExtension: null

    // tags
    tags: {
      deployedBy: 'avm-bicep'
      purpose: 'aks'
    }
  }
}

output managedClusterResourceId string = managedCluster.outputs.resourceId
