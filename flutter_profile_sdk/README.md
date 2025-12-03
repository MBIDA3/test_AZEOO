# Flutter Profile SDK

## Description
SDK Flutter pour afficher un profil utilisateur à partir d'une API REST.

## Architecture
Ce SDK suit la **Clean Architecture** avec 3 couches :
- **Data Layer** : Appels API, cache, modèles
- **Domain Layer** : Logique métier, entities, use cases
- **Presentation Layer** : UI, state management (Riverpod)

## Stack Technique
- **State Management** : Riverpod
- **Navigation** : go_router
- **API** : Dio
- **Sérialisation** : Freezed + json_serializable
- **Cache** : flutter_cache_manager + Map en mémoire

## Installation

### 1. Installer les dépendances
```bash
flutter pub get
```

### 2. Générer le code (Freezed, JSON)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Utilisation

### Intégration basique
```dart
import 'package:flutter_profile_sdk/profile_sdk.dart';

ProfileSDK.buildProfileScreen('1'); // userId = 1
```

### Intégration dans React Native
Voir le projet `react_native_app` pour un exemple complet d'intégration.

## Structure du projet
```
lib/
├── src/
│   ├── data/          # Appels API, cache, modèles
│   ├── domain/        # Logique métier, entities
│   └── presentation/  # UI, state management
└── profile_sdk.dart   # Point d'entrée public
```

## Choix techniques

### Pourquoi Riverpod ?
- Scalable et performant
- Rebuild uniquement ce qui change
- Facilite les tests

### Pourquoi Clean Architecture ?
- Séparation des responsabilités
- Maintenable sur le long terme
- Testable

### Pourquoi pas setState ?
- Trop basique
- Pas scalable
- Reconstruit tout le widget tree

## API Utilisée
- URL : `https://api.azeoo.dev/v1/users/me`
- Headers obligatoires :
  - `Accept-Language: fr-FR`
  - `X-User-Id: [userId]`
  - `Authorization: Bearer [token]`

## Auteur
Christian - Test technique AZEOO

## Date limite
Jeudi 4 décembre 2025
