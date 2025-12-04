import React, { useState } from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';

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
      <Text style={styles.text}>User ID: {userId}</Text>
      <Text style={styles.info}>
        Ici s'affichera le SDK Flutter
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f0f0f0',
  },
  text: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  info: {
    fontSize: 14,
    color: '#666',
  },
});