@echo off
echo ============================================
echo    SUPPRESSION COMPLETE CACHE GRADLE
echo ============================================
echo.

echo ATTENTION: Cela va supprimer TOUT le cache Gradle.
echo.
pause

echo [1/3] Suppression complete du cache Gradle...
rd /s /q "C:\Users\chris\.gradle\caches" 2>nul
echo    Cache supprime.
echo.

echo [2/3] Suppression du daemon Gradle...
rd /s /q "C:\Users\chris\.gradle\daemon" 2>nul
echo    Daemon supprime.
echo.

echo [3/3] Nettoyage du projet Flutter...
cd /d D:\tesst_AZEOO\flutter_profile_sdk
call flutter clean
echo.

echo ============================================
echo    CACHE GRADLE COMPLETEMENT NETTOYE !
echo ============================================
echo.
echo Maintenant tu peux lancer:
echo   cd D:\tesst_AZEOO\flutter_profile_sdk
echo   flutter run -d 304423d50607
echo.
pause


