<# 
    
    Navigate to C:\windows\logs\CBS 
    Delete files greater than 1Kb

    Test-path for folders older than 90 days
    Delete folders older than 90 days

    For folders that are less than 90 days:
    Test-path for mp4 files existing in videos desktop documents and pictures
    If files exist, create User folder in W drive and move those files to the new folder
    Delete the files from c drive

    Go through each user and delete the genetec video cache
    •C:\Users\[Username]\AppData\Local\Microsoft\Windows\Burn\Temporary Burn Folder\*.* 
    •C:\Users\[Username]\AppData\Local\Genetec Inc\Security Desk\5.2.0.0\VideoCache\*.*
    •Navigate to C:\ProgramData\Genetec PlanManager\Server\Log 
        Delete large sized log files if there are any. 
     •If issue persists, navigate to C:\Program files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\Log 
        Delete any logs older then 2 days

#>


$NewerDays = Get-ChildItem c:\Users | Where{($_.LastWriteTime -gt (Get-Date).AddDays(-90)) -and $_.Name -ne "cooper14" -and $_.Name -ne "snowbird" -and $_.Name -ne "cambridge" -and $_.Name -ne "public"}
$OlderDays = Get-ChildItem c:\Users | Where{$_.LastWriteTime -lt (Get-Date).AddDays(-90) -and $_.Name -ne "cooper14" -and $_.Name -ne "snowbird" -and $_.Name -ne "cambridge" -and $_.Name -ne "public"}
cd "C:\Windows\logs\CBS"

$CBSlogs = Get-ChildItem | where-object{$_.Length -gt 1kb}
    foreach($logs in $CBSlogs){
    Remove-Item $logs
    }


cd "C:\Program files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\Log\"

$SQLlogs = Get-ChildItem | where-object{$_.Length -gt 1kb}
    foreach($logs in $SQLlogs){
    Remove-Item $logs
    }


Remove-Item -Force -Path "C:\ProgramData\Genetec PlanManager\Server\Log\*.*"

cd C:\Users


    #Delete user folders older than 90 days
   foreach($dir in $OlderDays){

   
        Get-CimInstance -ComputerName $ComputerName -Class Win32_UserProfile -ErrorAction Stop | Where-Object {$_.Special -eq $false}    
        Get-CimInstance -ComputerName $profile.ComputerName -ClassName Win32_UserProfile -ErrorAction Stop | Where-Object {$_.SID -eq $profile.RegKey.SID -and $_.LocalPath -eq $profile.RegKey.LocalPath} | Remove-CimInstance -ErrorAction Stop 

        $Group = New-Object System.Security.Principal.NTAccount("Builtin", "Administrators")
        $ACL = Get-ACL $dir
        $ACL.SetOwner($Group)

        Get-ChildItem $dir -Recurse -Force | % {
        Set-ACL -AclObject $ACL -Path $_.fullname
        }    

    remove-item -force -Path $dir -recurse
}

Get-ChildItem ’HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList’ |
    ForEach-Object{
        $profilepath=$_.GetValue('ProfileImagePath')    
        if($profilepath -notmatch 'administrator|[redacted]|[redacted]|Public|Localservice|systemprofile|[redacted]|NetworkService'){
            Write-Host "Removing item: $profilepath" -ForegroundColor green
            Remove-Item $_.PSPath
        }else{
            Write-Host "Skipping item:$profilepath" -Fore blue -Back white
	    }
    }

    #Delete appdata for each user less than 90 days old
   foreach($dir in $Newerdays){

    Remove-Item "C:\Users\$dir\AppData\Local\Microsoft\Windows\Burn\Temporary Burn Folder\*.*" -Recurse -Force -ErrorAction silentlycontinue
    Remove-Item "C:\Users\$dir\AppData\Local\Genetec Inc\Security Desk\5.2.0.0\VideoCache\*.*" -Recurse -Force -ErrorAction silentlycontinue
    Remove-Item "C:\Users\$dir\AppData\Local\Genetec Inc\Security Desk\5.5.0.0\VideoCache\*.*" -Recurse -Force -ErrorAction silentlycontinue
    Remove-Item "C:\Users\$dir\AppData\Local\Genetec Inc\Security Desk\5.7.0.0\VideoCache\*.*" -Recurse -Force -ErrorAction silentlycontinue
}


    #check for video files(.G64) 
    #If video files exist, get $dir name and mkdir "$dir" in W:\
    foreach($dir in $NewerDays){    

            $DesktopVID = get-childitem C:\Users\$dir\Desktop\*.* -recurse | where {$_.extension -eq ".G64"}

            $DocumentsVID = get-childitem C:\Users\$dir\Documents\*.* -recurse | where {$_.extension -eq ".G64"} 

            $VideoVID = get-childitem C:\Users\$dir\Videos\*.* -recurse | where {$_.extension -eq ".G64"}

                if($DesktopVID.Length -ne 0 -or $DocumentsVID.Length -ne 0 -or $VideoVID.Length -ne 0){
                    W:
                    mkdir $dir
                }

                if($DesktopVID.Length -ne 0){
                    W:
                    move-item -path $DesktopVID.PSPath -Destination W:\$dir
                }

                if($DocumentsVID.Length -eq 0){
                    W:
                    move-item -path $DocumentsVID.PSPath -Destination W:\$dir
                }

                if($VideoVID.Length -eq 0){
                    W:
                    move-item -path $VideoVID.PSPath -Destination W:\$dir
                }
            

}
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force