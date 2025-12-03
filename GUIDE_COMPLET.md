# 📘 GUIDE COMPLET D'UTILISATION

Ce document explique **comment utiliser cette structure de projet** quand je te donnerai du code.

---

## 🎯 OBJECTIF DE CETTE STRUCTURE

Cette structure contient **tous les dossiers et fichiers** avec des **commentaires explicatifs**.

Quand je te donnerai du code, tu sauras **EXACTEMENT** où le mettre.

---

## 📂 STRUCTURE COMPLÈTE

```
azeoo-test-structure/
│
├── flutter_profile_sdk/          ← SDK FLUTTER
│   ├── lib/
│   │   ├── src/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── user_model.dart               ← Code du modèle UserModel
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── user_remote_datasource.dart   ← Appels API
│   │   │   │   │   └── user_local_datasource.dart    ← Cache
│   │   │   │   └── repositories/
│   │   │   │       └── user_repository_impl.dart     ← Implémentation Repository
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user.dart                     ← Entity User
│   │   │   │   ├── repositories/
│   │   │   │   │   └── user_repository.dart          ← Interface Repository
│   │   │   │   └── usecases/
│   │   │   │       └── get_user_profile.dart         ← UseCase
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── profile_provider.dart         ← Riverpod Provider
│   │   │       ├── screens/
│   │   │       │   └── profile_screen.dart           ← Écran principal
│   │   │       └── widgets/
│   │   │           ├── profile_avatar.dart           ← Widget Avatar
│   │   │           ├── profile_info.dart             ← Widget Info
│   │   │           ├── loading_widget.dart           ← Widget Loading
│   │   │           └── error_widget.dart             ← Widget Error
│   │   └── profile_sdk.dart                          ← Point d'entrée public
│   ├── pubspec.yaml                                  ← Dépendances Flutter
│   └── README.md                                     ← Doc SDK Flutter
│
└── react_native_app/             ← APP REACT NATIVE
    ├── src/
    │   ├── components/
    │   │   └── FlutterProfileView.tsx                ← Composant Flutter View
    │   ├── screens/
    │   │   ├── Tab1Screen.tsx                        ← Onglet 1 : Input
    │   │   └── Tab2Screen.tsx                        ← Onglet 2 : Profil
    │   └── navigation/
    │       └── TabNavigator.tsx                      ← Tab Bar
    ├── android/
    │   └── INSTRUCTIONS...                           ← Instructions Bridge Android
    ├── App.tsx                                       ← Point d'entrée RN
    ├── package.json                                  ← Dépendances RN
    └── README.md                                     ← Doc React Native
```

---

## 📝 COMMENT UTILISER CETTE STRUCTURE

### ÉTAPE 1 : Ouvre le projet dans VS Code

1. Ouvre VS Code
2. File → Open Folder
3. Sélectionne le dossier `azeoo-test-structure`

### ÉTAPE 2 : Explore les fichiers

Chaque fichier contient :
- 🎯 Un header qui explique son RÔLE
- 📋 Des INSTRUCTIONS sur ce qu'il faut coder
- 💡 Un EXEMPLE de structure commentée

### ÉTAPE 3 : Quand je te donne du code

**Je te dirai toujours** :
```
📂 Fichier : flutter_profile_sdk/lib/src/data/models/user_model.dart
💻 Remplace le TODO par ce code :
[... le code ...]
```

**Tu devras** :
1. Ouvrir le fichier indiqué
2. Supprimer la section `// TODO: ...`
3. Coller le code que je te donne
4. Sauvegarder

---

## 🔧 COMMANDES IMPORTANTES

### Pour le SDK Flutter

#### 1. Installer les dépendances
```bash
cd flutter_profile_sdk
flutter pub get
```

#### 2. Générer le code (Freezed, JSON)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. Si des erreurs de génération
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Pour l'app React Native

#### 1. Installer les dépendances
```bash
cd react_native_app
npm install
```

#### 2. Lancer sur Android
```bash
npm run android
```

---

## ⚠️ ORDRE DE DÉVELOPPEMENT

Nous allons coder **dans cet ordre** :

### PHASE 1 : SDK Flutter seul
1. ✅ Data Layer (models, datasources, repository)
2. ✅ Domain Layer (entities, repository interface, usecase)
3. ✅ Presentation Layer (provider, screens, widgets)
4. ✅ Tester le SDK Flutter seul (avant React Native)

### PHASE 2 : App React Native seule
1. ✅ Les 2 écrans (Tab1, Tab2)
2. ✅ Le TabNavigator
3. ✅ Tester React Native seul (sans Flutter pour l'instant)

### PHASE 3 : Le Bridge (la partie dure)
1. ✅ Configuration Android (settings.gradle)
2. ✅ FlutterViewManager (Android)
3. ✅ Tester l'intégration complète

---

## 📋 CHECKLIST AVANT DE COMMENCER À CODER

- [ ] VS Code installé
- [ ] Flutter SDK installé et configuré
- [ ] Node.js installé
- [ ] Android Studio installé
- [ ] Extensions VS Code (Flutter + Dart) installées
- [ ] `flutter doctor` → tout est OK
- [ ] `node --version` → fonctionne
- [ ] Structure du projet ouverte dans VS Code

---

## 🆘 EN CAS DE PROBLÈME

### Problème : Erreur "part of" dans Freezed
**Solution** : Lance `flutter pub run build_runner build --delete-conflicting-outputs`

### Problème : Module Flutter non trouvé par React Native
**Solution** : Vérifie que les chemins dans settings.gradle et Podfile sont corrects

### Problème : Erreur de compilation Android
**Solution** : Nettoie le build : `cd android && ./gradlew clean && cd ..`

---

## 💡 CONSEILS

1. **Lis TOUJOURS les commentaires** dans chaque fichier avant de coder
2. **Suis l'ordre** que je te donne (ne saute pas d'étapes)
3. **Teste régulièrement** (après chaque couche terminée)
4. **Demande-moi** si quelque chose n'est pas clair

---

## ✅ C'EST PARTI !

Tu es maintenant prêt à commencer le développement.

Dis-moi **"Je suis prêt à coder"** et on commence par le SDK Flutter ! 🚀
