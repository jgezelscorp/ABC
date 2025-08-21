// using 'br/public:avm/res/container-service/managed-cluster:0.10.0'
using ./main.bicep

param name = 'avm-aks-cluster-abc'
param location = 'belgiumcentral'

param managedIdentities = {
  systemAssigned: true
}
