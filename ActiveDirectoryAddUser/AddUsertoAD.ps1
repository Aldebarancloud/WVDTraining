#############################################
#    Create a New Active Directory Group    #
#############################################
$AdGroup = "VDIuser"
$Path = "OU=WVD-Users,OU=IT,DC=LAB,DC=INTRA"

New-AdGroup -Name "SysAdmin" -GroupScope Global -Path "OU=Groups,OU=IT,DC=LAB,DC=INTRA"
#Value hard coded for the Path for demo purpose#

##################################
#    Azure AD Users Variables    #
##################################
$DomainName = 'demo'
$DomainSuffix = 'com'
$FQDN = "$DomainName.$DomainSuffix"
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = Read-Host -Prompt "Enter Default Password" -AsSecureString
$PasswordProfile.EnforceChangePasswordPolicy = $false
$PasswordProfile.ForceChangePasswordNextLogin = $false

###############################
#    Create Azure AD Users    #
###############################
 $AzureADUsersList = @(                                 
	,@("AdamWarlock",     "AdamWarlock@$FQDN")
	,@("Batman",          "Batman@$FQDN")
	,@("AlfredPennyworth",          "AlfredPennyworth@$FQDN")
	,@("Robin",          "Robin@$FQDN")
	,@("DickGrayson",          "DickGrayson@$FQDN")
	,@("Batgirl",          "Batgirl@$FQDN")
	,@("RedRobin",          "RedRobin@$FQDN")
	,@("Nigthwing",          "Nigthwing@$FQDN")
	,@("JasonTodd",          "JasonTodd@$FQDN")
	,@("DamianWayne",          "DamianWayne@$FQDN")
	,@("TimDrake",      "TimDrake@$FQDN") 
	,@("BarbaraGordon",  "BarbaraGordon@$FQDN") 
	,@("Catwoman",       "Catwoman@$FQDN") 
	,@("SelinaKyle",          "SelinaKyle@$FQDN  ") 
	,@("RedHood",            "RedHood@$FQDN")             
	,@("AceLeBatChien",       "AceLeBatChien@$FQDN") 
	,@("Batwoman",        "Batwoman@$FQDN") 
	,@("KathyKane",            "KathyKane@$FQDN") 
	,@("Rocket",          "Rocket@$FQDN") 
    ,@("TerryMcGinnis",       "TerryMcGinnis@$FQDN") 
    ,@("Joker",        "Joker@$FQDN") 
    ,@("Superman",        "Superman@$FQDN") 
    ,@("HarleyQuinn",            "HarleyQuinn@$FQDN") 
    ,@("GreenArrow",     "GreenArrow@$FQDN") 
) 
ForEach($RM in $AzureADUsersList) {  
    $RM_Name =  $Prefix + $RM[0]
    $RM_Email = $RM[1]
     New-AzureADUser `
        -DisplayName $RM_Name `
        -PasswordProfile $PasswordProfile `
        -UserPrincipalName $RM_Email `
        -AccountEnabled $true `
        -MailNickName $RM_Name `
        -Verbose
}

###################################
#    Add Users to the AD Group    #
###################################

Add-AdGroupMember -Identity $AdGroup -Members AdamWarlock, Batman, AlfredPennyworth, Robin, DickGrayson, Batgirl, RedRobin, Nigthwing, JasonTodd, DamianWayne, TimDrake, BarbaraGordon, Catwoman, SelinaKyle, RedHood, AceLeBatChien, Batwoman, KathyKane, TerryMcGinnis, Joker, Superman, HarleyQuinn, GreenArrow   