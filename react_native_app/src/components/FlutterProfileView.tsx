// ============================================================================
// FICHIER : FlutterProfileView.tsx
// RÔLE : Composant React Native qui affiche le module Flutter
// ============================================================================
//
// Ce composant fait le lien avec le code natif (Bridge).
// Il utilise requireNativeComponent pour charger la Flutter View.
//
// ============================================================================

import { requireNativeComponent, ViewStyle } from 'react-native';

interface FlutterProfileViewProps {
  userId: string;
  style?: ViewStyle;
}

// Ce composant est implémenté dans le code natif (Android/iOS)
export default requireNativeComponent<FlutterProfileViewProps>('FlutterProfileView');
