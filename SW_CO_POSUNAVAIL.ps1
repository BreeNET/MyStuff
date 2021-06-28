$keepDIR = Read-Host 'How many days ago are being processed? 1-10'
$pathName = "D:\XPS\Upload\Keep" + $keepDIR
$utils = "D:\Program Files\Utils\storeweb\"
$Desktop = "C:\Users\[redacted]\Desktop"
$keepOne = "D:\XPS\Upload\Keep1"
$coGen = "D:\Program Files\utils\cashoffice"



#Function that shows a countdown in the console until parse complete

function Countdown {
    param(
        [int]$Hours,
        [int]$Minutes,
        [int]$Seconds
    )

    $timer = New-Timespan -Hours $Hours -Minutes $Minutes -Seconds $Seconds
     
    $timer.TotalSeconds..0 | ForEach-Object {
        $now = New-Timespan -Seconds $_
        $counter = "{0}:{1}:{2}" -f $now.Hours.ToString().PadLeft(2, '0'), $now.Minutes.ToString().PadLeft(2, 
'0'), $now.Seconds.ToString().PadLeft(2, '0')        
        write-output $counter
        sleep 1
        
        
    }
}


#Stop storeweb

sshg3 [redacted]@webpc d:\scripts\sw_stop.bat
sleep 6



#delete .flg & .xml & .t files from keep1 to clean up folder and allow ULSWXMLSFTP.bat to run

cd $keepOne
remove-item -path .\*.flg
remove-item -path .\*.xml
remove-item -path .\*.t

#Re-generate yesterdays .xml and .t files to keep1

cd $coGen
.\ULSWCOEINFOXML.BAT
sleep 2
.\ULSWCOEXML.BAT
sleep 2
.\ULSWCOEXMLCOMMON.BAT
sleep 2


#Copy .xml & .T file from the needed keep folder to keep1. Ignore if processing yesterdays cash office
if($keepDIR -ne "1"){
cd  $pathName
copy-item -path .\*.xml -destination $keepOne
copy-item -path .\*.t -destination $keepOne
}


#run [redacted] batch script that uploads .xml & .t files from keep1 to D:\posshare on the webPC
#sshg3 into web pc and execute parseposco.cmd to parse the xml and t files. 

cd $utils
.\ulswxmlsftp.bat
sleep 10
cd $Desktop
#Delete and old .xml or .t files sitting in D:\posshare\
sshg3 [redacted]@webpc -B "del D:\posshare\*.xml"
sshg3 [redacted]@webpc -B "del D:\posshare\*.t"
sshg3 [redacted]@webpc "D:\CashOffice\Scripts\Parseposco.cmd"


#Cleanup keep1 folder to remove the files we copied from $pathName, 
#Also re-generate the xml files for keep1 to restore the folder to its original state

cd $keepOne
remove-item -path .\*.flg
remove-item -path .\*.xml
remove-item -path .\*.t

cd $coGen
.\ULSWCOEINFOXML.BAT
.\ULSWCOEXML.BAT
cmd.exe /c "ULSWCOEXMLCOMMON.BAT"

#start storeweb

sshg3 [redacted]@webpc d:\scripts\sw_start.bat

#Waits for a brief period of time while the xml files parse
#Also tells the user when to proceed with call. 
Countdown -Hours 0 -Minutes 0 -Seconds 55



#Self delete .ps1 script
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
logoff