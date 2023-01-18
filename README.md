# Azure Logic Apps integration with on-premise SMB file shares

A demonstration of how logic apps can be used to integrate with on-premise SMB file shares

## Why is this a problem?

Azure Integration Series and Logic Apps in particular provide an effecient means for teams to build integrations between systems.

When logic apps are hosted in the standard mode, they use the Azure App Services runtime which exists in a [sandbox](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox). This sandbox has some network port restrictions - specifically port 445 which is the standard port that the SMB protocol uses. So, when running  a workflow like this:

![alt text](images/smb-get-file-content.png "logic app")

the "File System" actions (in this case the Get File Contents action) will not be able to "reach" the target SMB server. Thus the workflow will not work corretly.

This behaviour will be the same for web apps or Functions, which also run on the App Service runtime.

What is needed is to avoid this *sandbox* issue, but to still make use of the same set of high-level tooling.

## What can be done?

Logic apps have an [Integration service environment}(https://learn.microsoft.com/en-us/azure/logic-apps/ise-manage-integration-service-environment), which is one approach, but this capability is 

## Demonstration Scenario

![alt text](images/demo-scenario.png "Demo Scenario")
