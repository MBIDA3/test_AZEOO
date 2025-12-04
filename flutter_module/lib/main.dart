// ============================================================================
// FICHIER : main.dart
// RÔLE : Point d'entrée de l'application de test du SDK
// ============================================================================
//
// Ce fichier démontre l'utilisation du SDK Flutter avec go_router.
// Il peut être lancé en standalone pour tester le SDK.
//
// Deux modes de fonctionnement :
// 1. Standalone : Navigation complète avec go_router
// 2. Intégré (React Native) : Écoute les MethodChannel
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/router/app_router.dart';
import 'src/presentation/services/method_channel_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser le MethodChannel pour la communication avec React Native
  MethodChannelService.initialize();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SDK Flutter - AZEOO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Utilisation de go_router pour la navigation
      routerConfig: AppRouter.router,
    );
  }
}
