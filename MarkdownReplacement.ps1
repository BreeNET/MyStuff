#Gets system IP info
$nic = gwmi -computer . -class "win32_networkadapterconfiguration" | Where-Object {$_.defaultIPGateway -ne $null}
$IP = $nic.ipaddress | select-object -first 1
$trimIP = $IP -replace ".{3}$"
$ServerIP = $nic.ipaddress | select-object -first 1
$netMask = $nic.ipsubnet | select-object -first 1
$gateway = (Get-wmiObject Win32_networkAdapterConfiguration | ?{$_.IPEnabled}).DefaultIPGateway


#Creates dialog box for QLN or 6110/7850
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Markdown Replacement'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'
$DIGIButton = New-Object System.Windows.Forms.Button
$DIGIButton.Location = New-Object System.Drawing.Point(75,120)
$DIGIButton.Size = New-Object System.Drawing.Size(75,23)
$DIGIButton.Text = '7850/6110'
$DIGIButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $DIGIButton
$form.Controls.Add($DIGIButton)
$QLNButton = New-Object System.Windows.Forms.Button
$QLNButton.Location = New-Object System.Drawing.Point(150,120)
$QLNButton.Size = New-Object System.Drawing.Size(75,23)
$QLNButton.Text = 'QLN320'
$QLNButton.DialogResult = [System.Windows.Forms.DialogResult]::CANCEL
$form.CancelButton = $QLNButton
$form.Controls.Add($QLNButton)
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,50)
$label.Text = " Which unit is being replaced? "
$form.Controls.Add($label)
$form.Topmost = $true


#Show dialog box
$result = $form.ShowDialog()
    
    #"OK"=DIGI
    #Run ping tests on handheld IP addresses
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)

    {

        $digiIPS = @("152","153","154","155","156","157")
        #test PDA
        foreach($digiIP in $digiIPS){


        #if ping fails set the info to the clipboard
        if (-not(Test-Connection "$trimIP$digiIP" -Quiet -Count 1)) {

            $digiIP = "$trimIP$digiIP"

            write-host 'Testing '$digiIP

            $clipboard =  "Model: ", "Serial Number: ", "Asset: ", "IP Address: $digiIp","Subnet: $netMask","Gateway: $gateway", "Server IP: $ServerIP", "Tracking Number: " | C:\Windows\System32\clip.exe

            break;

        }
    }

    }

    Else

    {
            #test QLN320 IPs
            $qlnIPS = @("142","143","144","145","146","147","148","149","150","151")


            foreach($qlnIP in $qlnIPS){

                #if ping fails set the info to the clipboard
                if (-not(Test-Connection "$trimIP$qlnIP" -Quiet -Count 1)) {

                    $qlnIP = "$trimIP$qlnIP"

                    write-host $qlnIP

                    $clipboard = "Model: QLN320","Serial Number: ", "Asset: ", "IP Address: $qlnIp","Subnet: $netMask","Gateway: $gateway", "Server IP: $ServerIP", "Tracking Number: " | C:\Windows\System32\clip.exe

                    break;

                }
            }  

    }

    Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force