using './main.bicep'

param name = 'avm-aks-cluster-abc'
param location = 'belgiumcentral'

param managedIdentities = {
  systemAssigned: true
}
