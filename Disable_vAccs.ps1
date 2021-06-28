

#Creates .SQL file with content inside
$sqlDisable = "SET QUOTED_IDENTIFIER ON;
`r`nGO `r`nUPDATE [User]`r`nSET Info.modify('replace value of (User/UserStatus/text())[1] with `"Deactivated`"') `r`nWHERE Name ='[redacted]';`r`nGO" 
$Desktop = "C:\Users\[redacted]\Desktop\" #Working directory
$hostname = hostname #'MAR0123LPCC'
$PCTest = $hostname.subString(7,4)#Tests for LPCS or LPCC
$hostTrim = $hostname -replace ".{4}$" #Removes "LPCS" from hostname
$lpcc = $hostTrim + "lpcc" #Used to disable [redacted] remotely
$sqlName = (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances #Gets SQL instance name

#Message box
Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::OK
$MessageboxTitle = "License check failed"
$Messageboxbody = "$hostname is not licensed for use. Run script on other machine"
$MessageIcon = [System.Windows.MessageBoxImage]::ERROR

#Sets license directory location
if ($PCTest -eq "LPCS"){
    $licenseDIR = "E:\Program Files\Genetec Security Center\ConfigurationFiles\license.gconfig" #LPCS
}else{
    $licenseDIR = "E:\Program Files (x86)\Genetec Security Center 5.2\ConfigurationFiles\license.gconfig" #LPCC
}

#Loads license.config and sets node to check
[xml]$XmlDocument = Get-Content -Path $licenseDIR
$TestedLicense = $XmlDocument.configuration.Licensing.License

#If license is null, alert to go to other hostname
#Prevents users from deactivating tycoadmin on a non licensed system
if ($TestedLicense -eq $null){
[System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
exit
}
#Test for LPCC vs LPCS for [redacted] disable
if ($PCTest -eq "LPCC"){
    net user [redacted] /active:no #Disable [redacted] locally on LPCC
}else{
    net user [redacted] /active:no
    WMIC /node:$lpcc process call create “cmd.exe /c net user [redacted] /active:no” #remotely disable [redacted] from LPCS
}


#Creates .SQL file
New-Item -Path $Desktop -Name "Disable_[redacted].sql" -ItemType "file" -Value $($sqlDisable) 

#Test SQL Instance name
#When Instance name is SQLEXPRESS, have to use .\SQLEXPRESS
#When Instance name is MSSQLSERVER, have to use .\
#Loads SQL server instance and runs $sqlenable content

if($sqlName -eq "MSSQLSERVER"){
        SQLCMD -S .\ -d Directory -i C:\Users\[redacted]\Desktop\Disable_[redacted].sql
}else{
        SQLCMD -S .\$sqlName -d Directory -i C:\Users\[redacted]\Desktop\Disable_[redacted].sql
}

#Changes to working directory
cd $Desktop 

#Cleanup files
Remove-Item .\Disable_[redacted].sql
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
logoff