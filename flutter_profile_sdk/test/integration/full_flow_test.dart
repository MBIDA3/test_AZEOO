// ============================================================================
// TESTS D'INTÉGRATION : Flux complet
// ============================================================================
//
// Ces tests vérifient le flux complet de l'application :
// 1. Affichage de l'écran d'accueil
// 2. Saisie de l'userId
// 3. Navigation vers le profil
// 4. Affichage du profil
// 5. Retour à l'accueil
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_profile_sdk/src/presentation/router/app_router.dart';
import 'package:flutter_profile_sdk/src/presentation/screens/home_screen.dart';
import 'package:flutter_profile_sdk/src/presentation/screens/profile_screen.dart';

void main() {
  group('Integration Tests - Full Flow', () {
    testWidgets('Complete user flow: Home -> Enter ID -> Profile -> Back', 
        (WidgetTester tester) async {
      // STEP 1: Launch app
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert: HomeScreen is displayed
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('SDK Flutter - AZEOO'), findsOneWidget);

      // STEP 2: Enter userId
      await tester.enterText(find.byType(TextField), '1');
      await tester.pump();

      // Assert: TextField has new value
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, '1');

      // STEP 3: Tap on "Afficher le Profil" button
      await tester.tap(find.text('Afficher le Profil'));
      await tester.pumpAndSettle();

      // Assert: ProfileScreen is displayed
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Profil Utilisateur'), findsOneWidget);

      // STEP 4: Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Assert: Back to HomeScreen
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Profile screen should show loading state initially', 
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.text('Afficher le Profil'));
      await tester.pump(); // Don't settle to catch loading state

      // Assert
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Profile screen should have refresh button', 
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.text('Afficher le Profil'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Should navigate with different userIds', 
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Test with userId = 3
      await tester.enterText(find.byType(TextField), '3');
      await tester.tap(find.text('Afficher le Profil'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('User ID: 3'), findsOneWidget);
    });
  });
}

