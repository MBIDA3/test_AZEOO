// ============================================================================
// FICHIER : app_router.dart
// RÔLE : Configuration de la navigation avec go_router
// COUCHE : Presentation Layer
// ============================================================================
//
// POURQUOI go_router ?
// - Navigation déclarative et type-safe
// - Deep linking natif supporté
// - Recommandé par Google/Flutter team
// - Redirections et guards faciles à implémenter
// - Scalable pour applications complexes
// - PAS Navigator.push() qui est impératif et moins maintenable
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';

/// Configuration du router de l'application
/// 
/// Routes disponibles :
/// - `/` : Écran d'accueil avec input userId
/// - `/profile/:userId` : Écran de profil avec userId en paramètre
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile/:userId',
        name: 'profile',
        builder: (context, state) {
          final userId = state.pathParameters['userId'] ?? '1';
          return ProfileScreen(userId: userId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 60, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'Page non trouvée',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Route: ${state.uri.path}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Extension pour faciliter la navigation
extension GoRouterExtension on BuildContext {
  /// Naviguer vers le profil d'un utilisateur
  void goToProfile(String userId) {
    go('/profile/$userId');
  }
  
  /// Retourner à l'accueil
  void goToHome() {
    go('/');
  }
}


