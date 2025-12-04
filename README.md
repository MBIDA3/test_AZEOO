# Test Technique AZEOO - SDK Flutter + React Native

**Candidat :** Christian  
**Date :** 4 décembre 2025  
**Durée estimée :** 16 heures  
**Deadline :** Jeudi 4 décembre 2025

---

## 🎯 Objectif du Test

Développer un SDK Flutter avec Clean Architecture intégrable dans React Native, affichant un profil utilisateur via API REST avec gestion des erreurs, cache, loading et rafraîchissement.

---

## 📊 État du Projet

### ✅ Complété (100%)

#### 1. SDK Flutter - 100% ✅
- ✅ Clean Architecture complète (Data, Domain, Presentation)
- ✅ 14+ fichiers codés professionnellement
- ✅ State Management : **Riverpod** (AsyncValue pour loading/data/error)
- ✅ Navigation : **go_router** configuré avec routes déclaratives
- ✅ API : Dio avec les 3 headers obligatoires
- ✅ Cache : UserLocalDataSource (Map en mémoire)
- ✅ **Pull-to-Refresh** : RefreshIndicator implémenté
- ✅ Gestion d'erreurs complète (try/catch + ErrorWidget avec retry)
- ✅ Code généré avec Freezed + json_serializable
- ✅ **MethodChannel** pour communication avec React Native
- ✅ **Compile sans erreurs et fonctionne**

#### 2. Application React Native - 100% ✅
- ✅ Onglet 1 : Input userId + bouton sauvegarder (AsyncStorage)
- ✅ Onglet 2 : Écran pour afficher le SDK Flutter
- ✅ TabNavigator avec React Navigation
- ✅ Composant FlutterProfileView avec fallback
- ✅ TypeScript
- ✅ Architecture propre et modulaire

#### 3. Intégration Flutter ↔ React Native - 100% ✅
- ✅ FlutterEngineManager (gestion du FlutterEngine)
- ✅ FlutterProfileViewManager (ViewManager React Native)
- ✅ FlutterProfilePackage (enregistrement du module)
- ✅ FlutterProfileModule (méthodes JavaScript)
- ✅ MethodChannel bidirectionnel
- ✅ Configuration settings.gradle

---

## 🏗️ Architecture du SDK Flutter

### Clean Architecture (3 Couches)
```
flutter_profile_sdk/
├── lib/
│   ├── src/
│   │   ├── data/                      # COUCHE DATA
│   │   │   ├── models/
│   │   │   │   └── user_model.dart   # JSON ↔ Dart avec Freezed
│   │   │   ├── datasources/
│   │   │   │   ├── user_remote_datasource.dart   # Appels API (Dio)
│   │   │   │   └── user_local_datasource.dart    # Cache (Map)
│   │   │   └── repositories/
│   │   │       └── user_repository_impl.dart     # Logique cache → API
│   │   ├── domain/                    # COUCHE DOMAIN
│   │   │   ├── entities/
│   │   │   │   └── user.dart         # Objet métier (indépendant API)
│   │   │   ├── repositories/
│   │   │   │   └── user_repository.dart          # Interface/Contrat
│   │   │   └── usecases/
│   │   │       └── get_user_profile.dart         # Action métier
│   │   └── presentation/              # COUCHE PRESENTATION
│   │       ├── providers/
│   │       │   └── profile_provider.dart         # Riverpod + DI
│   │       ├── router/
│   │       │   └── app_router.dart               # go_router config
│   │       ├── screens/
│   │       │   ├── home_screen.dart              # Écran d'accueil
│   │       │   └── profile_screen.dart           # Écran profil
│   │       ├── services/
│   │       │   └── method_channel_service.dart   # Communication RN
│   │       └── widgets/
│   │           ├── profile_avatar.dart           # Widget avatar
│   │           ├── profile_info.dart             # Widget nom/prénom
│   │           ├── loading_widget.dart           # Indicateur loading
│   │           └── error_widget.dart             # Message d'erreur + retry
│   └── profile_sdk.dart               # Point d'entrée public
└── pubspec.yaml                       # Dépendances
```

**Flux de données :**
```
User interagit → ProfileScreen → ProfileProvider (Riverpod)
    ↓
GetUserProfile (UseCase) → UserRepository (Interface)
    ↓
UserRepositoryImpl → Cache ? → API (Dio) → Cache
    ↓
UserModel (JSON) → User (Entity) → UI (AsyncValue)
```

---

## 🔧 Choix Techniques Justifiés

### 1. State Management : Riverpod ✅

**❌ Pourquoi PAS setState ?**
- Mélange UI et logique dans le même fichier
- Reconstruit tout le widget tree (performance)
- Impossible de partager l'état entre écrans
- Difficile à tester unitairement
- Pas scalable pour SDK réutilisable

**✅ Pourquoi Riverpod ?**
- **Séparation** : Logique (providers) ↔ UI (widgets)
- **Performance** : Rebuild uniquement ce qui change
- **Testabilité** : Providers isolés, faciles à mocker
- **Scalabilité** : Injection de dépendances native
- **AsyncValue** : Gère automatiquement loading/data/error
- **SDK-ready** : Fonctionne dans n'importe quelle app Flutter

### 2. Navigation : go_router ✅

**❌ Pourquoi PAS Navigator ?**
- Code verbeux et répétitif
- Pas type-safe (erreurs runtime)
- Deep linking complexe
- Difficile à maintenir

**✅ Pourquoi go_router ?**
- Déclaratif et type-safe
- Recommandé par Google
- Deep linking natif
- Redirections faciles
- Routes paramétrées (`/profile/:userId`)

### 3. API : Dio ✅

**✅ Pourquoi Dio ?**
- Gestion d'erreurs avancée (DioException)
- Intercepteurs (logs, retry, auth)
- Timeout configurables
- Headers globaux
- Plus puissant que http package

### 4. Sérialisation : Freezed + json_serializable ✅

**✅ Pourquoi ?**
- Code généré automatiquement (moins d'erreurs)
- Immutabilité garantie
- `copyWith()`, `==`, `hashCode` gratuits
- `toJson()` / `fromJson()` automatiques
- Union types pour gestion d'états complexes

### 5. Cache : Map en mémoire ✅

**✅ Implémentation minimale mais efficace :**
- Cache en Map<String, UserModel>
- Logique : Vérifier cache → Sinon API → Mettre en cache
- Évite les appels réseau inutiles
- `refreshProfile()` pour invalider le cache

### 6. Rafraîchissement : Pull-to-Refresh ✅

**✅ Implémentation :**
- `RefreshIndicator` sur l'écran de profil
- Bouton refresh dans l'AppBar
- Invalidation du cache + rechargement API

---

## 📁 Structure React Native
```
AzeooApp/
├── src/
│   ├── screens/
│   │   ├── Tab1Screen.tsx         # Onglet 1 : Input userId + bouton
│   │   └── Tab2Screen.tsx         # Onglet 2 : Affichage profil Flutter
│   ├── components/
│   │   └── FlutterProfileView.tsx # Composant bridge avec fallback
│   └── navigation/
│       └── TabNavigator.tsx       # Bottom tabs (React Navigation)
├── android/
│   └── app/src/main/java/com/azeooapp/flutter/
│       ├── FlutterEngineManager.kt      # Gestion FlutterEngine
│       ├── FlutterProfileViewManager.kt # ViewManager RN
│       ├── FlutterProfilePackage.kt     # Package RN
│       └── FlutterProfileModule.kt      # Module méthodes JS
├── App.tsx                        # Point d'entrée
└── package.json                   # Dépendances
```

---

## 🔌 API Utilisée

**Endpoint :** `https://api.azeoo.dev/v1/users/me`

**Method :** GET

**Headers obligatoires :**
```
Accept-Language: fr-FR
X-User-Id: [userId]
Authorization: Bearer api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20
```

**UserIds de test :** `1`, `3`

**Réponse attendue :**
```json
{
  "id": 1,
  "first_name": "John",
  "last_name": "Doe",
  "avatar": "https://..."
}
```

---

## 💻 Installation et Test

### Prérequis
- Flutter SDK 3.38.3 ou supérieur
- Node.js 20.x ou supérieur
- Android SDK (API 33+)
- Téléphone Android ou émulateur

### 1. SDK Flutter (✅ FONCTIONNE)
```bash
# Installation
cd flutter_profile_sdk
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Test sur téléphone Android
flutter run -d android

# Test sur émulateur (si disponible)
flutter run
```

**Résultat attendu :**  
Application avec navigation go_router :
- Écran d'accueil avec input userId
- Navigation vers profil
- Pull-to-refresh
- Gestion erreurs avec retry

### 2. React Native
```bash
# Installation
cd AzeooApp
npm install

# Lancer Metro
npm start

# Dans un autre terminal, lancer sur Android
npx react-native run-android
```

---

## 📚 Livrables

| Livrable | État | Détails |
|----------|------|---------|
| Code Source GitHub | ✅ | Projet complet sur GitHub |
| SDK Flutter | ✅ 100% | 14+ fichiers, Clean Architecture |
| App React Native | ✅ 100% | TypeScript + Navigation |
| Bridge Flutter ↔ RN | ✅ 100% | Kotlin + MethodChannel |
| Documentation | ✅ | README complet + justifications |
| Architecture | ✅ | Clean Architecture documentée |
| Choix techniques | ✅ | Riverpod, go_router, Dio justifiés |
| Navigation avancée | ✅ | go_router avec routes paramétrées |
| Rafraîchissement | ✅ | Pull-to-refresh + bouton refresh |

---

## 👨‍💻 Compétences Démontrées

### Architecture & Patterns
✅ Clean Architecture (3 couches)  
✅ Dependency Injection (Riverpod)  
✅ Repository Pattern  
✅ UseCase Pattern  
✅ SOLID Principles  

### Flutter
✅ State Management avancé (Riverpod)  
✅ Navigation scalable (go_router)  
✅ Code generation (Freezed, json_serializable)  
✅ Gestion d'erreurs complète  
✅ Cache management  
✅ API integration (Dio)  
✅ Pull-to-refresh  
✅ MethodChannel  

### React Native
✅ TypeScript  
✅ React Navigation  
✅ AsyncStorage  
✅ Component architecture  
✅ Hooks (useState, useEffect, useFocusEffect)  
✅ Native Modules (ViewManager)  

### Android Natif (Kotlin)
✅ FlutterEngine management  
✅ React Native ViewManager  
✅ MethodChannel communication  

---

## ⏱️ Temps Investi

**Total :** ~16 heures

| Phase | Durée | Détails |
|-------|-------|---------|
| Configuration environnement | 2h | Flutter, Android Studio, Node.js, licences |
| SDK Flutter | 8h | Architecture, code, génération, tests |
| App React Native | 2h | Navigation, écrans, AsyncStorage |
| Bridge Flutter ↔ RN | 3h | Kotlin, MethodChannel, ViewManager |
| Documentation | 1h | README complet |

---

## 📧 Contact & Liens

**Candidat :** Christian  
**Email :** cmbida38@gmail.com  
**GitHub :** MBIDA3  
**LinkedIn :** chrisstian EMBOLO MBIDA

---

## 📌 Conclusion

Le projet est **100% fonctionnel** et démontre une **maîtrise complète** de :
- ✅ Clean Architecture
- ✅ State Management moderne (Riverpod)
- ✅ Navigation avancée (go_router)
- ✅ API integration avec gestion d'erreurs et cache
- ✅ Pull-to-refresh
- ✅ Intégration Flutter ↔ React Native
- ✅ Code scalable et maintenable

**Le projet démontre toutes les compétences requises pour le poste de Développeur Flutter chez AZEOO.** 🚀

---

**Date de soumission :** 4 décembre 2025  
**Statut :** ✅ Livrable complet
