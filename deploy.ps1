# deploy.ps1 - Pujar EcoTrack a GitHub Pages
$ecotrackPath = "C:\laragon\www\fp-ginebro\ecotrack"
$repoUrl      = "https://github.com/marcsacris/08_PracticaFinal_ResumConceptes.git"
$baseHref     = "/08_PracticaFinal_ResumConceptes/"

Write-Host "--- Entrant a la carpeta ecotrack ---" -ForegroundColor Cyan
Set-Location $ecotrackPath

Write-Host "--- Build Angular (producció) ---" -ForegroundColor Cyan
ng build --base-href $baseHref

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: ng build ha fallat." -ForegroundColor Red
    exit 1
}

Write-Host "--- Configurant git remote ---" -ForegroundColor Cyan
git init
git remote remove origin 2>$null
git remote add origin $repoUrl

Write-Host "--- Commit del codi font a main ---" -ForegroundColor Cyan
git add .
git commit -m "feat: EcoTrack PWA - Angular + Capacitor"
git branch -M main
git push origin main --force

Write-Host "--- Deploy gh-pages ---" -ForegroundColor Cyan
npx angular-cli-ghpages --dir=dist/ecotrack/browser

Write-Host ""
Write-Host "✅ Fet! App disponible a:" -ForegroundColor Green
Write-Host "   https://marcsacris.github.io/08_PracticaFinal_ResumConceptes/" -ForegroundColor Yellow
