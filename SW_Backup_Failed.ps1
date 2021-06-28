sshg3 cambridge@webpc d:\scripts\swbackup.cmd 

start-process "d:\program files\utils\storeweb\dlswdb.bat"


sshg3 cambridge@webpc d:\scripts\sw_stop.bat

sleep 20

sshg3 cambridge@webpc d:\scripts\sw_start.bat

sleep 15


#Delete script from controller
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force