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
        options={{ title: 'Entrer User ID' }}
      />
      <Tab.Screen 
        name="Profile" 
        component={Tab2Screen}
        options={{ title: 'Profil Utilisateur' }}
      />
    </Tab.Navigator>
  );
}