param($GroupDisplayName, $TenantID, $SPDisplayName)

New-AZADGroup -DisplayName $GroupDisplayName -SecurityEnabled

New-AZADServicePrincipal -DisplayName $SPDisplayName

$SPOjbID = (Get-AZADServicePrincipal -ServicePrincipalName $SPDisplayName).Id
$members += @()                            #can add other members
$members += (Get-AZADServicePrincipal -ObjectId $SPObjID).Id
$ADgroupId = (Get-AzADGroup -DisplayName $GroupDisplayName).Id

Add-AZADGroupMember -TargetGroupObjectId $ADgroupId -MemberObjectId $members
