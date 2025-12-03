// ============================================================================
// FICHIER : Tab2Screen.tsx
// RÔLE : Onglet 2 - Affiche le SDK Flutter
// ============================================================================
//
// Cet écran :
// - Récupère l'User ID depuis AsyncStorage
// - Affiche le composant FlutterProfileView avec cet ID
// - Se met à jour quand l'utilisateur change d'onglet
//
// INSTRUCTIONS :
// 1. Utiliser useState pour stocker l'userId
// 2. Utiliser useEffect pour récupérer l'ID depuis AsyncStorage
// 3. Passer l'userId au composant FlutterProfileView
//
// ============================================================================

import React, { useState, useEffect } from 'react';
import { View, StyleSheet } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import FlutterProfileView from '../components/FlutterProfileView';

export default function Tab2Screen() {
  const [userId, setUserId] = useState('1'); // Valeur par défaut
  
  // Recharger l'ID à chaque fois que l'onglet devient actif
  useFocusEffect(
    React.useCallback(() => {
      AsyncStorage.getItem('userId').then(id => {
        if (id) setUserId(id);
      });
    }, [])
  );
  
  return (
    <View style={styles.container}>
      <FlutterProfileView userId={userId} style={styles.flutterView} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  flutterView: {
    flex: 1,
  },
});
