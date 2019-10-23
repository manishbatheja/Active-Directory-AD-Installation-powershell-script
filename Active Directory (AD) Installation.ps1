Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

#Declare variables
$DatabasePath = "c:\windows\NTDS"
$DomainMode = "WinThreshold"
#$DomainName = "centos.com"
$DomainName = "<Your-Domain-Name>"
#NetBIOS names are also registered for groups of computers that provide network services. For example, if centos.com is a domain controller, it will register that NetBIOS name (CENTOS) and will register names that identify its role as a domain controller in the CENTOS domain at the same time. This allows clients to search for all NetBIOS hosts that provide domain controller services in the CENTOS domain without the client knowing the actual names of the domain controllers. 
$DomaninNetBIOSName = "<YOUR NetBIOSName>"
$ForestMode = "WinThreshold"
$LogPath = "c:\windows\NTDS"
$SysVolPath = "c:\windows\SYSVOL"
$featureLogPath = "c:\windows\featurelog.txt" 
$Password = "<Your Safe Mode Password Please ensure it matches the Password complexity>"
$SecureString = ConvertTo-SecureString $Password -AsPlainText -Force

#Install AD DS, DNS and GPMC 
start-job -Name addFeature -ScriptBlock { 
Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools } 
Wait-Job -Name addFeature 
Get-WindowsFeature | Where installed >>$featureLogPath

#Create New AD Forest

Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath $DatabasePath -DomainMode $DomainMode -DomainName $DomainName -SafeModeAdministratorPassword $SecureString -DomainNetbiosName $DomainNetBIOSName -ForestMode $ForestMode -InstallDns:$true -LogPath $LogPath -NoRebootOnCompletion:$false -SysvolPath $SysVolPath -Force:$true
Restart-Computer -Wait -For PowerShell -Timeout 300 -Delay 2
echo $hostname >>$featureLogPath
