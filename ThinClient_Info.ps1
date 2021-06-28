$ASMTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $asmIP = "194"
    $asmGW = "222"
    $asmSub = "255.255.255.224"
    

    $clipboard = "ASM thin client" , "IP Address: $trimIP$asmIP","Gateway: $trimIP$asmGW","Subnet: $asmSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}

$LPTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $IP = "122"
    $lpGW = "126"
    $lpSub = "255.255.255.128"
    

    $clipboard = "Loss Prevention thin client" , "IP Address: $trimIP$IP","Gateway: $trimIP$lpGW","Subnet: $lpSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}

$CTRLTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $IP = "123"
    $lpGW = "126"
    $lpSub = "255.255.255.128"
    

    $clipboard = "Controller thin client" , "IP Address: $trimIP$IP","Gateway: $trimIP$lpGW","Subnet: $lpSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}

$COTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $coIP = "198"
    $coGW = "222"
    $coSub = "255.255.255.224"
    

    $clipboard = "Cash Office thin client" , "IP Address: $trimIP$coIP","Gateway: $trimIP$coGW","Subnet: $coSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}

$VTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $vtcIP = "217"
    $vtcGW = "222"
    $vtcSub = "255.255.255.224"
    

    $clipboard = "Virtual Timeclock thin client" , "IP Address: $trimIP$vtcIP","Gateway: $trimIP$vtcGW","Subnet: $vtcSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}

$MGRTC_Click = 
{
    $pinger = $STORE.Text
    $ip = [System.Net.Dns]::GetHostAddresses(“$pinger“).IPAddressToString
    $trimIP = $ip -replace ".{3}$"
    $mgrIP = "199"
    $mgrGW = "222"
    $mgrSub = "255.255.255.224"
    

    $clipboard = "Manager thin client" , "IP Address: $trimIP$mgrIP","Gateway: $trimIP$mgrGW", "Subnet: $mgrSub", ""  | C:\Windows\System32\clip.exe
    $wshell = New-Object -ComObject Wscript.Shell

    $wshell.Popup("Copied to clipboard",0,"Done",0x1)
}


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '346,200'
$Form.text                       = "Thin Client Replacement"
$Form.TopMost                    = $true
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false

$ASMTC                           = New-Object system.Windows.Forms.Button
$ASMTC.text                      = "ASMTC"
$ASMTC.width                     = 66
$ASMTC.height                    = 25
$ASMTC.location                  = New-Object System.Drawing.Point(241,140)
$ASMTC.Font                      = 'Microsoft Sans Serif,8'
$ASMTC.Add_Click($ASMTC_Click)

$LPTC                            = New-Object system.Windows.Forms.Button
$LPTC.text                       = "LPTC"
$LPTC.width                      = 66
$LPTC.height                     = 25
$LPTC.location                   = New-Object System.Drawing.Point(40,80)
$LPTC.Font                       = 'Microsoft Sans Serif,8'
$LPTC.Add_Click($LPTC_Click)

$COTC                            = New-Object system.Windows.Forms.Button
$COTC.text                       = "COTC"
$COTC.width                      = 66
$COTC.height                     = 25
$COTC.location                   = New-Object System.Drawing.Point(140,80)
$COTC.Font                       = 'Microsoft Sans Serif,8'
$COTC.Add_Click($COTC_Click)

$MGRTC                           = New-Object system.Windows.Forms.Button
$MGRTC.text                      = "MGRTC"
$MGRTC.width                     = 66
$MGRTC.height                    = 25
$MGRTC.location                  = New-Object System.Drawing.Point(140,140)
$MGRTC.Font                      = 'Microsoft Sans Serif,8'
$MGRTC.Add_Click($MGRTC_Click)

$CTRLTC                          = New-Object system.Windows.Forms.Button
$CTRLTC.text                     = "CTRLTC"
$CTRLTC.width                    = 66
$CTRLTC.height                   = 25
$CTRLTC.location                 = New-Object System.Drawing.Point(40,140)
$CTRLTC.Font                     = 'Microsoft Sans Serif,8'
$CTRLTC.Add_Click($CTRLTC_Click)

$VTC                             = New-Object system.Windows.Forms.Button
$VTC.text                        = "VTC"
$VTC.width                       = 66
$VTC.height                      = 25
$VTC.location                    = New-Object System.Drawing.Point(241,80)
$VTC.Font                        = 'Microsoft Sans Serif,8'
$VTC.Add_Click($VTC_Click)

$STORE                           = New-Object system.Windows.Forms.TextBox
$STORE.multiline                 = $false
$STORE.text                      = "MAR0123"
$STORE.width                     = 266
$STORE.height                    = 30
$STORE.location                  = New-Object System.Drawing.Point(41,28)
$STORE.Font                      = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($ASMTC,$LPTC,$COTC,$MGRTC,$STORE,$VTC,$CTRLTC))


$result = $form.ShowDialog()