$i = 0
$spacing = "`r`n`r"
$nic = Get-WmiObject -computer . -class "win32_networkadapterconfiguration" | Where-Object {$_.defaultIPGateway -ne $null}
$MyIP = $nic.ipaddress | select-object -first 1
$emptyIP = ($MyIP -replace '\d{1,3}$', '');
$trimIp = $emptyIP + '*'
$tested = Get-NetNeighbor -addressfamily ipv4 | where-object {($_.ipaddress -like $trimIP) -and ((55..255) -notcontains ($_.ipaddress -split '\.')[-1]) -and ($_.LinkLayerAddress -ne "000000000000")}

function TaskComplete{

    write-host -ForegroundColor Green "Task complete$spacing"    
    
}

$Marker_Click = 
{

    if ($AllToggle.CheckState -eq "Checked"){

        foreach($IPAddress in $tested){
            
            $Resolved = Resolve-DnsName $tested[$i].IPAddress
            $i += 1
            $ResolvedName = $Resolved.NameHost

            del \\$ResolvedName\d\environment\marker\*.*
            del \\$ResolvedName\d\xstore\tmp\xstore.anchor *> $null
            write-host -ForegroundColor Cyan "Deleted markers and anchor from $ResolvedName$spacing"
                
        
        } $i = 0
            TaskComplete
    }else{

    $RegMark = $REG.Text
    $ips = [System.Net.Dns]::GetHostAddresses("$RegMark").ipaddresstostring | clip
    del \\$RegMark\d\environment\marker\*.*
    write-host -ForegroundColor Cyan "$Regmark - Deleting markers$spacing"
    del \\$RegMark\d\xstore\tmp\xstore.anchor
    write-host -ForegroundColor Cyan "$Regmark - Deleting anchor$spacing"
    TaskComplete
        }
}

$TIME_Click = 
{
    if ($AllToggle.CheckState -eq "Checked"){

        $CurrentTZ = tzutil /g
        
        write-host "Controller timezone is $CurrentTZ$spacing" -ForegroundColor DarkYellow
        
       
        foreach($IPAddress in $tested){
            
            $Resolved = Resolve-DnsName $tested[$i].IPAddress
            $i += 1
            $ResolvedName = $Resolved.NameHost
            
            $dateTime = (Get-Date).AddSeconds(+2).ToString("hh:mm:ss tt")
            $writeTime = (Get-Date).AddSeconds(+3).ToString("hh:mm:ss tt")
            $CurrentTime = ([WMI]'').ConvertToDateTime((Get-WmiObject win32_operatingsystem -computername $Resolved.NameHost).LocalDateTime)
            write-host "Current time on $ResolvedName is $CurrentTime" -ForegroundColor Green
            write-host "Setting time to $writeTime on $ResolvedName" -ForegroundColor Cyan
            write-host "Setting timezone to $currentTZ on $ResolvedName$spacing" -foregroundcolor Yellow
            write-host "Resolving connection....$spacing"
            sshg3 [redacted]@$ResolvedName "tzutil /s $CurrentTZ" 
            sshg3 [redacted]@$ResolvedName "time $dateTime" *> $null
    
        
        }$i = 0
            TaskComplete
    } else{
        $RegTime = $REG.Text
        $CurrentTZ = tzutil /g
        write-host "Controller timezone is $CurrentTZ"
        $ips = [System.Net.Dns]::GetHostAddresses("$RegTime").ipaddresstostring | clip
        $dateTime = (Get-Date).AddSeconds(+3).ToString("hh:mm:ss tt")
        $writeTime = (Get-Date).AddSeconds(+3).ToString("hh:mm:ss tt")
        $CurrentTime = ([WMI]'').ConvertToDateTime((Get-WmiObject win32_operatingsystem -computername $RegTime).LocalDateTime)
        write-host "Current time on $RegTime is $CurrentTime" -ForegroundColor Green
        write-host "Setting time to $writetime on $RegTime" -ForegroundColor Cyan
        Write-Host "Setting timezone to $CurrentTZ"
        Write-Host "Authenticating......" -ForegroundColor Yellow
        sshg3 [redacted]@$RegTime "tzutil /s $CurrentTZ" *> $null
        sshg3 [redacted]@$RegTime "time $dateTime" 
        TaskComplete
      }
}

$OraDB12_Click = 
{

    if ($AllToggle.CheckState -eq "Checked"){

    

        foreach($IPAddress in $tested){
            
            $Resolved = Resolve-DnsName $tested[$i].IPAddress
            $i += 1
            $ResolvedName = $Resolved.NameHost

            sshg3 [redacted]@$ResolvedName "cmd.exe /c net stop OracleOraDB12Home1TNSListenerXSTORE"
            sshg3 [redacted]@$ResolvedName "cmd.exe /c net start OracleOraDB12Home1TNSListenerXSTORE"
            write-host "Restarted OracleOraDB12Home1TNSListenerXSTORE on $ResolvedName$spacing" -ForegroundColor Cyan 
            
    
        
        }$i=0
        TaskComplete
    }else{

    $Atom = $REG.Text
    sshg3 [redacted]@$Atom "cmd.exe /c net stop OracleOraDB12Home1TNSListenerXSTORE"
    sshg3 [redacted]@$Atom "cmd.exe /c net start OracleOraDB12Home1TNSListenerXSTORE"
    write-host "Restarted OracleOraDB12Home1TNSListenerXSTORE on $Atom$Spacing" -ForegroundColor Cyan
    TaskComplete
    }
}


$[redacted]_Click = 
{

    if ($AllToggle.CheckState -eq "Checked"){
        $Pform.ShowDialog()

        foreach($IPAddress in $tested){
            
            $Resolved = Resolve-DnsName $tested[$i].IPAddress
            $i += 1
            $ResolvedName = $Resolved.NameHost

            
            Write-Host "Unlocking [redacted] on $ResolvedName" -ForegroundColor Blue -BackgroundColor White
            sshg3 [redacted]@$ResolvedName "net user [redacted] /active:yes"

            Write-Host "Setting admin auto login on $ResolvedName" -ForegroundColor Blue -BackgroundColor White
            sshg3 [redacted]@$ResolvedName "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v AutoAdminLogon /d 1 /f" *> $null

            Write-Host "Setting [redacted] as default username on $ResolvedName" -ForegroundColor Blue -BackgroundColor White
            sshg3 [redacted]@$ResolvedName "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v DefaultUsername /d [redacted] /f" *> $null

            Write-Host "Setting auto login password on $ResolvedName" -ForegroundColor Blue -BackgroundColor White
            sshg3 [redacted]@$ResolvedName "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v DefaultPassword /d $CurrentPW /f" *> $null

            Write-Host "Restarting $ResolvedName" -ForegroundColor Red -BackgroundColor White
            shutdown /r /f -t 00 /m \\$ResolvedName
                       
    
        
        }$i=0
        TaskComplete
    }else{

    $RegHost = $REG.text    
    $Pform.ShowDialog()

    Write-Host "Unlocking [redacted] on $RegHost" -ForegroundColor Blue -BackgroundColor White
    sshg3 [redacted]@$RegHost "net user [redacted] /active:yes"

    Write-Host "Setting admin auto login on $RegHost" -ForegroundColor Blue -BackgroundColor White
    sshg3 [redacted]@$RegHost "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v AutoAdminLogon /d 1 /f" *> $null

    Write-Host "Setting [redacted] as default username on $RegHost" -ForegroundColor Blue -BackgroundColor White
    sshg3 [redacted]@$RegHost "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v DefaultUsername /d [redacted] /f" *> $null

    Write-Host "Setting auto login password on $RegHost" -ForegroundColor Blue -BackgroundColor White
    sshg3 [redacted]@$RegHost "reg add `"`"hklm\software\microsoft\windows nt\currentversion\winlogon`"`" /v DefaultPassword /d $CurrentPW /f" *> $null

    Write-Host "Restarting $RegHost" -ForegroundColor Red -BackgroundColor white
    shutdown /r /f -t 00 /m \\$RegHost
    TaskComplete
    }
}

$SubmitPW_Click =
{

    $global:CurrentPW = $REGPW.Text
    $pform.close()

}

$RebootReg_Click = 
{ 

    if ($AllToggle.CheckState -eq "Checked"){


        foreach($IPAddress in $tested){

            $Resolved = Resolve-DnsName $tested[$i].IPAddress
            $i += 1
            $ResolvedName = $Resolved.NameHost
            
            shutdown /r /f -t 00 /m \\$ResolvedName
            write-host "Restarting $ResolvedName$spacing"
                                
        }$i=0
        TaskComplete
    }else {
        
        $RebootNum = $REG.Text
        shutdown /r /f -t 00 /m \\$RebootNum
        write-host "Restarting $RebootNum$spacing"
        TaskComplete

    }
}

$FATAL_Click = 
{

   $FatalNum = $REG.text

   $findORA = select-string -Path \\$FatalNum\d\xstore\log\xstore.log -Pattern "ORA-00980"

   write-host -ForegroundColor Yellow "Testing SSH..."
   $SSH = C:\utils\psexec.exe \\$FatalNum cmd /c netstat -a -b | find ":22 "

    if($SSH -eq $null){
        write-host -ForegroundColor red "$spacing SSH not running. Starting now...$spacing"
        C:\utils\psexec.exe \\$FatalNum cmd /c net stop "tectia server" *> $null
        C:\utils\psexec.exe \\$FatalNum cmd /c net start "tectia server" *> $null
    }else {
        write-host -ForegroundColor Green "`r`nSSH online.$spacing"
    }

  
    $ips = [System.Net.Dns]::GetHostAddresses("$FatalNum").ipaddresstostring
    $ips | clip
    write-host -ForegroundColor Cyan "Deleting markers and anchor$spacing"
    del \\$FatalNum\d\environment\marker\*.*
    del \\$FatalNum\d\xstore\tmp\xstore.anchor
    write-host -foregroundcolor cyan "Restarting ORADB12$spacing"
    sshg3 [redacted]@$FatalNum "net stop OracleOraDB12Home1TNSListenerXSTORE"
    sshg3 [redacted]@$FatalNum "net start OracleOraDB12Home1TNSListenerXSTORE"


   if($findORA -eq $null){
        write-host -ForegroundColor Red -BackgroundColor White "NOT ORA-00980. Have to run atom restore-nightly-db-backup"
   }

   else{
    write-host -foregroundcolor Green "Found ORA-00980"
    write-host "Running SQL fix...$spacing" -ForegroundColor Cyan
    new-item -Path \\$fatalNum\d -Name "SQLRUN.BAT" -ItemType "file" -Value "echo exit | sqlplus / as sysdba @D:\pos_missing_synonym.sql"
    sshg3 [redacted]@$FatalNum "Copy d:\environment\cust_config\version1\pos_missing_synonym.sql D:" 
    sshg3 [redacted]@$FatalNum "D:\SQLRUN.BAT"
    del \\$fatalNum\d\sqlrun.bat
    write-host -ForegroundColor Cyan "Register IP: $ips"
    $spacing
    TaskComplete

}
    
    
}


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '346,200'
$Form.text                       = "Registers"
$Form.TopMost                    = $true
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false
$Form.StartPosition = "manual"
$Form.Location = New-Object System.Drawing.Size(610, 170)

$MARKER                           = New-Object system.Windows.Forms.Button
$MARKER.text                      = "MARKER"
$MARKER.width                     = 66
$MARKER.height                    = 25
$MARKER.location                  = New-Object System.Drawing.Point(241,140)
$MARKER.Font                      = 'Microsoft Sans Serif,8'
$MARKER.Add_Click($MARKER_Click)

$TIME                            = New-Object system.Windows.Forms.Button
$TIME.text                       = "TIME"
$TIME.width                      = 66
$TIME.height                     = 25
$TIME.location                   = New-Object System.Drawing.Point(40,90)
$TIME.Font                       = 'Microsoft Sans Serif,8'
$TIME.Add_Click($TIME_Click)

$[redacted]                            = New-Object system.Windows.Forms.Button
$[redacted].text                       = "[redacted]"
$[redacted].width                      = 66
$[redacted].height                     = 25
$[redacted].location                   = New-Object System.Drawing.Point(140,90)
$[redacted].Font                       = 'Microsoft Sans Serif,8'
$[redacted].Add_Click($[redacted]_Click)

$FATAL                           = New-Object system.Windows.Forms.Button
$FATAL.text                      = "FATAL"
$FATAL.width                     = 66
$FATAL.height                    = 25
$FATAL.location                  = New-Object System.Drawing.Point(140,140)
$FATAL.Font                      = 'Microsoft Sans Serif,8'
$FATAL.Add_Click($FATAL_Click)

$ORADB12                          = New-Object system.Windows.Forms.Button
$ORADB12.text                     = "ORADB12"
$ORADB12.width                    = 66
$ORADB12.height                   = 25
$ORADB12.location                 = New-Object System.Drawing.Point(40,140)
$ORADB12.Font                     = 'Microsoft Sans Serif,8'
$ORADB12.Add_Click($ORADB12_Click)

$RebootReg                             = New-Object system.Windows.Forms.Button
$RebootReg.text                        = "REBOOT"
$RebootReg.width                       = 66
$RebootReg.height                      = 25
$RebootReg.location                    = New-Object System.Drawing.Point(241,90)
$RebootReg.Font                        = 'Microsoft Sans Serif,8'
$RebootReg.Add_Click($RebootReg_Click)

$REG                           = New-Object system.Windows.Forms.TextBox
$REG.multiline                 = $false
$REG.text                      = "REG01"
$REG.width                     = 266
$REG.height                    = 30
$REG.location                  = New-Object System.Drawing.Point(41,18)
$REG.Font                      = 'Microsoft Sans Serif,10'

$AllToggle                    = New-Object System.Windows.Forms.CheckBox
$AllToggle.text               = "Execute on all registers"
$AllToggle.AutoSize           = $true
$AllToggle.width              = 104
$AllToggle.height             = 20
$AllToggle.visible            = $true
$AllToggle.enabled            = $true
$AllToggle.location           = New-Object System.Drawing.Point(85,52)
$AllToggle.Font               = 'Microsoft Sans Serif,11'

$Form.controls.AddRange(@($marker,$time,$[redacted],$Fatal,$REG,$RebootReg,$ORADB12,$AllToggle))



$PForm                            = New-Object system.Windows.Forms.Form
$PForm.ClientSize                 = '346,150'
$PForm.text                       = "Password"
$PForm.TopMost                    = $true
$PForm.FormBorderStyle = 'Fixed3D'
$PForm.MaximizeBox = $false

$REGPW                           = New-Object system.Windows.Forms.TextBox
$REGPW.multiline                 = $false
$REGPW.width                     = 266
$REGPW.height                    = 30
$REGPW.Text                      = "Current [redacted] Password"
$REGPW.location                  = New-Object System.Drawing.Point(41,28)
$REGPW.Font                      = 'Microsoft Sans Serif,10'


$SubmitPW                             = New-Object system.Windows.Forms.Button
$SubmitPW.text                        = "Submit"
$SubmitPW.width                       = 66
$SubmitPW.height                      = 35
$SubmitPW.location                    = New-Object System.Drawing.Point(135,80)
$SubmitPW.Font                        = 'Microsoft Sans Serif,12'
$SubmitPW.Add_Click($SubmitPW_Click)

$PForm.controls.AddRange(@($REGPW, $SubmitPW))
$form.ShowDialog()

  
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force