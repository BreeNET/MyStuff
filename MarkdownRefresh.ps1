#stop service
cmd.exe /c "D:\scripts\sw_stop.bat"
sleep 5

#Navigate to ser files
D:
cd "Digihost\digi"

#Delete all ser files
remove-item -path .\*.ser

#Reboot web pc
shutdown /r /f -t 0

#Script self delete
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force