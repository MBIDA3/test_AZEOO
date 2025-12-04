// ============================================================================
// FICHIER : profile_sdk.dart
// RÔLE : Point d'entrée public du SDK Flutter
// ============================================================================
//
// Ce fichier expose les APIs publiques du SDK pour :
// 1. Utilisation standalone (avec go_router)
// 2. Intégration dans React Native (via FlutterEngine)
//
// ============================================================================

library flutter_profile_sdk;

// Exports publics - Entités
export 'src/domain/entities/user.dart';

// Exports publics - Écrans
export 'src/presentation/screens/profile_screen.dart';
export 'src/presentation/screens/home_screen.dart';

// Exports publics - Router
export 'src/presentation/router/app_router.dart';

// Exports publics - Providers (pour tests et customisation)
export 'src/presentation/providers/profile_provider.dart';

// Exports publics - Services (pour intégration React Native)
export 'src/presentation/services/method_channel_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/screens/profile_screen.dart';
import 'src/presentation/router/app_router.dart';

/// SDK Flutter pour afficher le profil d'un utilisateur
/// 
/// Exemple d'utilisation standalone :
/// ```dart
/// // Méthode 1 : Widget simple
/// ProfileSDK.buildProfileScreen('1');
/// 
/// // Méthode 2 : Application complète avec navigation
/// ProfileSDK.buildApp();
/// ```
/// 
/// Exemple d'utilisation dans React Native :
/// ```dart
/// // Le SDK est appelé via FlutterEngine avec un userId
/// ProfileSDK.buildProfileScreen(userId);
/// ```
class ProfileSDK {
  /// Construit l'écran de profil pour un userId donné
  /// 
  /// [userId] : L'ID de l'utilisateur dont on veut afficher le profil
  /// 
  /// Retourne un Widget encapsulé dans un ProviderScope
  static Widget buildProfileScreen(String userId) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: ProfileScreen(userId: userId),
      ),
    );
  }

  /// Construit l'application complète avec navigation go_router
  /// 
  /// Utilise le router configuré avec :
  /// - `/` : Écran d'accueil
  /// - `/profile/:userId` : Écran de profil
  static Widget buildApp() {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SDK Flutter - AZEOO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }

  /// Retourne le GoRouter configuré pour une intégration custom
  static get router => AppRouter.router;
}
