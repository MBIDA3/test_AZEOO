// ============================================================================
// TESTS : ProfileInfo Widget
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

    testWidgets('should render with bold text style', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'Jane',
              lastName: 'Smith',
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text('Jane Smith'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should have correct font size', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileInfo(
              firstName: 'Test',
              lastName: 'User',
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text('Test User'));
      expect(textWidget.style?.fontSize, 24);
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
  });
}

