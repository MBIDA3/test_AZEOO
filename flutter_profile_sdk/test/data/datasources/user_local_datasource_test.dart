// ============================================================================
// TESTS : UserLocalDataSource (Cache)
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_local_datasource.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';

void main() {
  late UserLocalDataSource dataSource;

  setUp(() {
    dataSource = UserLocalDataSource();
  });

  group('UserLocalDataSource', () {
    final tUserModel = UserModel(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      avatar: 'https://example.com/avatar.jpg',
    );

    group('getCachedUser', () {
      test('should return null when cache is empty', () {
        // Act
        final result = dataSource.getCachedUser('1');

        // Assert
        expect(result, isNull);
      });

      test('should return cached user when present', () {
        // Arrange
        dataSource.cacheUser('1', tUserModel);

        // Act
        final result = dataSource.getCachedUser('1');

        // Assert
        expect(result, equals(tUserModel));
      });

      test('should return null for non-existent userId', () {
        // Arrange
        dataSource.cacheUser('1', tUserModel);

        // Act
        final result = dataSource.getCachedUser('2');

        // Assert
        expect(result, isNull);
      });
    });

    group('cacheUser', () {
      test('should store user in cache', () {
        // Act
        dataSource.cacheUser('1', tUserModel);

        // Assert
        expect(dataSource.getCachedUser('1'), equals(tUserModel));
      });

      test('should overwrite existing cached user', () {
        // Arrange
        dataSource.cacheUser('1', tUserModel);
        
        final updatedUser = UserModel(
          id: 1,
          firstName: 'Jane',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar2.jpg',
        );

        // Act
        dataSource.cacheUser('1', updatedUser);

        // Assert
        final result = dataSource.getCachedUser('1');
        expect(result?.firstName, 'Jane');
      });

      test('should cache multiple users', () {
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
          avatar: 'https://example.com/avatar3.jpg',
        );

        // Act
        dataSource.cacheUser('1', user1);
        dataSource.cacheUser('3', user2);

        // Assert
        expect(dataSource.getCachedUser('1')?.firstName, 'John');
        expect(dataSource.getCachedUser('3')?.firstName, 'Jane');
      });
    });

    group('clearCache', () {
      test('should remove all cached users', () {
        // Arrange
        dataSource.cacheUser('1', tUserModel);
        dataSource.cacheUser('3', tUserModel);

        // Act
        dataSource.clearCache();

        // Assert
        expect(dataSource.getCachedUser('1'), isNull);
        expect(dataSource.getCachedUser('3'), isNull);
      });

      test('should work on empty cache', () {
        // Act & Assert - should not throw
        expect(() => dataSource.clearCache(), returnsNormally);
      });
    });
  });
}



