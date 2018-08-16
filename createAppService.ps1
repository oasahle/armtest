<#
 .SYNOPSIS
    Creates a new app service

 .DESCRIPTION
    Creates a new app service

 .PARAMETER serviceName
    The name of new the new service.

 .PARAMETER environmentName
    The environment where the app service is to be created
#>

param(
 [Parameter(Mandatory=$True)]
 [string]
 $serviceName,

 [Parameter(Mandatory=$True)]
#  [ValidateSet("unstable", "qa")]
 [string]
 $environmentName
)

#### CREDENTIALS ####
$cred = Get-Credential
Connect-AzureRmAccount -Credential $cred -SubscriptionId "f8bdb3a7-1b95-476a-9462-3226b72ffef6"

$asName = "$serviceName-$environmentName-rettsdata"
$resourceGroupName = "rettsdata-$environmentName-$servicename"
Write-Host "  Creating app service: $asName  on resourcegruoup ($resourceGroupName)"

$appServiceParams = @{}
$appServiceParams.Add('webAppName', $serviceName) 
$appServiceParams.Add('environment', $environmentName)

$pathAppServiceArmTemplate = ".\create-app-service-load.json"
$asTemplateName = "appService-$asName"
New-AzureRmResourceGroupDeployment -Name $asTemplateName -ResourceGroupName $resourceGroupName -TemplateFile $pathAppServiceArmTemplate 
