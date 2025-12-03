// ============================================================================
// FICHIER : App.tsx
// RÔLE : Point d'entrée de l'application React Native
// ============================================================================

import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import TabNavigator from './src/navigation/TabNavigator';

export default function App() {
  return (
    <NavigationContainer>
      <TabNavigator />
    </NavigationContainer>
  );
}
