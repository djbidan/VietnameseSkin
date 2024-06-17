oh-my-posh init pwsh --config 'C:\Users\Windows\scoop\apps\oh-my-posh\current\themes\M365Princess.omp.json' | Invoke-Expression

Import-Module Terminal-Icons

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView


Invoke-Expression (& { (zoxide init powershell | Out-String) })


# Enhanced PowerShell Experience
Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
}

function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Clipboard Utilities
function cpy { Set-Clipboard $args[0] }

# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# Notepad++
Set-Alias -name 'npp' -value 'C:\Program Files\Notepad++\notepad++.exe'

# Edit profile
function editprofile { start notepad++ $env:USERPROFILE\.config\powershell\user_profile.ps1 }

# Toi Uu PC christitus
function Chris { irm christitus.com/win | iex }
# yt-dlp
function yt {
    param(
        [string]$URL,
        [string]$Destination = "D:\downloads"  # Thư mục mặc định là D:\download
    )

    # Kiểm tra xem yt-dlp.exe có tồn tại không
    if (-not (Test-Path "D:\yt-dlp\yt-dlp.exe")) {
        Write-Host "Lỗi: Không tìm thấy yt-dlp.exe trong thư mục hiện tại." -ForegroundColor Red
        return
    }

    # Thực hiện tải video từ YouTube và lưu vào thư mục được chỉ định
    & "yt-dlp.exe" $URL -o "$Destination\%(title)s.%(ext)s" -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best
}


