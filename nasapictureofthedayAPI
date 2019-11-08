#Script is connecting to nasa api, taking location of picture of the day, and is displaying this in webform webbrowser

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$data = Invoke-RestMethod -Uri "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY" -Method Get




$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = "Nasa Picture of the Day"
$main_form.Width = 1050
$main_form.Height = 840
$main_form.AutoSize = $true
$main_form.StartPosition = "CenterScreen"

$webbrowser = New-Object System.Windows.Forms.WebBrowser
$webbrowser.Width = 1050
$webbrowser.Height = 840
$webbrowser.AutoSize = $true
$webbrowser.Location = New-Object System.Drawing.Point(0, 0)
$webbrowser.navigate($data.url)
$main_form.Controls.Add($webbrowser)


$main_form.ShowDialog()



