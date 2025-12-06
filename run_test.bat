@echo off
echo ============================================
echo    TEST SDK FLUTTER SUR TELEPHONE
echo ============================================
echo.

echo [1/3] Aller dans le dossier Flutter Module...
cd /d D:\tesst_AZEOO\flutter_module

echo.
echo [2/3] Verification des appareils connectes...
call flutter devices
echo.

echo [3/3] Lancement de l'application...
echo.
echo L'application va se lancer sur votre telephone.
echo Appuyez sur 'q' dans le terminal pour quitter.
echo.
call flutter run

pause



