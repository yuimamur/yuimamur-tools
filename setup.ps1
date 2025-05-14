# 環境変数の設定（マシン全体）
[System.Environment]::SetEnvironmentVariable('https_proxy', 'http://10.0.1.5:8080', [System.EnvironmentVariableTarget]::Machine)

# Google Chromeのインストール
Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile 'C:\\Windows\\Temp\\ChromeSetup.exe'
Start-Process -FilePath 'C:\\Windows\\Temp\\ChromeSetup.exe' -ArgumentList '/silent /install' -Wait
Remove-Item 'C:\\Windows\\Temp\\ChromeSetup.exe'

# 日本語言語パックとIMEのインストール
Add-WindowsCapability -Online -Name "Language.Basic~~~ja-JP~0.0.1.0"
Add-WindowsCapability -Online -Name "InputMethod.Editor.Japanese~~~ja-JP~0.0.1.0"
# 日本語の言語パックとIMEをインストール
Add-WindowsCapability -Online -Name "Language.Basic~~~ja-JP~0.0.1.0"
Add-WindowsCapability -Online -Name "Language.Handwriting~~~ja-JP~0.0.1.0"
Add-WindowsCapability -Online -Name "Language.Speech~~~ja-JP~0.0.1.0"
Add-WindowsCapability -Online -Name "Language.TextToSpeech~~~ja-JP~0.0.1.0"
Add-WindowsCapability -Online -Name "InputMethod.Editor.Japanese~~~ja-JP~0.0.1.0"



# UIの言語を日本語に設定
$languageList = Get-WinUserLanguageList
$languageList.Add('ja-JP')
Set-WinUserLanguageList $languageList -Force
Set-WinUILanguageOverride -Language ja-JP

# Wiresharkのインストール
Invoke-WebRequest -Uri 'https://2.na.dl.wireshark.org/win64/Wireshark-win64-latest.exe' -OutFile 'C:\\Windows\\Temp\\Wireshark-Installer.exe'
Start-Process -FilePath 'C:\\Windows\\Temp\\Wireshark-Installer.exe' -ArgumentList '/S /quicklaunch=yes /desktopicon=yes' -Wait
Remove-Item 'C:\\Windows\\Temp\\Wireshark-Installer.exe'

# 日本時間の設定
Set-TimeZone -Id 'Tokyo Standard Time'

# プロキシ設定（ユーザーレベル）
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyServer /t REG_SZ /d 'http://10.0.1.5:8080' /f

