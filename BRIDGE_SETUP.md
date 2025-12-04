# 🔧 Guide de Configuration du Bridge Flutter ↔ React Native

## ⚠️ État Actuel

Le code du bridge est **complet** mais la configuration finale nécessite quelques étapes manuelles.

### Ce qui est prêt ✅
- Code Kotlin du bridge (4 fichiers)
- MethodChannel côté Flutter
- Composant React Native FlutterProfileView
- Configuration des écrans React Native

### Ce qui manque ❌
- Le Flutter module (`.android/`) n'est pas encore créé
- Les dépendances Flutter ne sont pas encore liées

---

## 📋 Étapes pour Activer le Bridge

### Étape 1 : Builder le Flutter Module en AAR

```bash
# 1. Aller dans le SDK Flutter
cd D:\tesst_AZEOO\flutter_profile_sdk

# 2. S'assurer que les dépendances sont installées
flutter pub get

# 3. Générer le code Freezed
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Builder en AAR (crée le module Android)
flutter build aar --no-debug --no-profile
```

Cette commande va :
- Créer le dossier `.android/`
- Générer `include_flutter.groovy`
- Créer les fichiers AAR dans `build/host/outputs/repo/`

### Étape 2 : Configurer React Native

#### A. Modifier `settings.gradle`

Ouvrir `AzeooApp/android/settings.gradle` et décommenter :

```groovy
def flutterProjectRoot = file("../../flutter_profile_sdk")
def flutterModule = new File(flutterProjectRoot, ".android/Flutter")
setBinding(new Binding([gradle: this]))
evaluate(new File(flutterProjectRoot, ".android/include_flutter.groovy"))
include ':flutter'
project(':flutter').projectDir = flutterModule
```

#### B. Modifier `app/build.gradle`

Ouvrir `AzeooApp/android/app/build.gradle` et ajouter dans dependencies :

```groovy
implementation project(':flutter')
```

### Étape 3 : Synchroniser et Builder

```bash
# 1. Aller dans AzeooApp
cd D:\tesst_AZEOO\AzeooApp

# 2. Nettoyer le cache
cd android
gradlew clean
cd ..

# 3. Installer les dépendances npm
npm install

# 4. Lancer l'app
npx react-native run-android
```

---

## 🏗️ Architecture du Bridge

```
┌─────────────────────────────────────────────────────────────┐
│                     REACT NATIVE                             │
├─────────────────────────────────────────────────────────────┤
│  Tab1Screen.tsx          Tab2Screen.tsx                      │
│       │                        │                             │
│       │                        ▼                             │
│       │              FlutterProfileView.tsx                  │
│       │                        │                             │
│       │           requireNativeComponent()                   │
│       │                        │                             │
├───────┼────────────────────────┼─────────────────────────────┤
│       │        BRIDGE NATIF (Kotlin)                         │
│       ▼                        ▼                             │
│  FlutterProfile         FlutterProfileViewManager            │
│     Module                     │                             │
│       │                        ▼                             │
│       │              FlutterEngineManager                    │
│       │                        │                             │
│       └────────────────────────┼─────────────────────────────┤
│                                │                             │
│                    MethodChannel                             │
│                                │                             │
├────────────────────────────────┼─────────────────────────────┤
│                         FLUTTER SDK                          │
│                                ▼                             │
│                    MethodChannelService                      │
│                                │                             │
│                          Riverpod                            │
│                                │                             │
│                       ProfileScreen                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔍 Fichiers du Bridge

### Côté Android (Kotlin)

| Fichier | Rôle |
|---------|------|
| `FlutterEngineManager.kt` | Gère le FlutterEngine singleton |
| `FlutterProfileViewManager.kt` | ViewManager pour React Native |
| `FlutterProfilePackage.kt` | Package pour enregistrer les modules |
| `FlutterProfileModule.kt` | Méthodes exposées à JavaScript |

### Côté Flutter (Dart)

| Fichier | Rôle |
|---------|------|
| `method_channel_service.dart` | Écoute les messages de React Native |

### Côté React Native (TypeScript)

| Fichier | Rôle |
|---------|------|
| `FlutterProfileView.tsx` | Composant qui charge la FlutterView |

---

## ⚠️ Problèmes Connus

### 1. Bug Gradle avec React Native 0.82.1

Si vous rencontrez l'erreur `JvmVendorSpec IBM_SEMERU`, essayez :

```bash
# Downgrade Gradle
cd android
./gradlew wrapper --gradle-version=8.3
```

### 2. FlutterEngine non trouvé

Vérifiez que `MainApplication.kt` initialise bien le FlutterEngine :

```kotlin
override fun onCreate() {
    super.onCreate()
    FlutterEngineManager.initialize(this)  // ← Important !
    loadReactNative(this)
}
```

### 3. Module Flutter non trouvé

Assurez-vous que `flutter build aar` a été exécuté avec succès.

---

## 🧪 Tester le Bridge

### Test 1 : Vérifier que le FlutterEngine démarre

Dans les logs Android :
```
🔗 MethodChannel initialisé
```

### Test 2 : Vérifier la communication

1. Entrer un userId dans Tab1
2. Appuyer sur "Sauvegarder"
3. Vérifier dans les logs Flutter :
```
📱 userId reçu de RN: 1
```

---

## 📱 Alternative : Mode Standalone

Si le bridge est trop complexe à configurer, le SDK Flutter fonctionne parfaitement en standalone :

```bash
cd flutter_profile_sdk
flutter run
```

Cela démontre toutes les fonctionnalités du SDK.

---

## 📞 Support

En cas de problème, vérifiez :
1. Les logs `adb logcat | grep -E "(Flutter|React)"`
2. La version de Flutter : `flutter --version`
3. La version de Gradle dans `gradle-wrapper.properties`

---

**Date de création :** 4 décembre 2025

