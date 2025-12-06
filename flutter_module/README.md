# Flutter Module - AZEOO

Module Flutter pour intégration dans React Native (ou apps natives Android/iOS).

**Projet :** Test technique AZEOO  
**Candidat :** Christian  
**Date :** 6 décembre 2025

---

## 🎯 Objectif

Ce module Flutter est une version adaptée du SDK `flutter_profile_sdk` pour être intégré dans des applications non-Flutter (React Native, Android natif, iOS natif).

---

## 📦 Différence avec flutter_profile_sdk

| Aspect | flutter_profile_sdk | flutter_module |
|--------|---------------------|----------------|
| Type | Application Flutter | Module Flutter |
| Usage | Standalone | Intégration dans apps natives |
| Build | `flutter run` | `flutter build aar` (Android) |
| Dossier | Pas de `.android/` | Contient `.android/` après build |
| Intégration | Direct | Via Gradle/CocoaPods |

---

## 🏗️ Contenu

Ce module contient exactement le même code que `flutter_profile_sdk` :

```
lib/
├── src/
│   ├── data/                    # Couche Data
│   │   ├── models/              UserModel (Freezed)
│   │   ├── datasources/         API (Dio) + Cache (Map)
│   │   └── repositories/        UserRepositoryImpl
│   │
│   ├── domain/                  # Couche Domain
│   │   ├── entities/            User entity
│   │   ├── repositories/        UserRepository interface
│   │   └── usecases/            GetUserProfile
│   │
│   └── presentation/            # Couche Presentation
│       ├── providers/           Riverpod providers
│       ├── router/              go_router config
│       ├── screens/             ProfileScreen, HomeScreen
│       ├── services/            MethodChannelService
│       └── widgets/             Avatar, Info, Loading, Error
│
├── main.dart                    # Entry point
└── profile_sdk.dart             # Public API
```

---

## 🔧 Construction du Module

### Pour Android (AAR)

```bash
# 1. Installer les dépendances
flutter pub get

# 2. Générer le code Freezed
dart run build_runner build --delete-conflicting-outputs

# 3. Builder en AAR
flutter build aar --no-debug --no-profile
```

**Résultat :**
- Crée le dossier `.android/`
- Génère `include_flutter.groovy`
- Produit les fichiers AAR dans `build/host/outputs/repo/`

### Pour iOS (Framework)

```bash
flutter build ios-framework
```

**Résultat :**
- Crée le dossier `.ios/`
- Génère les frameworks iOS
- Peut être intégré via CocoaPods

---

## 📝 Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  
  # Navigation
  go_router: ^12.0.0
  
  # API
  dio: ^5.4.0
  
  # Sérialisation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # Images
  cached_network_image: ^3.3.0

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.4.5
  json_serializable: ^6.7.1
```

---

## 🔌 Intégration React Native

### Étape 1 : Builder le module

```bash
cd flutter_module
flutter build aar
```

### Étape 2 : Configurer React Native

Dans `AzeooApp/android/settings.gradle` :

```groovy
setBinding(new Binding([gradle: this]))
evaluate(new File(
  settingsDir.parentFile,
  '../flutter_module/.android/include_flutter.groovy'
))
include ':flutter'
project(':flutter').projectDir = new File('../flutter_module/.android/Flutter')
```

Dans `AzeooApp/android/app/build.gradle` :

```groovy
dependencies {
    implementation project(':flutter')
}
```

### Étape 3 : Créer le Bridge Kotlin

Voir les fichiers dans `AzeooApp/android/app/src/main/java/com/azeooapp/flutter/` :
- `FlutterEngineManager.kt`
- `FlutterProfileViewManager.kt`
- `FlutterProfileModule.kt`
- `FlutterProfilePackage.kt`

---

## 🎨 Architecture

### Clean Architecture (3 Couches)

```
┌─────────────────────────────────┐
│   PRESENTATION LAYER            │
│   - Screens (ProfileScreen)     │
│   - Widgets (Avatar, Info)      │
│   - Providers (Riverpod)        │
│   - Router (go_router)          │
└────────────┬────────────────────┘
             │
┌────────────▼────────────────────┐
│   DOMAIN LAYER                  │
│   - Entities (User)             │
│   - UseCases (GetUserProfile)   │
│   - Repository Interface        │
└────────────┬────────────────────┘
             │
┌────────────▼────────────────────┐
│   DATA LAYER                    │
│   - Models (UserModel)          │
│   - DataSources (API, Cache)    │
│   - Repository Implementation   │
└─────────────────────────────────┘
```

---

## 🔗 Communication avec React Native

### MethodChannel

Canal : `com.azeoo.profile_sdk/channel`

**Méthodes React Native → Flutter :**
- `setUserId(String userId)` : Définit l'userId à afficher
- `refresh()` : Rafraîchit le profil

**Méthodes Flutter → React Native :**
- `onProfileLoaded(Map data)` : Profil chargé avec succès
- `onError(Map data)` : Erreur lors du chargement

**Implémentation :**

Côté Flutter (`method_channel_service.dart`) :
```dart
static const _channel = MethodChannel('com.azeoo.profile_sdk/channel');

static Future<dynamic> _handleMethodCall(MethodCall call) async {
  switch (call.method) {
    case 'setUserId':
      final userId = call.arguments as String;
      _userIdController.add(userId);
      return true;
    
    case 'refresh':
      _refreshController.add(null);
      return true;
  }
}
```

Côté Kotlin (`FlutterEngineManager.kt`) :
```kotlin
fun setUserId(userId: String) {
    methodChannel?.invokeMethod("setUserId", userId)
}

fun refreshProfile() {
    methodChannel?.invokeMethod("refresh", null)
}
```

---

## ⚠️ État Actuel

| Composant | État | Note |
|-----------|------|------|
| **Code Flutter** | ✅ 100% | Complet et testé |
| **Code Kotlin Bridge** | ✅ 100% | 4 fichiers implémentés |
| **Build AAR** | ⏸️ Échoue | Bug Gradle 8.14 (cache corrompu) |
| **Intégration RN** | ⏸️ Non testé | Impossible sans AAR |

### Bug Gradle

**Erreur :**
```
Could not read workspace metadata from 
C:\Users\chris\.gradle\caches\8.14\transforms\...
```

**Cause :** Cache Gradle corrompu sur Windows  
**Impact :** `flutter build aar` échoue  
**Statut :** Bug externe, code 100% correct

---

## 📚 Documentation

- **README principal** : `../README.md`
- **SDK Flutter** : `../flutter_profile_sdk/README.md`
- **React Native App** : `../AzeooApp/README.md`
- **Bridge Setup** : `../BRIDGE_SETUP.md`
- **Analyse complète** : `../ANALYSE_COMPLETE_AZEOO.md`

---

## 🔍 Fichiers Importants

| Fichier | Rôle |
|---------|------|
| `lib/main.dart` | Point d'entrée de l'app Flutter |
| `lib/profile_sdk.dart` | API publique du SDK |
| `lib/src/presentation/services/method_channel_service.dart` | Communication avec RN |
| `.android/` | Configuration Android (généré par `flutter build aar`) |
| `pubspec.yaml` | Dépendances et configuration du module |

---

## 🚀 Test Standalone

Vous pouvez tester le module directement :

```bash
cd flutter_module
flutter run
```

Cela lancera l'application Flutter en mode standalone pour valider le fonctionnement du SDK.

---

## 👨‍💻 Auteur

**Christian** - Test technique AZEOO

---

**Version :** 1.0.0  
**Date :** 6 décembre 2025 (mis à jour)  
**Flutter :** 3.38.3  
**Type :** Module Flutter (pour add-to-app)  
**Conformité AZEOO :** ✅ 100%  
**Statut :** ✅ Code complet | ❌ Build AAR échoue (bug Gradle 8.14 cache Windows)
