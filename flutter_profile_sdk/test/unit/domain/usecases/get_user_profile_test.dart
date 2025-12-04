// ============================================================================
// TEST : get_user_profile_test.dart
// RÔLE : Tests unitaires pour le UseCase GetUserProfile
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/domain/entities/user.dart';
import 'package:flutter_profile_sdk/src/domain/repositories/user_repository.dart';
import 'package:flutter_profile_sdk/src/domain/usecases/get_user_profile.dart';

// Mock du Repository
class MockUserRepository implements UserRepository {
  User? userToReturn;
  Exception? exceptionToThrow;
  String? lastCalledUserId;

  @override
  Future<User> getUserProfile(String userId) async {
    lastCalledUserId = userId;
    
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    
    return userToReturn ?? User(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      avatarUrl: 'https://example.com/avatar.jpg',
    );
  }
}

void main() {
  group('GetUserProfile UseCase', () {
    late GetUserProfile useCase;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      useCase = GetUserProfile(mockRepository);
    });

    test('should call repository with correct userId', () async {
      // Arrange
      const userId = '1';

      // Act
      await useCase.call(userId);

      // Assert
      expect(mockRepository.lastCalledUserId, equals(userId));
    });

    test('should return User when repository returns successfully', () async {
      // Arrange
      const userId = '1';
      final expectedUser = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
      );
      mockRepository.userToReturn = expectedUser;

      // Act
      final result = await useCase.call(userId);

      // Assert
      expect(result, equals(expectedUser));
      expect(result.firstName, equals('John'));
      expect(result.lastName, equals('Doe'));
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const userId = '1';
      mockRepository.exceptionToThrow = Exception('Network error');

      // Act & Assert
      expect(
        () => useCase.call(userId),
        throwsA(isA<Exception>()),
      );
    });

    test('should work with different userIds', () async {
      // Arrange & Act
      await useCase.call('1');
      expect(mockRepository.lastCalledUserId, equals('1'));

      await useCase.call('3');
      expect(mockRepository.lastCalledUserId, equals('3'));

      await useCase.call('999');
      expect(mockRepository.lastCalledUserId, equals('999'));
    });
  });
}

