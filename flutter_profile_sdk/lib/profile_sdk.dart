// ============================================================================
// FICHIER : profile_sdk.dart
// RÔLE : Point d'entrée PUBLIC du SDK Flutter
// ============================================================================
//
// Ce fichier contient l'API publique du SDK.
// C'est la SEULE fonction que React Native va appeler.
//
// INSTRUCTIONS :
// 1. Exporter ProfileScreen
// 2. Créer une classe ProfileSDK avec une méthode statique
// 3. Cette méthode retourne un Widget ProfileScreen avec ProviderScope
//
// ============================================================================

library flutter_profile_sdk;

export 'src/presentation/screens/profile_screen.dart';
export 'src/domain/entities/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/screens/profile_screen.dart';

// ============================================================================
// TODO: Définir la classe ProfileSDK ici
// Exemple de structure :
// class ProfileSDK {
//   static Widget buildProfileScreen(String userId) {
//     return ProviderScope(
//       child: ProfileScreen(userId: userId),
//     );
//   }
// }
// ============================================================================
