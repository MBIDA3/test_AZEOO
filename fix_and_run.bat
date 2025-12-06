@echo off
echo ============================================
echo    CORRECTION CACHE GRADLE + LANCEMENT
echo ============================================
echo.

echo [1/4] Nettoyage du cache Gradle...
rd /s /q "C:\Users\chris\.gradle\caches\8.14\transforms" 2>nul
echo    Cache Gradle nettoye.
echo.

echo [2/4] Aller dans le dossier Flutter...
cd /d D:\tesst_AZEOO\flutter_module
echo.

echo [3/4] Nettoyage du projet Flutter...
call flutter clean
call flutter pub get
echo.

echo [4/4] Lancement sur le telephone...
echo.
echo Ton telephone: 22011119UY - Android 13
echo.
call flutter run -d 304423d50607

pause

