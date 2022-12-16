# Inputs needed 

# Customer tenant
# Subscription Id
# Client Name

#initialization/Installation

$tenantid = ${{ secrets.AZURE_TENANTID}}#could be added in secrets 
$SPname = ${{ secrets.AZ_SP_NAME }}
$Gname = ${{secrets.AZ_GROUP_NAME}}
$ADgroupId = (Get-AzADGroup -DisplayName $Gname).Id
$SPObjId = (Get-AzADServicePrincipal -ServicePrincipalName $SPname).Id
$audience = ${{ secrets.FC_audience }}
$issuer = ${{ secrets.FC_Issuer }}
$name = ${{ secrets.FC_Name }}
$subject = ${{ secrets.FC_Subject }}

#cann add other members
$members = @()
$members += (Get-AzADServicePrincipal -ObjectId $SPObjId).Id

#Install-Module -Name Az -Force
#Install-Module -name AzureAD -Force
Connect-AzAccount -TenantId $tenantid

# Create the Azure resources in our tenant:

# * Security Group  - “{Client Name} (Azure Contributor)” 
New-AzADGroup -DisplayName $Gname -SecurityEnabled #ok

# * Service Principal  - ClientName (Service Operations)
New-AzADServicePrincipal -DisplayName  $SPname #ok

#Add Group Members

#$User = "{user.name@sodadigital.com.au}"
#$UserObj = Get-AzureADUser -ObjectId $User
 
#Add-AzADGroupMember -ObjectId $UserObj.ObjectId
#Add-AzADGroupMember -ObjectId 31f1ff6c-d48c-4f8a-b2e1-abca7fd399df

# * Add this service principal (SP) to the above group

Add-AzADGroupMember -TargetGroupObjectId $ADgroupId -MemberObjectId $members

# * Setup federated credentials against the above SP
#Change Name & Subject per Federated Credential

New-AzADAppFederatedCredential -ApplicationObjectId $SPObjId -Audience $audience -Issuer $issuer -name $name -Subject $subject

# * Login to customer tenant az login --tenant TENANT_ID

#Connect to Azure Active Directory
Connect-AzAccount –tenantId $ {{secrets.AZ_CLIENT_TENANTID}}

# * Create a SP in their tenant - az ad sp create-for-rbac -n "<Client Name> (Soda Digital Client Operations)"
# * Assign this SP the owner role - az role assignment create --assignee "<object Id of the above created user> " --role "Owner" --scope "/subscriptions/<subscription id>"
New-AZADServicePrincipal -DisplayName $ {{ secrets.Client_SPN }} -Role "Owner" -Scope $ {{ $secrets.SP_Scope }}

# * Note the password created and store in 1pass.

# Step 2 Azure Lighthourse - TODO, come back to this


