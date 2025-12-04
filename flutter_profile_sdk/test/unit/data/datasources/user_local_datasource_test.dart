// ============================================================================
// TEST : user_local_datasource_test.dart
// RÔLE : Tests unitaires pour le cache local
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_local_datasource.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';

void main() {
  group('UserLocalDataSource', () {
    late UserLocalDataSource dataSource;

    setUp(() {
      dataSource = UserLocalDataSource();
    });

    group('getCachedUser', () {
      test('should return null when cache is empty', () {
        // Act
        final result = dataSource.getCachedUser('1');

        // Assert
        expect(result, isNull);
      });

      test('should return null for non-existent userId', () {
        // Arrange
        final user = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );
        dataSource.cacheUser('1', user);

        // Act
        final result = dataSource.getCachedUser('999');

        // Assert
        expect(result, isNull);
      });

      test('should return cached user when exists', () {
        // Arrange
        final user = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );
        dataSource.cacheUser('1', user);

        // Act
        final result = dataSource.getCachedUser('1');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, equals(1));
        expect(result.firstName, equals('John'));
        expect(result.lastName, equals('Doe'));
      });
    });

    group('cacheUser', () {
      test('should store user in cache', () {
        // Arrange
        final user = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );

        // Act
        dataSource.cacheUser('1', user);

        // Assert
        final cached = dataSource.getCachedUser('1');
        expect(cached, equals(user));
      });

      test('should overwrite existing cached user', () {
        // Arrange
        final user1 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar1.jpg',
        );
        final user2 = UserModel(
          id: 1,
          firstName: 'Jane',
          lastName: 'Smith',
          avatar: 'https://example.com/avatar2.jpg',
        );

        // Act
        dataSource.cacheUser('1', user1);
        dataSource.cacheUser('1', user2);

        // Assert
        final cached = dataSource.getCachedUser('1');
        expect(cached!.firstName, equals('Jane'));
        expect(cached.lastName, equals('Smith'));
      });

      test('should cache multiple users with different ids', () {
        // Arrange
        final user1 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar1.jpg',
        );
        final user2 = UserModel(
          id: 3,
          firstName: 'Jane',
          lastName: 'Smith',
          avatar: 'https://example.com/avatar2.jpg',
        );

        // Act
        dataSource.cacheUser('1', user1);
        dataSource.cacheUser('3', user2);

        // Assert
        expect(dataSource.getCachedUser('1')!.firstName, equals('John'));
        expect(dataSource.getCachedUser('3')!.firstName, equals('Jane'));
      });
    });

    group('clearCache', () {
      test('should clear all cached users', () {
        // Arrange
        final user1 = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar1.jpg',
        );
        final user2 = UserModel(
          id: 3,
          firstName: 'Jane',
          lastName: 'Smith',
          avatar: 'https://example.com/avatar2.jpg',
        );
        dataSource.cacheUser('1', user1);
        dataSource.cacheUser('3', user2);

        // Act
        dataSource.clearCache();

        // Assert
        expect(dataSource.getCachedUser('1'), isNull);
        expect(dataSource.getCachedUser('3'), isNull);
      });

      test('should not throw when clearing empty cache', () {
        // Act & Assert
        expect(() => dataSource.clearCache(), returnsNormally);
      });
    });
  });
}

