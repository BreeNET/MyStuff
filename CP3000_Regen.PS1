D:
cd "D:\Program Files\[redacted]\accounting\"
#first run for .tot file
.\Run_CashOffice.ps1

#2nd run for .pet file
.\Run_CashOffice.ps1

cd "D:\Program Files\utils\[redacted]"
.\ULSWCOSFTP.BAT

C:
cd "C:\Users\[redacted]\Desktop\"

Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force