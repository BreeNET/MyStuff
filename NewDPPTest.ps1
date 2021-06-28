$nic = gwmi -computer . -class "win32_networkadapterconfiguration" | Where-Object {$_.defaultIPGateway -ne $null}
$MyIP = $nic.ipaddress | select-object -first 1
$emptyIP = ($MyIP -replace '\d{1,3}$', '');
$trimIp = $emptyIP + '*'
$tested = Get-NetNeighbor -addressfamily ipv4 | where-object {($_.ipaddress -like $trimIP) -and ((122..127) -notcontains ($_.ipaddress -split '\.')[-1]) -and ($_.LinkLayerAddress -ne "000000000000")}
$testerd = $tested.IPAddress


$Reg1_Click = {
    

    $RegNum = "Register 01"
    $DPPIP = $EmptyIP+66
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    write-host "Running diagnostics on $RegNum. Please wait..."

    $DPPIP = $EmptyIP+66
    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg01 "net stop \[redacted]\[redacted]\PointBridge"
    Remove-Item -path "\\reg01\d\program files\[redacted]\[redacted]\pinpad.*"
    Remove-Item -path "\\reg01\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"        
    $SStart = sshg3 [redacted]@reg01 "net start \[redacted]\[redacted]\Pointbridge"
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG01 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green 
    remove-item -path C:\Users\[redacted]\DPP.TXT



}

$Reg2_Click = {
    

    $RegNum = "Register 02"
    $DPPIP = $EmptyIP+67
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg02 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg02\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg02\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"       
    $SStart = sshg3 [redacted]@reg02 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG02 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT
}

$Reg3_Click = {
    

    $RegNum = "Register 03"
    $DPPIP = $EmptyIP+68
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg03 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg03\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg03\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"        
    $SStart = sshg3 [redacted]@reg03 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG03 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT

}

$Reg4_Click = {
    

    $RegNum = "Register 04"
    $DPPIP = $EmptyIP+69
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg04 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg04\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg04\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"         
    $SStart = sshg3 [redacted]@reg04 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG04 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT
    
}

$Reg5_Click = {
    

    $RegNum = "Register 05"
    $DPPIP = $EmptyIP+70
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    Write-Host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg05 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg05\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg05\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"         
    $SStart = sshg3 [redacted]@reg05 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG05 /r /f -t 00
     $clipboard = ,"S/N: ","ASSET TAG: ","" | clip.exe
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg6_Click = {
    

    $RegNum = "Register 06"
    $DPPIP = $EmptyIP+71
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg06 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg06\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg06\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"       
    $SStart = sshg3 [redacted]@reg06 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG06 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg7_Click = {
    

    $RegNum = "Register 07"
    $DPPIP = $EmptyIP+72
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg07 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg07\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg07\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"        
    $SStart = sshg3 [redacted]@reg07 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG07 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  

}

$Reg8_Click = {
    

    $RegNum = "Register 08"
    $DPPIP = $EmptyIP+73
    write-host "Running diagnostics on $RegNum. Please wait..."
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg08 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg08\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg08\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"       
    $SStart = sshg3 [redacted]@reg08 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG08 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg9_Click = {
    

    $RegNum = "Register 09"
    $DPPIP = $EmptyIP+74
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue

    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg09 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg09\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg09\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"        
    $SStart = sshg3 [redacted]@reg09 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG09 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg10_Click = {
    

    $RegNum = "Register 10"
    $DPPIP = $EmptyIP+75
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host  "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg10 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg10\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg10\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"       
    $SStart = sshg3 [redacted]@reg10 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG10 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg11_Click = {
    

    $RegNum = "Register 11"
    $DPPIP = $EmptyIP+76
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg11 "net stop \[redacted]\[redacted]\PointBridge"   
    remove-item "\\reg11\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg11\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"
    $SStart = sshg3 [redacted]@reg11 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG11 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg12_Click = {
    

    $RegNum = "Register 12"
    $DPPIP = $EmptyIP+77
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg12 "net stop \[redacted]\[redacted]\PointBridge"  
    remove-item "\\reg12\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg12\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"       
    $SStart = sshg3 [redacted]@reg12 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG12 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
}

$Reg25_Click = {
    

    $RegNum = "Register 25"
    $DPPIP = $EmptyIP+90
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg25 "net stop \[redacted]\[redacted]\PointBridge"  
    remove-item "\\reg25\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg25\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"      
    $SStart = sshg3 [redacted]@reg25 "net start \[redacted]\[redacted]\PointBridge" 
    write-host -ForegroundColor Yellow "Restarting $RegNum"
    shutdown /m \\REG25 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  

}

$Reg26_Click = {
    

    $RegNum = "Register 26"
    $DPPIP = $EmptyIP+91
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg26 "net stop \[redacted]\[redacted]\PointBridge" 
    remove-item "\\reg26\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg26\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"      
    $SStart = sshg3 [redacted]@reg26 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host "Restarting $RegNum"
    shutdown /m \\REG26 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  

}

$Reg50_Click = {
    

    $RegNum = "Register 50"
    $DPPIP = $EmptyIP+115
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg50 "net stop \[redacted]\[redacted]\PointBridge"    
    remove-item "\\reg50\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg50\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt"     
    $SStart = sshg3 [redacted]@reg50 "net start \[redacted]\[redacted]\Pointbridge"
    Write-Host -ForegroundColor Yellow "Restarting $RegNUM"
    shutdown /m \\REG50 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
    remove-item -path C:\Users\[redacted]\DPP.TXT  
    

}

$Reg51_Click = {
    

    $RegNum = "Register 51"
    $DPPIP = $EmptyIP+116
    New-Item -Path C:\Users\[redacted]\Desktop\DPP.TXT -ErrorAction SilentlyContinue
    write-host "Running diagnostics on $RegNum. Please wait..."

    $pingtest = ping $DPPIP
    $SStop = sshg3 [redacted]@reg51 "net stop \[redacted]\[redacted]\PointBridge"
    remove-item "\\reg51\d\program files\[redacted]\[redacted]\pinpad.*"
    remove-item "\\reg51\d\program files\[redacted]\[redacted]\\[redacted]\[redacted]\pointbridge_Status.txt" 
    $SStart = sshg3 [redacted]@reg51 "net start \[redacted]\[redacted]\PointBridge" 
    Write-Host -ForegroundColor Yellow "Restarting $RegNum"
    shutdown /m \\REG51 /r /f -t 00
    Add-Content -path C:\Users\[redacted]\DPP.TXT -value "Stopped interac on controller: ","",$istop,"","Started Interac on controller: ","",$istart,"","Stopped SVC Database:","",$svcstop,"","Started SVC Databsae: ","",$svcstart,"","Pin pad ping test:","",$pingtest,"","Stopped pointbridge on $RegNum","",$SStop,"","Started Pointbridge on $RegNum","",$SStart,""
    $output = Get-Content -Path C:\Users\[redacted]\DPP.TXT -raw
    $output | clip.exe
    write-host $output -ForegroundColor Green
     

}

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                         = New-Object system.Windows.Forms.Form
$Form.ClientSize              = '425,300'
$Form.text                    = "Pinpad Reset"
$Form.TopMost                 = $true
$Form.FormBorderStyle         = 'Fixed3D'
$Form.MaximizeBox             = $false
$Form.StartPosition           = "Centerscreen"
$Form.BackColor               = "#14B5CB"
$Form.Location = New-Object System.Drawing.Size(610, 170)

$Reg1                         = New-Object system.Windows.Forms.Button
$Reg1.text                    = "Reg 1"
$Reg1.width                   = 75
$Reg1.height                  = 30
$Reg1.location                = New-Object System.Drawing.Point(25,60)
$Reg1.Name                    = "Reg1"
$Reg1.Font                    = 'Arial Rounded MT,10'
$Reg1.Enabled                 = $false
$Reg1.BackColor               = "#ff4c4c"
$Reg1.Add_Click($Reg1_Click)

$Reg2                         = New-Object system.Windows.Forms.Button
$Reg2.text                    = "Reg 2"
$Reg2.width                   = 75
$Reg2.height                  = 30
$Reg2.location                = New-Object System.Drawing.Point(125,60)
$Reg2.Name                    = "Reg2"
$Reg2.Font                    = 'Arial Rounded MT,10'
$Reg2.Enabled                 = $false
$Reg2.BackColor               = "#ff4c4c"
$Reg2.Add_Click($Reg2_Click)

$Reg3                         = New-Object system.Windows.Forms.Button
$Reg3.text                    = "Reg 3"
$Reg3.width                   = 75
$Reg3.height                  = 30
$Reg3.location                = New-Object System.Drawing.Point(225,60)
$Reg3.Name                    = "Reg3"
$Reg3.Font                    = 'Arial Rounded MT,10'
$Reg3.Enabled                 = $false
$Reg3.BackColor               = "#ff4c4c"
$Reg3.Add_Click($Reg3_Click)

$Reg4                         = New-Object system.Windows.Forms.Button
$Reg4.text                    = "Reg 4"
$Reg4.Name                    = "Reg4"
$Reg4.width                   = 75
$Reg4.height                  = 30
$Reg4.location                = New-Object System.Drawing.Point(325,60)
$Reg4.Font                    = 'Arial Rounded MT,10'
$Reg4.Enabled                 = $false
$Reg4.BackColor               = "#ff4c4c"
$Reg4.Add_Click($Reg4_Click)

$Reg5                         = New-Object system.Windows.Forms.Button
$Reg5.text                    = "Reg 5"
$Reg5.Name                    = "Reg5"
$Reg5.width                   = 75
$Reg5.height                  = 30
$Reg5.location                = New-Object System.Drawing.Point(25,120)
$Reg5.Font                    = 'Arial Rounded MT,10'
$Reg5.Enabled                 = $false
$Reg5.BackColor               = "#ff4c4c"
$Reg5.Add_Click($Reg5_Click)

$Reg6                         = New-Object system.Windows.Forms.Button
$Reg6.text                    = "Reg 6"
$Reg6.Name                    = "Reg6"
$Reg6.width                   = 75
$Reg6.height                  = 30
$Reg6.location                = New-Object System.Drawing.Point(125,120)
$Reg6.Font                    = 'Arial Rounded MT,10'
$Reg6.Enabled                 = $false
$Reg6.BackColor               = "#ff4c4c"
$Reg6.Add_Click($Reg6_Click)

$Reg7                         = New-Object system.Windows.Forms.Button
$Reg7.text                    = "Reg 7"
$Reg7.Name                    = "Reg7"
$Reg7.width                   = 75
$Reg7.height                  = 30
$Reg7.location                = New-Object System.Drawing.Point(225,120)
$Reg7.Font                    = 'Arial Rounded MT,10'
$Reg7.Enabled                 = $false
$Reg7.BackColor               = "#ff4c4c"
$Reg7.Add_Click($Reg7_Click)

$Reg8                         = New-Object system.Windows.Forms.Button
$Reg8.text                    = "Reg 8"
$Reg8.Name                    = "Reg8"
$Reg8.width                   = 75
$Reg8.height                  = 30
$Reg8.location                = New-Object System.Drawing.Point(325,120)
$Reg8.Font                   = 'Arial Rounded MT,10'
$Reg8.Enabled                = $false
$Reg8.BackColor              = "#ff4c4c"
$Reg8.Add_Click($Reg8_Click)

$Reg9                         = New-Object system.Windows.Forms.Button
$Reg9.text                    = "Reg 9"
$Reg9.Name                    = "Reg9"
$Reg9.width                   = 75
$Reg9.height                  = 30
$Reg9.location                = New-Object System.Drawing.Point(25,180)
$Reg9.Font                   = 'Arial Rounded MT,10'
$Reg9.Enabled                = $false
$Reg9.BackColor              = "#ff4c4c"
$Reg9.Add_Click($Reg9_Click)

$Reg10                        = New-Object system.Windows.Forms.Button
$Reg10.text                   = "Reg 10"
$Reg10.Name                   = "Reg10"
$Reg10.width                  = 75
$Reg10.height                 = 30
$Reg10.location               = New-Object System.Drawing.Point(126,180)
$Reg10.Font                   = 'Arial Rounded MT,10'
$Reg10.Enabled                = $false
$Reg10.BackColor              = "#ff4c4c"
$Reg10.Add_Click($Reg10_Click)

$Reg11                        = New-Object system.Windows.Forms.Button
$Reg11.text                   = "Reg 11"
$Reg11.Name                   = "Reg11"
$Reg11.width                  = 75
$Reg11.height                 = 30
$Reg11.location               = New-Object System.Drawing.Point(225,180)
$Reg11.Font                   = 'Arial Rounded MT,10'
$Reg11.Enabled                = $false
$Reg11.BackColor              = "#ff4c4c"
$Reg11.Add_Click($Reg11_Click)

$Reg12                        = New-Object system.Windows.Forms.Button
$Reg12.text                   = "Reg 12"
$Reg12.Name                   = "Reg12"
$Reg12.width                  = 75
$Reg12.height                 = 30
$Reg12.location               = New-Object System.Drawing.Point(325,180)
$Reg12.Font                   = 'Arial Rounded MT,10'
$Reg12.Enabled                = $false
$Reg12.BackColor              = "#ff4c4c"
$Reg12.Add_Click($Reg12_Click)

$Reg25                        = New-Object system.Windows.Forms.Button
$Reg25.text                   = "Reg 25"
$Reg25.Name                   = "Reg25"
$Reg25.width                  = 75
$Reg25.height                 = 30
$Reg25.location               = New-Object System.Drawing.Point(25,240)
$Reg25.Font                   = 'Arial Rounded MT,10'
$Reg25.Enabled                = $false
$Reg25.BackColor              = "#ff4c4c"
$Reg25.Add_Click($Reg25_Click)

$Reg26                        = New-Object system.Windows.Forms.Button
$Reg26.text                   = "Reg 26"
$Reg26.Name                   = "Reg26"
$Reg26.width                  = 75
$Reg26.height                 = 30
$Reg26.location               = New-Object System.Drawing.Point(125,240)
$Reg26.Font                   = 'Arial Rounded MT,10'
$Reg26.Enabled                = $false
$Reg26.BackColor              = "#ff4c4c"
$Reg26.Add_Click($Reg26_Click)

$Reg50                        = New-Object system.Windows.Forms.Button
$Reg50.text                   = "Reg 50"
$Reg50.Name                   = "Reg50"
$Reg50.width                  = 75
$Reg50.height                 = 30
$Reg50.location               = New-Object System.Drawing.Point(225,240)
$Reg50.Font                    = 'Arial Rounded MT,10'
$Reg50.Enabled                = $false
$Reg50.BackColor              = "#ff4c4c"
$Reg50.ForeColor              = "#FFFFFF"
$Reg50.Add_Click($Reg50_Click)

$Reg51                        = New-Object system.Windows.Forms.Button
$Reg51.text                   = "Reg 51"
$Reg51.Name                   = "Reg51"
$Reg51.width                  = 75
$Reg51.height                 = 30
$Reg51.location               = New-Object System.Drawing.Point(325,240)
$Reg51.Font                   = 'Arial Rounded MT,10'
$Reg51.Enabled                = $false
$Reg51.BackColor              = "#ff4c4c"
$Reg51.Add_Click($Reg51_Click)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Online"
$Label1.BackColor                = "#70dc81"
$Label1.AutoSize                 = $true
$Label1.width                    = 50
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(90,15)
$Label1.Font                     = 'Arial Rounded MT,10'
$Label1.ForeColor                = "#FFFFFF"

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = " Offline/Does not exist"
$Label2.BackColor                = "#ff4c4c"
$Label2.AutoSize                 = $true
$Label2.width                    = 20
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(240,15)
$Label2.Font                     = 'Arial Rounded MT,10'
$Label2.ForeColor                = "#FFFFFF"

$Form.controls.AddRange(@($Label1,$Label2,$Reg1,$Reg2,$Reg3,$Reg4,$Reg5,$Reg6,$Reg7,$Reg8,$Reg9,$Reg10,$Reg11,$Reg12,$Reg25,$Reg26,$Reg50,$Reg51))
$global:istop = $null
$global:istart = $null
$global:svcstop = $null
$global:svcstart = $null

    $buttonarr = @($Reg1,$Reg2,$Reg3,$Reg4,$Reg5,$Reg6,$Reg7,$Reg8,$Reg9,$Reg10,$Reg11,$Reg12,$Reg25,$Reg26,$Reg50,$Reg51)#0-15
    

        foreach ($IPAddress in $testerd){

            $cropped = ([ipaddress] "$IPAddress").GetAddressBytes()[3]
            $passvar = $buttonarr.name.IndexOf("Reg"+$Cropped)
            $buttonarr[$passvar].Enabled = $true
            $buttonarr[$passvar].Font = 'Arial Rounded MT,10'
            $buttonarr[$passvar].backcolor = "#70dc81"  
            $buttonarr[$passvar].ForeColor = "#FFFFFF"
        

    }
    write-host "Stopping interac....." -ForegroundColor Yellow
    $global:istop = net stop Interac
    write-host "Staring interac....." -ForegroundColor Yellow
    $global:istart = net start Interac
    write-host "Stopping SVC DB" -ForegroundColor yellow
    $global:svcstop = net stop "In-Store SVC Database"
    write-host "Starting SVC DB" -ForegroundColor yellow
    $global:svcstart = net start "In-Store SVC Database"
    
    
$Form.ShowDialog()
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force