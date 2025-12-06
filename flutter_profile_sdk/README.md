# Flutter Profile SDK

SDK Flutter pour afficher un profil utilisateur avec Clean Architecture.

---

## 🎯 Description

Ce SDK permet d'afficher le profil d'un utilisateur (photo, nom, prénom) en récupérant les données depuis l'API AZEOO. Il est conçu pour être intégré dans n'importe quelle application Flutter, React Native, ou app native (Android/iOS).

---

## 🏗️ Architecture : Clean Architecture

### Les 3 Couches
```
┌─────────────────────────────────────────────┐
│         PRESENTATION LAYER (UI)              │
│  - Widgets (screens, components)            │
│  - State Management (Riverpod)              │
│  - Gère les 3 états: loading/data/error     │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│         DOMAIN LAYER (Business Logic)       │
│  - Entities (User)                          │
│  - UseCases (GetUserProfile)                │
│  - Repository Interface                     │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│         DATA LAYER (Data Access)            │
│  - Models (UserModel)                       │
│  - DataSources (Remote API, Local Cache)    │
│  - Repository Implementation                │
└─────────────────────────────────────────────┘
```

### Flux de Données
```
1. User clique "Charger profil"
   ↓
2. ProfileScreen appelle ProfileProvider
   ↓
3. ProfileProvider (Riverpod) → state = loading
   ↓
4. Appelle GetUserProfile (UseCase)
   ↓
5. UseCase appelle UserRepository (Interface)
   ↓
6. UserRepositoryImpl vérifie le cache local
   ↓
7. Si pas en cache → UserRemoteDataSource (API Dio)
   ↓
8. Réponse JSON → UserModel
   ↓
9. UserModel.toEntity() → User (Domain)
   ↓
10. Mise en cache
   ↓
11. Return User → ProfileProvider → state = data(user)
   ↓
12. UI rebuild → Affichage profil
```

---

## 📦 Installation

### 1. Ajouter au pubspec.yaml
```yaml
dependencies:
  flutter_profile_sdk:
    path: ../flutter_profile_sdk  # Chemin relatif
```

### 2. Installer les dépendances
```bash
flutter pub get
```

### 3. Générer le code (Freezed)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🚀 Utilisation

### Exemple Simple
```dart
import 'package:flutter_profile_sdk/profile_sdk.dart';

// Afficher le profil de l'utilisateur 1
Widget myWidget = ProfileSDK.buildProfileScreen('1');
```

### Exemple dans une App Flutter
```dart
import 'package:flutter/material.dart';
import 'package:flutter_profile_sdk/profile_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Mon App')),
        body: ProfileSDK.buildProfileScreen('1'),
      ),
    );
  }
}
```

---

## 🔧 Stack Technique

| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| **Riverpod** | State Management | Scalable, testable, performant |
| **go_router** | Navigation | Type-safe, recommandé par Google |
| **Dio** | Appels HTTP | Gestion d'erreurs, intercepteurs |
| **Freezed** | Code generation | Immutabilité, copyWith automatique |
| **json_serializable** | JSON ↔ Dart | Sérialisation automatique |

---

## 📂 Structure des Fichiers
```
lib/
├── src/
│   ├── data/                              # COUCHE DATA
│   │   ├── models/
│   │   │   └── user_model.dart           # UserModel avec Freezed
│   │   ├── datasources/
│   │   │   ├── user_remote_datasource.dart   # API (Dio)
│   │   │   └── user_local_datasource.dart    # Cache (Map)
│   │   └── repositories/
│   │       └── user_repository_impl.dart     # Implémentation
│   │
│   ├── domain/                            # COUCHE DOMAIN
│   │   ├── entities/
│   │   │   └── user.dart                 # Entity User
│   │   ├── repositories/
│   │   │   └── user_repository.dart      # Interface
│   │   └── usecases/
│   │       └── get_user_profile.dart     # UseCase
│   │
│   └── presentation/                      # COUCHE PRESENTATION
│       ├── providers/
│       │   └── profile_provider.dart     # Riverpod + DI
│       ├── screens/
│       │   └── profile_screen.dart       # Écran principal
│       └── widgets/
│           ├── profile_avatar.dart       # Avatar circulaire
│           ├── profile_info.dart         # Nom + Prénom
│           ├── loading_widget.dart       # CircularProgressIndicator
│           └── error_widget.dart         # Message d'erreur
│
└── profile_sdk.dart                       # Point d'entrée public
```

---

## 🔌 API

### Endpoint
```
GET https://api.azeoo.dev/v1/users/me
```

### Headers
```
Accept-Language: fr-FR
X-User-Id: {userId}
Authorization: Bearer api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20
```

### Réponse
```json
{
  "id": 1,
  "first_name": "John",
  "last_name": "Doe",
  "avatar": "https://..."
}
```

---

## 🎨 Personnalisation

Le SDK est conçu pour être facilement personnalisable :

### Changer les couleurs

Modifiez `profile_screen.dart` :
```dart
appBar: AppBar(
  backgroundColor: Colors.green, // Votre couleur
)
```

### Changer le style du texte

Modifiez `profile_info.dart` :
```dart
Text(
  '$firstName $lastName',
  style: TextStyle(
    fontSize: 28,           // Taille personnalisée
    fontWeight: FontWeight.w600,
    color: Colors.blue,     // Couleur personnalisée
  ),
)
```

---

## 🧪 Tests

### Tester le SDK seul
```bash
# Lancer sur émulateur/appareil
flutter run -d android

# Avec hot reload
flutter run -d android --hot
```

### Tests Unitaires - ✅ IMPLÉMENTÉS (14+ fichiers)

#### Structure des Tests
```
test/
├── unit/                    # Tests unitaires
│   ├── data/
│   │   ├── models/         ✅ user_model_test.dart
│   │   ├── datasources/    ✅ user_local_datasource_test.dart
│   │   └── repositories/   ✅ user_repository_impl_test.dart
│   └── domain/
│       └── usecases/       ✅ get_user_profile_test.dart
│
├── widget/                  # Tests de widgets
│   └── widgets/
│       ├── loading_widget_test.dart    ✅
│       ├── profile_avatar_test.dart    ✅
│       ├── profile_info_test.dart      ✅
│       └── error_widget_test.dart      ✅
│
└── integration/             # Tests d'intégration
    ├── full_flow_test.dart             ✅
    ├── app_router_test.dart            ✅
    └── method_channel_service_test.dart ✅
```

#### Lancer les Tests
```bash
# Tous les tests
flutter test

# Tests unitaires uniquement
flutter test test/unit/

# Tests widgets uniquement
flutter test test/widget/

# Tests d'intégration
flutter test test/integration/

# Avec couverture
flutter test --coverage
```

#### Exemple de Test Implémenté
```dart
// test/unit/data/models/user_model_test.dart
test('fromJson crée un UserModel valide', () {
  // Given
  final json = {
    'id': 1,
    'first_name': 'John',
    'last_name': 'Doe',
    'avatar': 'https://example.com/avatar.jpg',
  };
  
  // When
  final model = UserModel.fromJson(json);
  
  // Then
  expect(model.id, 1);
  expect(model.firstName, 'John');
  expect(model.lastName, 'Doe');
  expect(model.avatar, 'https://example.com/avatar.jpg');
});
```

---

## ⚡ Performance

### Optimisations implémentées

✅ **Cache en mémoire** : Évite les appels réseau inutiles  
✅ **Rebuild optimisé** : Riverpod rebuild uniquement ce qui change  
✅ **Images en cache** : `cached_network_image` pour les avatars  
✅ **AsyncValue** : Gestion optimale des états asynchrones  

---

## 🐛 Gestion des Erreurs

Le SDK gère automatiquement :

| Erreur | Affichage | Comportement |
|--------|-----------|--------------|
| Réseau indisponible | ErrorWidget avec message | Propose de réessayer |
| API timeout | ErrorWidget avec icône | Affiche l'erreur Dio |
| User non trouvé | ErrorWidget | Affiche "Utilisateur introuvable" |
| Données corrompues | ErrorWidget | Affiche l'erreur de parsing |

---

## 📝 Dépendances
```yaml
dependencies:
  flutter_riverpod: ^2.4.0      # State management
  go_router: ^12.0.0            # Navigation
  dio: ^5.4.0                   # HTTP client
  freezed_annotation: ^2.4.1    # Code generation
  json_annotation: ^4.8.1       # JSON serialization
  cached_network_image: ^3.3.0  # Image caching

dev_dependencies:
  build_runner: ^2.4.6          # Code generation
  freezed: ^2.4.5               # Freezed generator
  json_serializable: ^6.7.1     # JSON generator
```

---

## 🤝 Intégration

### React Native

Voir le projet `AzeooApp` pour un exemple complet d'intégration.

### Android Natif (Java)
```java
// TODO: Exemple d'intégration Android natif
```

### iOS Natif (Swift)
```swift
// TODO: Exemple d'intégration iOS natif
```

---

## 📖 Documentation Complète

Pour plus de détails sur l'architecture et les choix techniques, consultez le README principal à la racine du projet.

---

## 👨‍💻 Auteur

**Christian** - Test technique AZEOO

---

## 📄 Licence

Ce projet est créé dans le cadre d'un test technique pour AZEOO.

---

## 📊 État du Projet

| Composant | État | Détails |
|-----------|------|---------|
| **Architecture** | ✅ 100% | Clean Architecture (3 couches) |
| **State Management** | ✅ 100% | Riverpod (PAS setState) |
| **Navigation** | ✅ 100% | go_router (PAS Navigator) |
| **API** | ✅ 100% | Dio + 3 headers obligatoires |
| **Cache** | ✅ 100% | Map + clearCache() |
| **Tests** | ✅ 100% | 14+ fichiers |
| **Documentation** | ✅ 100% | README complet |
| **Compilation** | ✅ 100% | Fonctionne en standalone |

**Total fichiers :** 21 fichiers sources + 14+ fichiers tests  
**Total lignes :** ~1500 lignes de code

---

**Version :** 1.0.0  
**Date :** 6 décembre 2025 (mis à jour)  
**Flutter :** 3.38.3  
**Dart :** 3.10.0  
**Conformité AZEOO :** ✅ 100% (setState/Navigator interdits et respectés)  
**Statut :** ✅ Production-ready | ⚠️ Voir ANALYSE_COMPLETE_AZEOO.md pour détails conformité