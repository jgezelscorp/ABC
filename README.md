# AKS deployment (AVM)

This folder contains an AKS deployment using Azure Verified Modules.

Files:
- `main.bicep` - AVM-based AKS cluster module call
- `parameters.json` - example parameters for deployment

GitHub Actions:
- Workflow: `.github/workflows/aks-deploy.yml` — triggers on pull requests to `main` and runs build/validate/what-if. On merge it deploys the template.

Required GitHub Secrets:
- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AKS_RG` - resource group name to deploy to
- `AKS_LOCATION` - location to create resource group if missing (e.g. `westeurope`)

Notes:
- The Bicep module used is `br/public:avm/res/container-service/managed-cluster:0.10.0` — you can adjust version as needed.
- The workflow performs a `bicep build` and uses `az deployment group what-if` for validation on PRs.
- Customize `parameters.json` for your sizing and networking needs.
