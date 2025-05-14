# ========== プロキシ環境変数の設定 ==========
[System.Environment]::SetEnvironmentVariable('https_proxy', 'http://10.0.1.5:8080', [System.EnvironmentVariableTarget]::Machine)

# ========== Google Chromeのインストール ==========
Write-Host "✅ Google Chrome をインストール中..."
try {
    Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile 'C:\Windows\Temp\ChromeSetup.exe'
    Start-Process -FilePath 'C:\Windows\Temp\ChromeSetup.exe' -ArgumentList '/silent /install' -Wait
    Remove-Item 'C:\Windows\Temp\ChromeSetup.exe'
    Write-Host "✔ Chrome インストール完了"
} catch {
    Write-Warning "❌ Chrome のインストールに失敗しました: $_"
}

# ========== 日本語言語パックのインストール ==========
Write-Host "✅ 日本語言語パックをインストール中..."
try {
    Add-WindowsCapability -Online -Name "Language.Basic~~~ja-JP~0.0.1.0"
    Add-WindowsCapability -Online -Name "Language.Handwriting~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "Language.Speech~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "Language.TextToSpeech~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "InputMethod.Editor.Japanese~~~ja-JP~0.0.1.0"
    Write-Host "✔ 日本語言語パックのインストール完了"
} catch {
    Write-Warning "❌ 日本語言語パックのインストールに失敗しました: $_"
}

# ========== 日本語環境の設定 ==========
Write-Host "✅ システムと言語環境を日本語に設定中..."
try {
    Set-WinUILanguageOverride -Language ja-JP
    Set-WinUserLanguageList ja-JP -Force
    Set-WinSystemLocale ja-JP
    Set-Culture ja-JP
    Set-WinHomeLocation -GeoId 122
    Write-Host "✔ 日本語環境の設定完了"
} catch {
    Write-Warning "❌ 日本語環境の設定に失敗しました: $_"
}

# ========== Wiresharkのインストール ==========
Write-Host "✅ Wireshark をインストール中..."
try {
    Invoke-WebRequest -Uri 'https://2.na.dl.wireshark.org/win64/Wireshark-win64-latest.exe' -OutFile 'C:\Windows\Temp\Wireshark-Installer.exe'
    Start-Process -FilePath 'C:\Windows\Temp\Wireshark-Installer.exe' -ArgumentList '/S /quicklaunch=yes /desktopicon=yes' -Wait
    Remove-Item 'C:\Windows\Temp\Wireshark-Installer.exe'
    Write-Host "✔ Wireshark インストール完了"
} catch {
    Write-Warning "❌ Wireshark のインストールに失敗しました: $_"
}

# ========== タイムゾーンの設定 ==========
Write-Host "✅ タイムゾーンを Tokyo に設定中..."
try {
    Set-TimeZone -Id 'Tokyo Standard Time'
    Write-Host "✔ タイムゾーン設定完了"
} catch {
    Write-Warning "❌ タイムゾーンの設定に失敗しました: $_"
}

# ========== インターネットプロキシの設定 ==========
Write-Host "✅ プロキシ設定中..."
try {
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d 'http://10.0.1.5:8080' /f
    Write-Host "✔ プロキシ設定完了"
} catch {
    Write-Warning "❌ プロキシの設定に失敗しました: $_"
}

# ========== 完了メッセージと再起動オプション ==========
Write-Host "`n✅ セットアップが完了しました。" -ForegroundColor Green
Write-Host "⚠ 日本語UIとIMEを有効にするには再起動が必要です。" -ForegroundColor Yellow
$choice = Read-Host "`n⏳ 今すぐ再起動しますか？ (Y/N)"
if ($choice -match '^[Yy]') {
    Restart-Computer -Force
}

