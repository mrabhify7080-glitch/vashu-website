$env:PATH = "C:\Users\ASUS\git\cmd;C:\Users\ASUS\AppData\Local\Microsoft\WinGet\Packages\GitHub.cli_Microsoft.WinGet.Source_8wekyb3d8bbwe\bin;" + $env:PATH

Write-Host "Configuring Git User..." -ForegroundColor Cyan
git config user.name "mrabhify7080-glitch"
git config user.email "vashuvibes07@gmail.com"

Write-Host "Staging files..." -ForegroundColor Cyan
git add .

Write-Host "Creating initial commit..." -ForegroundColor Cyan
git commit -m "Initial commit - TheMeloFY VASHU multi-page website"

Write-Host "Connecting to remote GitHub repo..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/mrabhify7080-glitch/vashu-website.git

Write-Host "Setting up gh auth..." -ForegroundColor Cyan
gh auth setup-git

Write-Host "Git Status:" -ForegroundColor Yellow
git status
git remote -v
