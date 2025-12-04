# ============================================
#    CONFIGURATION DU BRIDGE FLUTTER
# ============================================

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   CONFIGURATION DU BRIDGE FLUTTER" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Etape 1: Aller dans le dossier
Write-Host "[1/4] Aller dans le dossier Flutter SDK..." -ForegroundColor Yellow
Set-Location -Path "D:\tesst_AZEOO\flutter_profile_sdk"

# Etape 2: flutter pub get
Write-Host "[2/4] Installation des dependances Flutter..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: flutter pub get a echoue" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour quitter"
    exit 1
}

# Etape 3: build_runner
Write-Host "[3/4] Generation du code Freezed..." -ForegroundColor Yellow
dart run build_runner build --delete-conflicting-outputs
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: build_runner a echoue" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour quitter"
    exit 1
}

# Etape 4: flutter build aar
Write-Host "[4/4] Build du module AAR Flutter..." -ForegroundColor Yellow
flutter build aar --no-debug --no-profile
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: flutter build aar a echoue" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour quitter"
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   BUILD TERMINE AVEC SUCCES !" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Le dossier .android a ete cree." -ForegroundColor Green
Write-Host ""

# Verifier que le dossier existe
if (Test-Path ".android") {
    Write-Host "Contenu du dossier .android:" -ForegroundColor Cyan
    Get-ChildItem ".android"
} else {
    Write-Host "ATTENTION: Le dossier .android n'existe pas!" -ForegroundColor Red
}

Write-Host ""
Read-Host "Appuyez sur Entree pour quitter"

