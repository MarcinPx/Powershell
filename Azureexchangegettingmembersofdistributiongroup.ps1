#this script: Is getting list of members from Distribution group on 365 emails


#login details for 365
$UserCredential = Get-Credential

#creating session with azure
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

#getting memebers of distribution group and sending to file c:\test.csv (to change group put -identity "name of the group"
Get-UnifiedGroupLinks -Identity Squad -LinkType members | select Displayname, recipienttype, primarysmtpaddress | export-csv C:\test.csv

#removing session
remove-pssession $session
