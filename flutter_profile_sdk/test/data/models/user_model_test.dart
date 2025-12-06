// ============================================================================
// TESTS : UserModel
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';
import 'package:flutter_profile_sdk/src/domain/entities/user.dart';

void main() {
  group('UserModel', () {
    const tUserModelJson = {
      'id': 1,
      'first_name': 'John',
      'last_name': 'Doe',
      'avatar': 'https://example.com/avatar.jpg',
    };

    final tUserModel = UserModel(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      avatar: 'https://example.com/avatar.jpg',
    );

    test('should create UserModel from JSON', () {
      // Act
      final result = UserModel.fromJson(tUserModelJson);

      // Assert
      expect(result.id, 1);
      expect(result.firstName, 'John');
      expect(result.lastName, 'Doe');
      expect(result.avatar, 'https://example.com/avatar.jpg');
    });

    test('should convert UserModel to JSON', () {
      // Act
      final result = tUserModel.toJson();

      // Assert
      expect(result['id'], 1);
      expect(result['first_name'], 'John');
      expect(result['last_name'], 'Doe');
      expect(result['avatar'], 'https://example.com/avatar.jpg');
    });

    test('should convert UserModel to User Entity', () {
      // Act
      final result = tUserModel.toEntity();

      // Assert
      expect(result, isA<User>());
      expect(result.id, 1);
      expect(result.firstName, 'John');
      expect(result.lastName, 'Doe');
      expect(result.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should handle JSON with snake_case keys', () {
      // Arrange
      const json = {
        'id': 2,
        'first_name': 'Jane',
        'last_name': 'Smith',
        'avatar': 'https://example.com/jane.jpg',
      };

      // Act
      final result = UserModel.fromJson(json);

      // Assert
      expect(result.firstName, 'Jane');
      expect(result.lastName, 'Smith');
    });

    test('should support equality comparison', () {
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
  });
}



