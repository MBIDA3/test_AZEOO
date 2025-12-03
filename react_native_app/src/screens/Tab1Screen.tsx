// ============================================================================
// FICHIER : Tab1Screen.tsx
// RÔLE : Onglet 1 - Input pour saisir l'User ID
// ============================================================================
//
// Cet écran contient :
// - Un TextInput pour saisir l'ID utilisateur (1 ou 3)
// - Un bouton "Sauvegarder" qui enregistre l'ID dans AsyncStorage
//
// INSTRUCTIONS :
// 1. Utiliser useState pour gérer la valeur du TextInput
// 2. Utiliser AsyncStorage pour sauvegarder l'ID
// 3. Afficher une alerte de confirmation après sauvegarde
//
// ============================================================================

import React, { useState } from 'react';
import { View, TextInput, Button, StyleSheet, Text } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export default function Tab1Screen() {
  const [userId, setUserId] = useState('');
  
  const handleSave = async () => {
    try {
      await AsyncStorage.setItem('userId', userId);
      alert('User ID sauvegardé !');
    } catch (error) {
      alert('Erreur lors de la sauvegarde');
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Entrer un User ID</Text>
      <TextInput
        style={styles.input}
        placeholder="Enter User ID (1 or 3)"
        value={userId}
        onChangeText={setUserId}
        keyboardType="numeric"
      />
      <Button title="Sauvegarder" onPress={handleSave} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    marginBottom: 20,
    borderRadius: 5,
  },
});
