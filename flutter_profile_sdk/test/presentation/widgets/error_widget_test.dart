// ============================================================================
// TESTS : ErrorWidget
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/presentation/widgets/error_widget.dart' as custom;

void main() {
  group('ErrorWidget', () {
    testWidgets('should display error message', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Test error message',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test error message'), findsOneWidget);
    });

    testWidgets('should display error icon', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Error',
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should display error title', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Error',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Oups ! Une erreur est survenue'), findsOneWidget);
    });

    testWidgets('should display retry button when onRetry is provided', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Error',
              onRetry: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Réessayer'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should not display retry button when onRetry is null', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Error',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Réessayer'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should call onRetry when retry button is pressed', (WidgetTester tester) async {
      // Arrange
      bool retryCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: custom.ErrorWidget(
              message: 'Error',
              onRetry: () {
                retryCalled = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Réessayer'));
      await tester.pump();

      // Assert
      expect(retryCalled, true);
    });
  });
}



