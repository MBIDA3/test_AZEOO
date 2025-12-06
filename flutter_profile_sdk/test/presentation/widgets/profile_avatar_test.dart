// ============================================================================
// TESTS : ProfileAvatar Widget
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/presentation/widgets/profile_avatar.dart';

void main() {
  group('ProfileAvatar Widget', () {
    testWidgets('should render CircleAvatar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('should have correct radius', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      // Assert
      final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circleAvatar.radius, 60);
    });
  });
}



