// ============================================================================
// TEST : profile_info_test.dart
// RÔLE : Tests widget pour ProfileInfo
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/presentation/widgets/profile_info.dart';

void main() {
  group('ProfileInfo Widget', () {
    testWidgets('should display first name and last name', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'John',
              lastName: 'Doe',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('should display text with correct style', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'John',
              lastName: 'Doe',
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text('John Doe'));
      expect(textWidget.style?.fontSize, equals(24));
      expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should handle long names', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'Jean-Pierre-Marie',
              lastName: 'De La Fontaine-Dubois',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Jean-Pierre-Marie De La Fontaine-Dubois'), findsOneWidget);
    });

    testWidgets('should handle empty names', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: '',
              lastName: '',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(' '), findsOneWidget);
    });

    testWidgets('should be wrapped in Column', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'John',
              lastName: 'Doe',
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Column), findsOneWidget);
    });
  });
}

