$ou = "OU=Workstations,OU=Computers,OU=IE001,OU=IE,OU=EVO,DC=eservice,DC=local"
$computers = Get-ADComputer -searchbase "$ou" -Filter *

$report = @()
foreach($x in $computers){

$bitlocker = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $x.DistinguishedName -Properties 'msFVE-RecoveryPassword'
$report += $bitlocker
}

$report | Export-Csv -path "c:\Test\CompBitLoc.csv" -Delimiter ";"
