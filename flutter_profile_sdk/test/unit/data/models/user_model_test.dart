// ============================================================================
// TEST : user_model_test.dart
// RÔLE : Tests unitaires pour le modèle UserModel et sa conversion
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    group('fromJson', () {
      test('should create UserModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'first_name': 'John',
          'last_name': 'Doe',
          'avatar': 'https://example.com/avatar.jpg',
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.firstName, equals('John'));
        expect(result.lastName, equals('Doe'));
        expect(result.avatar, equals('https://example.com/avatar.jpg'));
      });

      test('should handle snake_case to camelCase conversion', () {
        // Arrange
        final json = {
          'id': 3,
          'first_name': 'Jane',
          'last_name': 'Smith',
          'avatar': 'https://example.com/jane.jpg',
        };

        // Act
        final result = UserModel.fromJson(json);

        // Assert
        expect(result.firstName, equals('Jane'));
        expect(result.lastName, equals('Smith'));
      });
    });

    group('toEntity', () {
      test('should convert UserModel to User entity', () {
        // Arrange
        final model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity.id, equals(1));
        expect(entity.firstName, equals('John'));
        expect(entity.lastName, equals('Doe'));
        expect(entity.avatarUrl, equals('https://example.com/avatar.jpg'));
      });

      test('should map avatar to avatarUrl correctly', () {
        // Arrange
        final model = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://api.azeoo.dev/images/profile.png',
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity.avatarUrl, equals('https://api.azeoo.dev/images/profile.png'));
      });
    });

    group('equality', () {
      test('two UserModels with same values should be equal', () {
        // Arrange
        final model1 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );
        final model2 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );

        // Assert
        expect(model1, equals(model2));
      });

      test('two UserModels with different values should not be equal', () {
        // Arrange
        final model1 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );
        final model2 = UserModel(
          id: 2,
          firstName: 'Jane',
          lastName: 'Smith',
          avatar: 'https://example.com/avatar2.jpg',
        );

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}

