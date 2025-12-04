// ============================================================================
// TEST : profile_avatar_test.dart
// RÔLE : Tests widget pour ProfileAvatar
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/presentation/widgets/profile_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  group('ProfileAvatar Widget', () {
    testWidgets('should display CircleAvatar', (WidgetTester tester) async {
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
      expect(circleAvatar.radius, equals(60));
    });

    testWidgets('should use CachedNetworkImageProvider', (WidgetTester tester) async {
      // Arrange
      const testUrl = 'https://example.com/avatar.jpg';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileAvatar(avatarUrl: testUrl),
          ),
        ),
      );

      // Assert
      final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circleAvatar.backgroundImage, isA<CachedNetworkImageProvider>());
    });
  });
}

