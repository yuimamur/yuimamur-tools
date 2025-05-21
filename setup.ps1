# ========== Install Google Chrome ==========
Write-Host "Installing Google Chrome..."
try {
    Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile 'C:\Windows\Temp\ChromeSetup.exe'
    Start-Process -FilePath 'C:\Windows\Temp\ChromeSetup.exe' -ArgumentList '/silent /install' -Wait
    Remove-Item 'C:\Windows\Temp\ChromeSetup.exe'
    Write-Host "Google Chrome installation completed"
} catch {
    Write-Warning "Failed to install Google Chrome: $_"
}

# ========== Install Japanese Language Pack ==========
Write-Host "Installing Japanese language pack..."
try {
    Add-WindowsCapability -Online -Name "Language.Basic~~~ja-JP~0.0.1.0"
    Add-WindowsCapability -Online -Name "Language.Handwriting~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "Language.Speech~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "Language.TextToSpeech~~~ja-JP~0.0.1.0" -ErrorAction SilentlyContinue
    Add-WindowsCapability -Online -Name "InputMethod.Editor.Japanese~~~ja-JP~0.0.1.0"
    Write-Host "Japanese language pack installation completed"
} catch {
    Write-Warning "Failed to install Japanese language pack: $_"
}

# ========== Set System Locale to Japanese ==========
Write-Host "Configuring system locale to Japanese..."
try {
    Set-WinUILanguageOverride -Language ja-JP
    Set-WinUserLanguageList ja-JP -Force
    Set-WinSystemLocale ja-JP
    Set-Culture ja-JP
    Set-WinHomeLocation -GeoId 122
    Write-Host "System locale configuration completed"
} catch {
    Write-Warning "Failed to configure system locale: $_"
}

# ========== Install Wireshark ==========
Write-Host "Installing Wireshark..."
try {
    Invoke-WebRequest -Uri 'https://2.na.dl.wireshark.org/win64/Wireshark-win64-latest.exe' -OutFile 'C:\Windows\Temp\Wireshark-Installer.exe'
    Start-Process -FilePath 'C:\Windows\Temp\Wireshark-Installer.exe' -ArgumentList '/S /quicklaunch=yes /desktopicon=yes' -Wait
    Remove-Item 'C:\Windows\Temp\Wireshark-Installer.exe'
    Write-Host "Wireshark installation completed"
} catch {
    Write-Warning "Failed to install Wireshark: $_"
}

# ========== Set Time Zone ==========
Write-Host "Setting time zone to Tokyo..."
try {
    Set-TimeZone -Id 'Tokyo Standard Time'
    Write-Host "Time zone configuration completed"
} catch {
    Write-Warning "Failed to set time zone: $_"
}

# ========== Configure Proxy ==========
Write-Host "Configuring internet proxy..."
try {
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d 'http://10.0.1.5:8080' /f
    Write-Host "Proxy configuration completed"
} catch {
    Write-Warning "Failed to configure proxy: $_"
}

# ========== Disable DNS-over-HTTPS in Chrome ==========
Write-Host "Disabling DNS-over-HTTPS in Chrome..."
try {
    $regPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }
    New-ItemProperty -Path $regPath -Name "DnsOverHttpsMode" -PropertyType String -Value "off" -Force | Out-Null
    Write-Host "DNS-over-HTTPS has been disabled"
} catch {
    Write-Warning "Failed to disable DNS-over-HTTPS: $_"
}

# ========== Pause Windows Update for 14 days ==========
Write-Host "Pausing Windows Update for 14 days..."
try {
    $pauseDays = 14
    $currentDate = Get-Date
    $pauseUntil = $currentDate.AddDays($pauseDays).ToString("yyyy-MM-dd")

    $regPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }
    Set-ItemProperty -Path $regPath -Name "PauseQualityUpdatesStartTime" -Value $currentDate
    Set-ItemProperty -Path $regPath -Name "PauseQualityUpdatesUntil" -Value $pauseUntil

    Write-Host "Windows Update paused until $pauseUntil"
} catch {
    Write-Warning "Failed to pause Windows Update: $_"
}

# ========== Final Message ==========
Write-Host ""
Write-Host "Setup completed successfully."
Write-Host "Please restart the system to apply the Japanese UI and IME settings."

# Note: No interactive prompts due to non-interactive execution environment
# Restart-Computer -Force  ← Optional: uncomment to force reboot

