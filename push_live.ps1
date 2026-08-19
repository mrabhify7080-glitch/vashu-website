param (
    [string]$message = "Update multi-page website"
)

$gh = "C:\Users\ASUS\AppData\Local\Microsoft\WinGet\Packages\GitHub.cli_Microsoft.WinGet.Source_8wekyb3d8bbwe\bin\gh.exe"
$repo = "mrabhify7080-glitch/vashu-website"
$files = @("CNAME", "vashu-profile.jpg", "themelofy-logo-transparent.png", "style.css", "index.html", "about.html", "music.html", "services.html", "portfolio.html", "gallery.html", "blog.html", "testimonials.html", "presskit.html", "contact.html")

Write-Host "Syncing and Pushing all multi-page files to GitHub..." -ForegroundColor Cyan

foreach ($file in $files) {
    $filePath = "d:\vashu website\$file"
    if (Test-Path $filePath) {
        try {
            Write-Host "Pushing $file..." -ForegroundColor Yellow
            $shaRaw = (& $gh api "/repos/$repo/contents/$file" --jq '.sha' 2>$null)
            $sha = ""
            if ($shaRaw) {
                $sha = ($shaRaw | Out-String).Trim()
            }
            
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $base64Content = [Convert]::ToBase64String($bytes)
            
            if ($sha -and $sha.Length -gt 5) {
                $body = @{ message = "$message - $file"; content = $base64Content; sha = $sha } | ConvertTo-Json -Depth 5
            } else {
                $body = @{ message = "$message - $file"; content = $base64Content } | ConvertTo-Json -Depth 5
            }
            
            $result = $body | & $gh api "/repos/$repo/contents/$file" -X PUT --input - --jq '.content.html_url'
            Write-Host "Pushed $file successfully" -ForegroundColor Green
        } catch {
            Write-Host "Error pushing $file" -ForegroundColor Red
        }
    }
}

Write-Host "SUCCESS! All pages live!" -ForegroundColor Green
Write-Host "Live URL: https://mrabhify7080-glitch.github.io/vashu-website/" -ForegroundColor Yellow
