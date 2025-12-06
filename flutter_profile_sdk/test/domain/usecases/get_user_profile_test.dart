// ============================================================================
// TESTS : GetUserProfile UseCase
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/domain/entities/user.dart';
import 'package:flutter_profile_sdk/src/domain/repositories/user_repository.dart';
import 'package:flutter_profile_sdk/src/domain/usecases/get_user_profile.dart';

// Mock Repository
class MockUserRepository implements UserRepository {
  final User? userToReturn;
  final Exception? exceptionToThrow;
  String? lastCalledUserId;

  MockUserRepository({this.userToReturn, this.exceptionToThrow});

  @override
  Future<User> getUserProfile(String userId) async {
    lastCalledUserId = userId;
    
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
  group('GetUserProfile UseCase', () {
    test('should return User when repository returns data', () async {
      // Arrange
      final expectedUser = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );
      
      final mockRepository = MockUserRepository(userToReturn: expectedUser);
      final useCase = GetUserProfile(mockRepository);

      // Act
      final result = await useCase.call('1');

      // Assert
      expect(result, equals(expectedUser));
      expect(mockRepository.lastCalledUserId, '1');
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      final mockRepository = MockUserRepository(
        exceptionToThrow: Exception('Network error'),
      );
      final useCase = GetUserProfile(mockRepository);

      // Act & Assert
      expect(
        () => useCase.call('1'),
        throwsException,
      );
    });

    test('should call repository with correct userId', () async {
      // Arrange
      final expectedUser = User(
        id: 3,
        firstName: 'Jane',
        lastName: 'Smith',
        avatarUrl: 'https://example.com/avatar3.jpg',
      );
      
      final mockRepository = MockUserRepository(userToReturn: expectedUser);
      final useCase = GetUserProfile(mockRepository);

      // Act
      await useCase.call('3');

      // Assert
      expect(mockRepository.lastCalledUserId, '3');
    });
  });
}



