# 🧪 Tests du SDK Flutter AZEOO

## 📁 Structure des Tests

```
test/
├── domain/                          # Tests de la couche Domain
│   ├── entities/
│   │   └── user_test.dart          # Tests de l'entité User
│   └── usecases/
│       └── get_user_profile_test.dart  # Tests du UseCase
│
├── data/                            # Tests de la couche Data
│   ├── models/
│   │   └── user_model_test.dart    # Tests du modèle JSON
│   ├── datasources/
│   │   └── user_local_datasource_test.dart  # Tests du cache
│   └── repositories/
│       └── user_repository_impl_test.dart   # Tests du repository
│
├── presentation/                    # Tests de la couche Presentation
│   ├── widgets/
│   │   ├── profile_avatar_test.dart
│   │   ├── profile_info_test.dart
│   │   ├── loading_widget_test.dart
│   │   └── error_widget_test.dart
│   ├── router/
│   │   └── app_router_test.dart    # Tests go_router
│   ├── screens/
│   │   └── home_screen_test.dart
│   └── services/
│       └── method_channel_service_test.dart
│
├── integration/                     # Tests d'intégration
│   └── full_flow_test.dart         # Test du flux complet
│
├── profile_sdk_test.dart           # Tests du point d'entrée SDK
├── all_tests.dart                  # Exécute tous les tests
└── README.md                       # Ce fichier
```

## 🚀 Exécution des Tests

### Tous les tests
```bash
flutter test
```

### Tests spécifiques
```bash
# Domain Layer
flutter test test/domain/

# Data Layer
flutter test test/data/

# Presentation Layer
flutter test test/presentation/

# Integration
flutter test test/integration/

# SDK Entry Point
flutter test test/profile_sdk_test.dart
```

### Avec couverture
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Mode verbose
```bash
flutter test --reporter expanded
```

## 📊 Couverture des Tests

| Composant | Fichiers Testés | Couverture |
|-----------|-----------------|------------|
| **Domain** | | |
| User Entity | ✅ | Création, égalité, copyWith |
| GetUserProfile | ✅ | Appel repository, gestion erreurs |
| **Data** | | |
| UserModel | ✅ | fromJson, toJson, toEntity |
| LocalDataSource | ✅ | Cache get/set/clear |
| RepositoryImpl | ✅ | Cache logic, API fallback |
| **Presentation** | | |
| ProfileAvatar | ✅ | Rendu, radius |
| ProfileInfo | ✅ | Affichage nom, style |
| LoadingWidget | ✅ | CircularProgressIndicator |
| ErrorWidget | ✅ | Message, bouton retry |
| AppRouter | ✅ | Routes, navigation |
| HomeScreen | ✅ | Input, bouton, navigation |
| MethodChannel | ✅ | Streams, initialisation |
| **SDK** | | |
| ProfileSDK | ✅ | buildProfileScreen, buildApp |
| **Integration** | | |
| Full Flow | ✅ | Home → Profile → Back |

## 🎯 Types de Tests

### 1. Tests Unitaires
Tests isolés de chaque composant :
- Entities
- Models
- UseCases
- DataSources
- Repositories

### 2. Tests de Widgets
Tests des composants UI :
- Rendu correct
- Interactions utilisateur
- États (loading, error, data)

### 3. Tests d'Intégration
Tests du flux complet :
- Navigation entre écrans
- Chargement des données
- Rafraîchissement

## ✅ Bonnes Pratiques

1. **Arrange-Act-Assert** : Structure claire de chaque test
2. **Mocks** : Utilisation de mocks pour isoler les tests
3. **Naming** : Noms descriptifs (`should_do_something_when_condition`)
4. **Coverage** : Viser 80%+ de couverture
5. **Fast** : Tests rapides (pas d'appels réseau réels)

## 🔧 Configuration

Les tests utilisent :
- `flutter_test` : Framework de test Flutter
- `flutter_riverpod` : Pour tester les providers
- Mocks manuels (pas besoin de mockito pour ce projet)

## 📝 Ajouter un Nouveau Test

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NomDuComposant', () {
    test('should do something', () {
      // Arrange
      // ...
      
      // Act
      // ...
      
      // Assert
      expect(result, expectedValue);
    });
  });
}
```

---

**Dernière mise à jour :** 4 décembre 2025



