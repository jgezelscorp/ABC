using 'br/public:avm/res/container-service/managed-cluster:0.10.0'

param name = 'avm-aks-cluster'
param location = 'belgiumcentral'

param primaryAgentPoolProfiles = [
  {
    name: 'systempool'
    mode: 'System'
    vmSize: 'Standard_DS2_v2'
    count: 1
  }
]

param managedIdentities = {
  systemAssigned: true
}
