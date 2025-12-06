// ============================================================================
// TESTS : ProfileSDK (Point d'entrée public)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_profile_sdk/profile_sdk.dart';

void main() {
  group('ProfileSDK', () {
    group('buildProfileScreen', () {
      testWidgets('should return a valid Widget', (WidgetTester tester) async {
        // Arrange & Act
        final widget = ProfileSDK.buildProfileScreen('1');

        // Assert
        expect(widget, isA<Widget>());
      });

      testWidgets('should wrap ProfileScreen in ProviderScope', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(ProfileSDK.buildProfileScreen('1'));

        // Assert
        expect(find.byType(ProviderScope), findsOneWidget);
      });

      testWidgets('should display loading initially', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(ProfileSDK.buildProfileScreen('1'));

        // Assert - should show loading state
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('buildApp', () {
      testWidgets('should return a valid Widget', (WidgetTester tester) async {
        // Arrange & Act
        final widget = ProfileSDK.buildApp();

        // Assert
        expect(widget, isA<Widget>());
      });

      testWidgets('should wrap app in ProviderScope', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(ProfileSDK.buildApp());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(ProviderScope), findsOneWidget);
      });

      testWidgets('should use MaterialApp.router', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(ProfileSDK.buildApp());
        await tester.pumpAndSettle();

        // Assert - should show HomeScreen (initial route)
        expect(find.text('SDK Flutter - AZEOO'), findsOneWidget);
      });
    });

    group('router', () {
      test('should return GoRouter instance', () {
        // Act
        final router = ProfileSDK.router;

        // Assert
        expect(router, isNotNull);
      });
    });
  });
}



