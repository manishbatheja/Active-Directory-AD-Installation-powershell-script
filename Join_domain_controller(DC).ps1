$domain = "<Your Domain Name>"
#password of your Instance/server
$password = "Password of DC server/instance" | ConvertTo-SecureString -asPlainText -Force
#Use Domain Admin user or Administrator
$username = "$domain\Administrator"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential