// ============================================================================
// TEST : user_repository_impl_test.dart
// RÔLE : Tests unitaires pour l'implémentation du Repository
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_local_datasource.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_remote_datasource.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';
import 'package:flutter_profile_sdk/src/data/repositories/user_repository_impl.dart';
import 'package:dio/dio.dart';

// Mock du RemoteDataSource
class MockUserRemoteDataSource implements UserRemoteDataSource {
  @override
  final Dio dio = Dio();
  
  UserModel? userToReturn;
  Exception? exceptionToThrow;
  int callCount = 0;

  @override
  Future<UserModel> getUserById(String userId) async {
    callCount++;
    
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    
    return userToReturn ?? UserModel(
      id: int.parse(userId),
      firstName: 'John',
      lastName: 'Doe',
      avatar: 'https://example.com/avatar.jpg',
    );
  }
}

void main() {
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl repository;
    late MockUserRemoteDataSource mockRemoteDataSource;
    late UserLocalDataSource localDataSource;

    setUp(() {
      mockRemoteDataSource = MockUserRemoteDataSource();
      localDataSource = UserLocalDataSource();
      repository = UserRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: localDataSource,
      );
    });

    group('getUserProfile', () {
      test('should fetch from API when cache is empty', () async {
        // Arrange
        const userId = '1';
        mockRemoteDataSource.userToReturn = UserModel(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'https://example.com/avatar.jpg',
        );

        // Act
        final result = await repository.getUserProfile(userId);

        // Assert
        expect(result.firstName, equals('John'));
        expect(mockRemoteDataSource.callCount, equals(1));
      });

      test('should return cached user when available', () async {
        // Arrange
        const userId = '1';
        final cachedUser = UserModel(
          id: 1,
          firstName: 'Cached',
          lastName: 'User',
          avatar: 'https://example.com/cached.jpg',
        );
        localDataSource.cacheUser(userId, cachedUser);

        // Act
        final result = await repository.getUserProfile(userId);

        // Assert
        expect(result.firstName, equals('Cached'));
        expect(mockRemoteDataSource.callCount, equals(0)); // API not called
      });

      test('should cache user after fetching from API', () async {
        // Arrange
        const userId = '1';
        mockRemoteDataSource.userToReturn = UserModel(
          id: 1,
          firstName: 'Fresh',
          lastName: 'Data',
          avatar: 'https://example.com/fresh.jpg',
        );

        // Act
        await repository.getUserProfile(userId);

        // Assert
        final cached = localDataSource.getCachedUser(userId);
        expect(cached, isNotNull);
        expect(cached!.firstName, equals('Fresh'));
      });

      test('should return User entity (not UserModel)', () async {
        // Arrange
        const userId = '1';

        // Act
        final result = await repository.getUserProfile(userId);

        // Assert
        expect(result.avatarUrl, isNotNull); // User has avatarUrl, UserModel has avatar
      });

      test('should throw exception when API fails and no cache', () async {
        // Arrange
        const userId = '1';
        mockRemoteDataSource.exceptionToThrow = Exception('Network error');

        // Act & Assert
        expect(
          () => repository.getUserProfile(userId),
          throwsA(isA<Exception>()),
        );
      });

      test('should work with multiple different userIds', () async {
        // Arrange
        mockRemoteDataSource.userToReturn = UserModel(
          id: 1,
          firstName: 'User1',
          lastName: 'Test',
          avatar: 'https://example.com/1.jpg',
        );

        // Act
        await repository.getUserProfile('1');
        
        mockRemoteDataSource.userToReturn = UserModel(
          id: 3,
          firstName: 'User3',
          lastName: 'Test',
          avatar: 'https://example.com/3.jpg',
        );
        await repository.getUserProfile('3');

        // Assert
        expect(localDataSource.getCachedUser('1')!.firstName, equals('User1'));
        expect(localDataSource.getCachedUser('3')!.firstName, equals('User3'));
        expect(mockRemoteDataSource.callCount, equals(2));
      });
    });
  });
}

