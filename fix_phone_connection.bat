@echo off
echo ============================================
echo    RECONNEXION DU TELEPHONE ANDROID
echo ============================================
echo.

echo [1/3] Redemarrage du serveur ADB...
adb kill-server
timeout /t 2 /nobreak >nul
adb start-server
echo.

echo [2/3] Liste des appareils connectes...
adb devices -l
echo.

echo [3/3] Verification avec Flutter...
flutter devices
echo.

echo ============================================
echo RESULTAT
echo ============================================
echo.
echo Si tu vois ton telephone dans la liste, tu peux lancer:
echo   cd D:\tesst_AZEOO\flutter_profile_sdk
echo   flutter run
echo.
echo Si le telephone n'apparait PAS:
echo   1. Debranche le cable USB
echo   2. Sur le telephone: Desactive puis reactive le "Debogage USB"
echo   3. Rebranche le cable
echo   4. Accepte l'autorisation sur le telephone
echo   5. Relance ce script
echo.
pause


