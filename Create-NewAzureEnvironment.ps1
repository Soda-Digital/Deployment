
#initialization/Installation

# Create the Azure resources in our tenant:

New-AzADGroup -DisplayName "$gname" -SecurityEnabled    #create ad security group
New-AzADServicePrincipal -DisplayName  "$spname"        #create service principal

$ADgroupId = (Get-AzADGroup -DisplayName "$gname").Id
$SPObjId = (Get-AzADServicePrincipal -ServicePrincipalName "$spname").Id


$members = @()    #cann add other members
#members += (Get-AzureADUser).id
$members += (Get-AzADServicePrincipal -ObjectId $SPObjId).Id

Add-AzADGroupMember -TargetGroupObjectId $ADgroupId -MemberObjectId $members  #add SP in security group

#create federated credential ; differs by environment variables
New-AzADAppFederatedCredential -ApplicationObjectId $SPObjId -Audience "$audience" -Issuer "$issuer" -name "$name" -Subject "$subject"

# Create Service Principal in Customer Tenant
#Connect-AzAccount –tenantId $ {{secrets.AZ_CLIENT_TENANTID}}
#New-AZADServicePrincipal -DisplayName $clientspn -Role "Owner" -Scope $clientscope

# Step 2 Azure Lighthourse - TODO, come back to this


