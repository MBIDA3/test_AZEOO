// ============================================================================
// TESTS : UserRepositoryImpl
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_local_datasource.dart';
import 'package:flutter_profile_sdk/src/data/datasources/user_remote_datasource.dart';
import 'package:flutter_profile_sdk/src/data/models/user_model.dart';
import 'package:flutter_profile_sdk/src/data/repositories/user_repository_impl.dart';
import 'package:flutter_profile_sdk/src/domain/entities/user.dart';
import 'package:dio/dio.dart';

// Mock Remote DataSource
class MockUserRemoteDataSource extends UserRemoteDataSource {
  final UserModel? userToReturn;
  final Exception? exceptionToThrow;
  int callCount = 0;

  MockUserRemoteDataSource({
    this.userToReturn,
    this.exceptionToThrow,
  }) : super(Dio());

  @override
  Future<UserModel> getUserById(String userId) async {
    callCount++;
    
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    
    if (userToReturn != null) {
      return userToReturn!;
    }
    
    throw Exception('User not found');
  }
}

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserLocalDataSource localDataSource;

  final tUserModel = UserModel(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    avatar: 'https://example.com/avatar.jpg',
  );

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource(userToReturn: tUserModel);
    localDataSource = UserLocalDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: localDataSource,
    );
  });

  group('UserRepositoryImpl', () {
    group('getUserProfile', () {
      test('should return User from remote when cache is empty', () async {
        // Act
        final result = await repository.getUserProfile('1');

        // Assert
        expect(result, isA<User>());
        expect(result.firstName, 'John');
        expect(mockRemoteDataSource.callCount, 1);
      });

      test('should cache user after fetching from remote', () async {
        // Act
        await repository.getUserProfile('1');

        // Assert
        final cachedUser = localDataSource.getCachedUser('1');
        expect(cachedUser, isNotNull);
        expect(cachedUser?.firstName, 'John');
      });

      test('should return cached user on second call', () async {
        // Arrange - First call to populate cache
        await repository.getUserProfile('1');
        mockRemoteDataSource.callCount = 0; // Reset counter

        // Act - Second call should use cache
        final result = await repository.getUserProfile('1');

        // Assert
        expect(result.firstName, 'John');
        expect(mockRemoteDataSource.callCount, 0); // Should not call remote
      });

      test('should throw exception when remote fails and cache is empty', () async {
        // Arrange
        final failingRemote = MockUserRemoteDataSource(
          exceptionToThrow: Exception('Network error'),
        );
        final repo = UserRepositoryImpl(
          remoteDataSource: failingRemote,
          localDataSource: localDataSource,
        );

        // Act & Assert
        expect(
          () => repo.getUserProfile('1'),
          throwsException,
        );
      });

      test('should convert UserModel to User Entity', () async {
        // Act
        final result = await repository.getUserProfile('1');

        // Assert
        expect(result, isA<User>());
        expect(result.id, 1);
        expect(result.firstName, 'John');
        expect(result.lastName, 'Doe');
        expect(result.avatarUrl, 'https://example.com/avatar.jpg');
      });
    });
  });
}



