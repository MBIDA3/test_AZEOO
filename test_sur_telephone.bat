@echo off
echo ============================================
echo    LANCEMENT SUR TELEPHONE ANDROID
echo ============================================
echo.

cd /d D:\tesst_AZEOO\flutter_profile_sdk

echo [1/2] Verification des appareils connectes...
flutter devices
echo.

echo [2/2] Lancement sur le telephone...
flutter run -d 304423d50607

pause

