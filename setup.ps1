# 環境変数の設定
[System.Environment]::SetEnvironmentVariable('https_proxy', 'http://10.0.1.5:8080', [System.EnvironmentVariableTarget]::Machine)

# Google Chromeのインストール
Invoke-WebRequest -Uri 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B806F36C0-CB54-4A84-A3F3-0CF8A86575E0%7D%26lang%3Dja%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe' -OutFile 'C:\\Windows\\Temp\\ChromeSetup.exe'
Start-Process -FilePath 'C:\\Windows\\Temp\\ChromeSetup.exe' -ArgumentList '/silent /install /desktopshortcut' -Wait
Remove-Item 'C:\\Windows\\Temp\\ChromeSetup.exe'

# 日本語入力の有効化
$languageList = Get-WinUserLanguageList
$languageList.Add('ja-JP')
Set-WinUserLanguageList $languageList -Force

# UIの言語を日本語に設定
Set-WinUILanguageOverride -Language ja-JP

# Microsoft IMEのインストール
Invoke-WebRequest -Uri 'https://aka.ms/win10jpime' -OutFile 'C:\\Windows\\Temp\\MicrosoftIME.exe'
Start-Process -FilePath 'C:\\Windows\\Temp\\MicrosoftIME.exe' -ArgumentList '/S' -Wait
Remove-Item 'C:\\Windows\\Temp\\MicrosoftIME.exe'

# Wiresharkのインストール
Invoke-WebRequest -Uri 'https://2.na.dl.wireshark.org/win64/Wireshark-win64-latest.exe' -OutFile 'C:\\Windows\\Temp\\Wireshark-Installer.exe'
Start-Process -FilePath 'C:\\Windows\\Temp\\Wireshark-Installer.exe' -ArgumentList '/S /quicklaunch=yes /desktopicon=yes' -Wait
Remove-Item 'C:\\Windows\\Temp\\Wireshark-Installer.exe'

# 日本時間の設定
Set-TimeZone -Id 'Tokyo Standard Time'

# プロキシ設定
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyServer /t REG_SZ /d 'http://10.0.1.5:8080' /f

