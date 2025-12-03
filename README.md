# Test Technique AZEOO - Flutter SDK + React Native

**Candidat :** Christian  
**Date limite :** Jeudi 4 décembre 2025  
**Objectif :** Créer un SDK Flutter et l'intégrer dans une app React Native

---

## 📁 Structure du Projet

Ce projet contient **2 projets distincts** :

### 1. flutter_profile_sdk/
SDK Flutter qui affiche un profil utilisateur (Clean Architecture)

### 2. react_native_app/
Application React Native avec 2 onglets qui utilise le SDK Flutter

---

## 🎯 Fonctionnalités

### Onglet 1 : Enter User ID
- Input pour saisir un ID utilisateur (1 ou 3)
- Bouton "Sauvegarder" qui stocke l'ID dans AsyncStorage

### Onglet 2 : User Profile
- Affiche le SDK Flutter
- Le SDK charge et affiche le profil correspondant à l'ID
- Affiche : Photo, Prénom, Nom

---

## 🏗️ Architecture

### SDK Flutter (Clean Architecture)
```
lib/
├── data/          # Appels API, cache, models
├── domain/        # Logique métier, entities, use cases
└── presentation/  # UI, state management (Riverpod)
```

### App React Native
```
src/
├── components/    # FlutterProfileView
├── screens/       # Tab1Screen, Tab2Screen
└── navigation/    # TabNavigator
```

---

## 🔧 Stack Technique

### SDK Flutter
- **State Management** : Riverpod
- **Navigation** : go_router
- **API** : Dio
- **Sérialisation** : Freezed + json_serializable
- **Cache** : Map en mémoire + flutter_cache_manager

### App React Native
- **Navigation** : React Navigation (Bottom Tabs)
- **Storage** : AsyncStorage
- **Bridge** : Native Modules (Android/iOS)

---

## 📋 Installation

### 1. SDK Flutter
```bash
cd flutter_profile_sdk
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. App React Native
```bash
cd react_native_app
npm install
# iOS seulement :
cd ios && pod install && cd ..
```

---

## 🚀 Lancement

### Android
```bash
cd react_native_app
npm run android
```

### iOS (macOS seulement)
```bash
cd react_native_app
npm run ios
```

---

## 🌉 Le Bridge (React Native ↔ Flutter)

Le bridge permet à React Native d'afficher le module Flutter et de lui passer des données.

### Android
- `FlutterViewManager.java` : Crée et gère la FlutterView
- `settings.gradle` : Référence au module Flutter

### iOS
- `FlutterViewManager.h/m` : Crée et gère la FlutterView
- `Podfile` : Référence au module Flutter

---

## 📖 API Utilisée

**URL** : `https://api.azeoo.dev/v1/users/me`

**Headers obligatoires** :
- `Accept-Language: fr-FR`
- `X-User-Id: [userId]`
- `Authorization: Bearer api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20`

---

## ✅ Contraintes Respectées

✅ **State Management avancé** : Riverpod (pas de setState)  
✅ **Navigation avancée** : go_router (pas de Navigator classique)  
✅ **Architecture modulaire** : Clean Architecture (3 couches)  
✅ **Gestion d'erreurs** : Try/catch + UI d'erreur  
✅ **Cache minimal** : Map en mémoire  

---

## 📝 Choix Techniques Expliqués

### Pourquoi Riverpod ?
- Scalable et performant
- Rebuild uniquement ce qui change
- Séparation logique/UI

### Pourquoi Clean Architecture ?
- Maintenable sur le long terme
- Chaque couche a une responsabilité unique
- Facile à tester

### Pourquoi pas setState ?
- Code mélangé (UI + logique)
- Reconstruit tout le widget tree
- Pas scalable pour une grande app

---

## 👨‍💻 Auteur

**Christian**  
Test technique pour le poste de Développeur Flutter (Alternance) chez AZEOO

---

## 📅 Date de Réalisation

Début : 3 décembre 2025  
Deadline : 4 décembre 2025 (16h de travail)

---

## 📧 Contact

En cas de question : [Voir le mail reçu d'AZEOO]
