# React Native App - Test AZEOO

## Description
Application React Native avec 2 onglets :
- **Onglet 1** : Input pour saisir l'User ID
- **Onglet 2** : Affiche le SDK Flutter avec le profil utilisateur

## Installation

### 1. Installer les dépendances
```bash
npm install
# ou
yarn install
```

### 2. Installer les pods iOS (si macOS)
```bash
cd ios && pod install && cd ..
```

### 3. Configurer le lien vers le SDK Flutter
Voir les fichiers :
- `android/settings.gradle`
- `ios/Podfile`

## Lancement

### Android
```bash
npm run android
```

### iOS
```bash
npm run ios
```

## Structure du projet
```
src/
├── components/
│   └── FlutterProfileView.tsx  # Composant qui affiche Flutter
├── screens/
│   ├── Tab1Screen.tsx          # Onglet 1 : Input User ID
│   └── Tab2Screen.tsx          # Onglet 2 : Profil Flutter
├── navigation/
│   └── TabNavigator.tsx        # Tab Bar
└── App.tsx                     # Point d'entrée
```

## Bridge React Native ↔ Flutter

### Android
Voir : `android/app/src/main/java/com/reactnativeapp/FlutterViewManager.java`

### iOS
Voir : `ios/reactnativeapp/FlutterViewManager.h/m`

## Auteur
Christian - Test technique AZEOO
