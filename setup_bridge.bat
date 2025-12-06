@echo off
echo ============================================
echo    CONFIGURATION DU BRIDGE FLUTTER
echo ============================================
echo.

echo [1/4] Aller dans le dossier Flutter SDK...
cd /d D:\tesst_AZEOO\flutter_profile_sdk
if errorlevel 1 (
    echo ERREUR: Impossible d'acceder au dossier
    pause
    exit /b 1
)

echo [2/4] Installation des dependances Flutter...
call flutter pub get
if errorlevel 1 (
    echo ERREUR: flutter pub get a echoue
    pause
    exit /b 1
)

echo [3/4] Generation du code Freezed...
call dart run build_runner build --delete-conflicting-outputs
if errorlevel 1 (
    echo ERREUR: build_runner a echoue
    pause
    exit /b 1
)

echo [4/4] Build du module AAR Flutter...
call flutter build aar --no-debug --no-profile
if errorlevel 1 (
    echo ERREUR: flutter build aar a echoue
    pause
    exit /b 1
)

echo.
echo ============================================
echo    BUILD TERMINE AVEC SUCCES !
echo ============================================
echo.
echo Le dossier .android a ete cree.
echo Tu peux maintenant lancer React Native.
echo.

dir .android

pause



