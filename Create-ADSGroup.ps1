param ($sgname, $spname)
 
Write-Host "Logging in to Azure AD"

Connect-AzAccount    #currently manual prompt, automated login still WIP

Write-Host "Create New AZ Security Group"  

New-AZADGroup -DisplayName "$sgname" -SecurityEnabled -MailNickName "NotSet"

Write-Host "Create new Service Principal"

New-AZADServicePrincipal -DisplayName "$spname"

Write-Host "Add Service Principal to Security Group"

$SPOjbID = (Get-AzADApplication -DisplayName $spname | Get-AzADServicePrincipal).Id
$members += @()                            #can add other members
$members += (Get-AZADServicePrincipal -ObjectId $SPOjbID).Id
$ADgroupId = (Get-AzADGroup -DisplayName $sgname).Id

Add-AZADGroupMember -TargetGroupObjectId $ADgroupId -MemberObjectId $members
