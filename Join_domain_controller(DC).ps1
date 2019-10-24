#Before run this script First thing you need to do is verify you can ping the DC server from the client machine by pinging the server’s hostname. If you can’t ping it by hostname, you are not going to be able to join the client to the domain.

#Change DNS settings to refer Active Directory Host(IP) 

#To do that Open Control Panel.
#Click on Network and Internet.
#Click on Network and Sharing Center.
#Click the Change adapter settings option in the left pane.
#Right-click the network interface connected to the internet, and select the Properties option
#Select and check the Internet Protocol Version 4 (TCP/IPv4) option.
#Click the Properties button.
#Click the Use the following DNS server addresses option.
#Type your "preferred" and "alternate" DNS addresses.

#If you have a DHCP server, then you can skip above step but make sure you are able to ping DC


$domain = "<Your Domain Name>"
#password of your Instance/server
$password = "Password of DC server/instance" | ConvertTo-SecureString -asPlainText -Force
#Use Domain Admin user or Administrator
$username = "$domain\Administrator"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential
