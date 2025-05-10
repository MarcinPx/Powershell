# Script is creating/activating AD accounts, mailboxes for listed users from csv files
# Script was tested from AD server

# connecting to exchange
$output = import-PSSession (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://neptun001/PowerShell/ -Authentication Kerberos) -AllowClobber
 

# loading file with details for new users
$newusers = Import-Csv "E:\Test\newusers.csv" -Delimiter ";"

# loading data for existing users
$existingusers = Import-Csv "E:\Test\existinguser.csv" -Delimiter ";"

# loading AD groups for each role
$csroleADgroups = Import-Csv "E:\Test\customersupport.csv" -Delimiter ";"
$analystADgroups = Import-Csv "E:\Test\analyst.csv" -Delimiter ";"

# creating AD account for listed new users
foreach($x in $newusers){

# geting login of line manager
$managerEmail = $x.'Line manager email'
$manager = Get-ADUser -Filter {EmailAddress -eq $managerEmail} -Properties SamAccountName
$managerlogin = $manager.SamAccountName

New-ADUser -name ($x.Firstname + " " + $x.Surname) -Path "OU=Users,OU=Neptun,DC=neptun,DC=local" -GivenName $x.Firstname -Surname $x.Surname -SamAccountName $x.'AD login' -AccountPassword (ConvertTo-SecureString -AsPlainText $x.'AD pass' -Force) -ChangePasswordAtLogon $true -Title $x.Role -Company "Neptun" -DisplayName ($x.Firstname + " " + $x.Surname) -Department $x.Department -Enabled $true -Description "Testing account" -UserPrincipalName ($x.'AD login' + "@neptun.local") -Manager $managerlogin
$login = $x.'AD login'
# assigning AD groupsto users
if($x.Role -eq "Customer Support"){

foreach($group in $csroleADgroups){

    Add-ADGroupMember -Identity $group.groups -Members $login


}
}

If($x.Role -eq "Analyst"){

foreach($group in $analystADgroups){

    Add-ADGroupMember -Identity $group.groups -Members $login


}
}
Start-Sleep -Seconds 100
# creating mailbox for new user
Enable-Mailbox -Identity $login -DisplayName ($x.Firstname + " " + $x.Surname) -PrimarySmtpAddress $x.Email

}

# enabling existing users AD accounts and communication with mailboxes for outlook

foreach($y in $existingusers){

Enable-ADAccount -Identity $y.'AD login'
Set-ADAccountPassword -Identity $y.'AD login' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $y.'AD pass' -Force)
Set-ADUser -Identity $y.'AD login' -ChangePasswordAtLogon $true
Set-CASMailbox -Identity $y.'AD login' -MAPIEnabled $true

}

# creating doc with all accounts created/enabled for use by another python script newstarters.py which is sending emails with user details to designated people
$createdUsers = $newusers + $existingusers
$createdUsers | Export-Csv "E:\Test\createdusers.csv" -Delimiter ";" -NoTypeInformation

# removing files that were done
Remove-Item -Path "E:\Test\existinguser.csv"
Remove-Item -Path "E:\Test\newusers.csv"

# copy empty files to destination
Copy-Item "E:\Test\New\newusers.csv" -Destination "E:\Test"
Copy-Item "E:\Test\New\existinguser.csv" -Destination "E:\Test"
