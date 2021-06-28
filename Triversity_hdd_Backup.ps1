$hostname = hostname #MAR012300
$pathname = $hostname -replace ".{2}$" #Trims "00"
$HostTrimFront = $pathname.Trim("T","J","M","A","R","t","j","m","a","r")#Trim front of hostname

$storeNum = $HostTrimFront #Var used for naming files

$regNum = Read-Host '2 digit reg number? ' #Ask which register is being backed up

$regNumTest = Read-Host 'Is register' , $regNum , 'correct? y/n' #Confirmation of register

$sdataJRN= $storeNum + $regNum + "00" + ".jrn" #D:\XPS\Sdata .jrn file

$sdataJNM = $storeNum + $regNum + "00" + ".jnm" #D:\XPS\Sdata .jnm file

$sdataTXN = $storeNum + $regNum + "00" + ".txn" #D:\XPS\Sdata .txn file

$LDJRN = "ld.jrn" #register .jrn file

$LDJNM = "ld.jnm" #register .jnm file

$LDTXN = "ld.txn" #register .txn file

#Safety test. If typo was made exit script before executing anything else
if($regNumTest -ne "y" -or $regNumTest -ne "Y"){
    exit
}

#Backup folder on desktop
$BackupFolder = New-Item -ItemType Directory -Path $( -join("C:\Users\[redacted]\Desktop\", ((Get-Date).ToString('yyyy-MM-dd')), "_REG_",  $regNum_, "_Backup"))

#Register paths for each sales file
$poswinA = $("\\"+$pathname+$regNum+"\d\Program Files\POSWIN\rdata\ld.jrn")
$poswinB = $("\\"+$pathname+$regNum+"\d\Program Files\POSWIN\rdata\ld.jnm")
$poswinC = $("\\"+$pathname+$regNum+"\d\Program Files\POSWIN\rdata\ld.txn")

D:

cd xps\sdata

 
#Move sales files from sdata to keep0
Move-Item $sdataJRN -Destination D:\xps\upload\keep0
Move-Item $sdataJNM -Destination D:\xps\upload\keep0
Move-Item $sdataTXN -Destination D:\xps\upload\keep0

cd D:\xps\upload\keep0

#Rename items from SSSSRR00 to SSSSRR99
Rename-Item $sdataJRN -NewName $($storeNum + $regNum + "99" + ".jrn")
Rename-Item $sdataJNM -NewName $($storeNum + $regNum + "99" + ".jnm")
Rename-Item $sdataTXN -NewName $($storeNum + $regNum + "99" + ".txn")

cd D:\

#Backup files directly to timestamp folder from register##\d\program files\poswin\rdata
copy-item $poswinA -destination $BackupFolder
copy-item $poswinB -destination $BackupFolder
copy-item $poswinC -destination $BackupFolder

cd $BackupFolder

#Rename backed up items to xxxx00 name scheme
Rename-Item $LDJRN -NewName $($storeNum + $regNum + "00" + ".jrn")
Rename-Item $LDJNM -NewName $($storeNum + $regNum + "00" + ".jnm")
Rename-Item $LDTXN -NewName $($storeNum + $regNum + "00" + ".txn")

#text file generated stating the files in the back up folder will be deleted after 30 days
New-Item -Path .\ -Name "ReadMe.txt" -ItemType "file" -Value $("This folder was generated because a technician called in to replace a hard drive.
In case of any back up failures, these ld.jrn jnm and txn files have also been copied and renamed from `r`nREG$regNum\D:\poswin\rdata. This folder will be deleted in 30 days.")

#script self delete
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force




<#
$taskName = "Register " + $regNum +" backup delete" #Scheduled task name located in root of Task Scheduler library
$STdate = ((Get-Date).AddMonths(1)).ToString('MM-dd-yyyy') #Task execution date 30 days from when script was ran
$delScript = "$BackupFolder\reg_del.ps1" #Script location + name
$schedTaskName = "$BackupFolder`\reg_del.ps1" #Executes script to remove files

#Create script on desktop to delete all contents of backup folder as well as scheduled task
$reg_del = " new-item -path `"C:\Users\[redacted]\Desktop`" -Name `"fullDel.ps1`" -itemtype `"file`" -value `$(`"
    ```$taskName = `'Register $regNum backup delete`'
    Remove-Item -Recurse -Force `'$BackupFolder`'
    schtasks /delete /tn `'$taskName`' /f
    Remove-Item -LiteralPath ```$MyInvocation.MyCommand.Path -Force`")
    sleep 2
    cd C:\Users\[redacted]\Desktop
    .\fullDel.ps1
    "


New-Item -Path $BackupFolder -Name "reg_del.ps1" -ItemType "file" -Value $("$reg_del") #Create 1st script that holds content of 2nd script

schtasks.exe /create /TN $taskName /ST 03:00 /SC ONCE /SD $STdate /RU "SYSTEM" /IT /TR "powershell.exe -file $schedTaskName" #Task creation
#>