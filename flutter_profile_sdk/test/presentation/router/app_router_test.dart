// ============================================================================
// TESTS : AppRouter (go_router)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_profile_sdk/src/presentation/router/app_router.dart';
import 'package:flutter_profile_sdk/src/presentation/screens/home_screen.dart';
import 'package:flutter_profile_sdk/src/presentation/screens/profile_screen.dart';

void main() {
  group('AppRouter', () {
    testWidgets('should navigate to HomeScreen at root path', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('should display profile route with userId parameter', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Navigate to profile
      // Find the text field and enter a userId
      await tester.enterText(find.byType(TextField), '1');
      await tester.tap(find.text('Afficher le Profil'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    test('router should have correct initial location', () {
      // Assert
      expect(AppRouter.router.routerDelegate.currentConfiguration.uri.path, '/');
    });

    test('router should have correct routes configured', () {
      // Assert
      final routes = AppRouter.router.configuration.routes;
      expect(routes.length, 2); // home and profile routes
    });
  });

  group('GoRouterExtension', () {
    testWidgets('goToProfile should navigate to profile', (WidgetTester tester) async {
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
      final context = tester.element(find.byType(HomeScreen));
      context.goToProfile('1');
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('goToHome should navigate to home', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile first
      final context = tester.element(find.byType(HomeScreen));
      context.goToProfile('1');
      await tester.pumpAndSettle();

      // Act - Go back home
      final profileContext = tester.element(find.byType(ProfileScreen));
      profileContext.goToHome();
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}



