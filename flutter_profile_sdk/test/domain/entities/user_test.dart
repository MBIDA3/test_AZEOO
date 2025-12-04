// ============================================================================
// TESTS : User Entity
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    test('should create a User with all required fields', () {
      // Arrange & Act
      final user = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      // Assert
      expect(user.id, 1);
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should support equality comparison', () {
      // Arrange
      final user1 = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );
      
      final user2 = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      // Assert
      expect(user1, equals(user2));
    });

    test('should return different hash codes for different users', () {
      // Arrange
      final user1 = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );
      
      final user2 = User(
        id: 2,
        firstName: 'Jane',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar2.jpg',
      );

      // Assert
      expect(user1.hashCode, isNot(equals(user2.hashCode)));
    });

    test('should support copyWith', () {
      // Arrange
      final user = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      // Act
      final updatedUser = user.copyWith(firstName: 'Jane');

      // Assert
      expect(updatedUser.id, 1);
      expect(updatedUser.firstName, 'Jane');
      expect(updatedUser.lastName, 'Doe');
    });
  });
}

