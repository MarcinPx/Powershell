#This script: generating report with send/recivied emails for given date range per user. 
#By default Exchange have retention policy for the logs which is 30 days, so that mean you can back up to 30 days.
#This can be changed on the server by powershell commands, bear in mind that increasing retention time
#will increase storage use on the server.



#loading managment for exchange 2010
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

#selecting date from when you will search for 
$startdate = (get-date -Year 2018 -Month 09 -Day 1)

#selecting date to when you will search
$EndDate = (get-date -Year 2018 -Month 09 -Day 30) 

#creating array to hold your results
$array = @()



#getting all mailboxes objects
$address = get-mailbox


#do calculation per user
foreach($smtpaddress in $address){
    

    #retriving email address for user
    $email = ($smtpaddress.primarysmtpaddress).tostring()
    $user = ($smtpaddress.name).ToString()


    #counting sent emails
    $sent = (Get-TransportServer | Get-MessageTrackingLog -ResultSize Unlimited -Start $StartDate -End $EndDate -Sender $email -EventID RECEIVE).count #sent items

    #counting recivied emails
    $recivied = (Get-TransportServer | Get-MessageTrackingLog -ResultSize Unlimited -Start $StartDate -End $EndDate -Recipients $email -EventID DELIVER).count # recivied items

    #creating row for table and assign results
    $row = "" | Select Name, Email, Sent, Recivied
    $row.name = $user
    $row.email = $email
    $row.Sent = $sent
    $row.Recivied = $recivied

    #putting result per user to array
    $array = $array + $row


}

#exporting all results to file
$array | Export-csv "c:\test\emails.csv"
