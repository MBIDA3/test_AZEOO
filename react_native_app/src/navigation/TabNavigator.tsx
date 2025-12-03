// ============================================================================
// FICHIER : TabNavigator.tsx
// RÔLE : Crée la Tab Bar avec 2 onglets
// ============================================================================
//
// Ce fichier configure :
// - Tab 1 : "Enter ID" → Tab1Screen
// - Tab 2 : "Profile" → Tab2Screen
//
// ============================================================================

import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Tab1Screen from '../screens/Tab1Screen';
import Tab2Screen from '../screens/Tab2Screen';

const Tab = createBottomTabNavigator();

export default function TabNavigator() {
  return (
    <Tab.Navigator>
      <Tab.Screen 
        name="Enter ID" 
        component={Tab1Screen}
        options={{ title: 'Enter User ID' }}
      />
      <Tab.Screen 
        name="Profile" 
        component={Tab2Screen}
        options={{ title: 'User Profile' }}
      />
    </Tab.Navigator>
  );
}
