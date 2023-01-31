param location string = resourceGroup().location

param aseName string = 'jjtessss'
param aseVnetName string  = 'asevnet'
param aseSubnetName string    = 'ase'
param appServicePlanName string = 'aseplan'

param appServicePlanKind string  = 'linux'
param appServicePlanWorkerCount int = 1
param appServicePlanWorkerSize int  = 6
param appServicePlanSku object   = {
  Name: 'I1v2'
  tier: 'IsolatedV2'
}

var hostingEnvironmentProfile = {
  id: ase.id
}

resource appServicePlanName_resource 'Microsoft.Web/serverfarms@2019-08-01' = {
  kind: appServicePlanKind
  name: appServicePlanName
  location: location
  properties: {
    hostingEnvironmentProfile: hostingEnvironmentProfile
    perSiteScaling: false
    reserved: false
    targetWorkerCount: appServicePlanWorkerCount
    targetWorkerSizeId: appServicePlanWorkerSize
  }
  sku: appServicePlanSku
}


var aseVnetId = aseVnet.id
var aseSubnetId  = '${aseVnetId}/Subnets/${aseSubnetName}'

resource ase 'Microsoft.Web/hostingEnvironments@2021-01-01' = {  
  name: aseName
  location: location
  kind: 'ASEV3'
  properties: {
    //dnsSuffix: '${aseName}.appserviceenvironment.net'
    virtualNetwork: {
      id: aseSubnetId
    }
  }
}

resource aseVnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: aseVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: aseSubnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: [
            {
              name: 'Microsoft.Web.hostingEnvironments'
              properties: {
                serviceName: 'Microsoft.Web/hostingEnvironments'
              }
            }
          ]
        }
      }
    ]
    }
  } 

