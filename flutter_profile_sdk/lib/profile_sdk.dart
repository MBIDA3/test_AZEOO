library flutter_profile_sdk;

// Exports publics
export 'src/presentation/screens/profile_screen.dart';
export 'src/domain/entities/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/screens/profile_screen.dart';

class ProfileSDK {
  /// Méthode statique pour construire l'écran de profil
  ///
  /// [userId] : L'ID de l'utilisateur dont on veut afficher le profil
  ///
  /// Exemple d'utilisation :
  /// ```dart
  /// ProfileSDK.buildProfileScreen('1');
  /// ```
  static Widget buildProfileScreen(String userId) {
    return ProviderScope(
      child: ProfileScreen(userId: userId),
    );
  }
}
