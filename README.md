# 🦅 Falcon Sensor Automation & FCS CLI Image Scan
![CrowdStrike](https://img.shields.io/badge/CrowdStrike-FF0000?style=for-the-badge&logo=crowdstrike&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## 📋 Overview
This workflow automates the deployment of CrowdStrike Falcon Container Sensor and performs security scans using FCS CLI.

## 📝 Prerequisites

### Required Components
- Azure Container Registry
- CrowdStrike Falcon API Credentials
- GitHub Repository
- Azure CLI installed (for generating credentials)

### Azure Configuration

1. **Create Azure Service Principal and get credentials:**
```bash
# Login to Azure
az login

# Create Service Principal with ACR push role
az ad sp create-for-rbac \
  --name "GitHub-ACR-Access" \
  --role AcrPush \
  --scopes /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerRegistry/registries/<youracr> \
  --sdk-auth
```

Example output:
```json
{
  "clientId": "xxx",
  "clientSecret": "xxx",
  "subscriptionId": "xxx",
  "tenantId": "xxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

2. **Get ACR credentials:**
```bash
# Get ACR admin credentials
az acr credential show -n <youracr>
```

### Required Permissions

#### CrowdStrike API Client
- Falcon Container Image Download: Read
- Falcon Container Image: Write
- Falcon Container Registry: Write

#### Azure Container Registry Access
- Registry Name: `<youracr>.azurecr.io`
- Admin Access Enabled
- Service Principal: AcrPush role

### GitHub Configuration

#### Repository Secrets
```yaml
ACR_USERNAME: Azure Container Registry username
ACR_PASSWORD: Azure Container Registry password
FALCON_CLIENT_SECRET: CrowdStrike API secret
AZURE_CREDENTIALS: Entire JSON output from az ad sp create-for-rbac
```

#### Repository Variables
```yaml
FALCON_CLIENT_ID: CrowdStrike API client ID
```

## 🔄 Trigger Events
- Push to `main` branch
- Pull requests to `main` branch
- Manual workflow dispatch
- Hourly schedule (`0 * * * *`)

## 🛠️ Features
- ✨ Automated Falcon Container Sensor deployment
- 🔒 Azure Container Registry integration
- 🔍 FCS IaC scanning
- 📊 Container vulnerability scanning
- 📝 SARIF report generation
- 🔄 GitHub Code Scanning integration

## 📦 Workflow Steps
1. 🔵 **Repository Checkout**
2. 🔐 **ACR Authentication**
3. 📥 **Falcon Container Sensor Download**
4. 🔍 **FCS IaC Scan**
5. 🏗️ **Docker Image Build**
6. 🔬 **Vulnerability Scan**
7. 📊 **Results Processing**

## 📈 Outputs
- SARIF reports for security scanning
- JSON vulnerability reports
- Workflow summary with execution status
- Scan results verification

## ⚠️ Important Notes
- Requires appropriate permissions for GitHub Actions
- Docker socket access needed for container scanning
- Azure Container Registry credentials must be valid
- CrowdStrike API credentials must be properly configured

## 🔗 Related Links
- [CrowdStrike FCS Action](https://github.com/crowdstrike/fcs-action)
- [Falcon Scripts Repository](https://github.com/CrowdStrike/falcon-scripts)