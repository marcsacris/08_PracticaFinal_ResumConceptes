# deploy.ps1 - Pujar 08_PracticaFinal_ResumConceptes a GitHub Pages
$projectPath = "C:\Users\Marc\Documents\IVAN\08_PracticaFinal_ResumConceptes"
$repoUrl     = "https://github.com/marcsacris/08_PracticaFinal_ResumConceptes.git"
$baseHref    = "/08_PracticaFinal_ResumConceptes/"

Write-Host "--- Entrant a la carpeta del projecte ---" -ForegroundColor Cyan
Set-Location $projectPath

Write-Host "--- Build Angular (producció, mode CSR) ---" -ForegroundColor Cyan
ng build --base-href $baseHref

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: ng build ha fallat." -ForegroundColor Red
    exit 1
}

Write-Host "--- Commit del codi font a main ---" -ForegroundColor Cyan
git add .
git commit -m "feat: deploy EcoTrack resumen conceptes"
git branch -M main
git push origin main --force

Write-Host "--- Deploy gh-pages ---" -ForegroundColor Cyan
npx angular-cli-ghpages --dir=dist/browser

Write-Host ""
Write-Host "✅ Fet! App disponible a:" -ForegroundColor Green
Write-Host "   https://marcsacris.github.io/08_PracticaFinal_ResumConceptes/" -ForegroundColor Yellow
