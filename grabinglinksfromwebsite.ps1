#This script is collecting links from website


#creating inputbox to grab website to search
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$computer = [Microsoft.VisualBasic.Interaction]::InputBox("Website", "Enter a website to search", "https://abacus.ie/")

#opening IE and navigating to website
$ie = New-Object -ComObject internetexplorer.application
$ie.Visible = $true
# $ie | Get-Member
$ie.Navigate($Computer)


Start-Sleep 2


#searching through website for input boxes
$document = $ie.Document
$document.IHTMLDocument3_getElementsByTagName("input") | Select-Object Type,Name


Start-Sleep 4


#grabbing links from website and diplaying on console
$cos = $ie.Document.links | Select-Object outerText,href | ft
$cos


