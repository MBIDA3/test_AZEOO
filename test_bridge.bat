@echo off
echo ============================================
echo    TEST DU BRIDGE FLUTTER
echo ============================================
echo.

echo [1/3] Verification du module Flutter...
if exist "D:\tesst_AZEOO\flutter_module\.android\Flutter" (
    echo    OK - Le module Flutter existe
) else (
    echo    ERREUR - Le module Flutter n'existe pas
    pause
    exit /b 1
)

echo.
echo [2/3] Verification de include_flutter.groovy...
if exist "D:\tesst_AZEOO\flutter_module\.android\include_flutter.groovy" (
    echo    OK - include_flutter.groovy existe
) else (
    echo    ERREUR - include_flutter.groovy n'existe pas
    pause
    exit /b 1
)

echo.
echo [3/3] Test de la configuration Gradle...
cd /d D:\tesst_AZEOO\AzeooApp\android
call gradlew projects --quiet

echo.
echo ============================================
echo    RESULTAT DU TEST
echo ============================================
if errorlevel 1 (
    echo    ERREUR - Le bridge ne fonctionne pas
) else (
    echo    SUCCES - Le bridge est configure !
)
echo.
pause



