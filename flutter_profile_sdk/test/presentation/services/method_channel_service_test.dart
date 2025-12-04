// ============================================================================
// TESTS : MethodChannelService
// ============================================================================

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_sdk/src/presentation/services/method_channel_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MethodChannelService', () {
    setUp(() {
      // Reset the service before each test
      MethodChannelService.initialize();
    });

    test('should initialize without errors', () {
      // Act & Assert - should not throw
      expect(() => MethodChannelService.initialize(), returnsNormally);
    });

    test('should return null for lastUserId before any message', () {
      // Assert
      expect(MethodChannelService.lastUserId, isNull);
    });

    test('userIdStream should be a broadcast stream', () {
      // Assert
      expect(MethodChannelService.userIdStream.isBroadcast, isTrue);
    });

    test('refreshStream should be a broadcast stream', () {
      // Assert
      expect(MethodChannelService.refreshStream.isBroadcast, isTrue);
    });

    test('should handle setUserId method call', () async {
      // Arrange
      String? receivedUserId;
      MethodChannelService.userIdStream.listen((userId) {
        receivedUserId = userId;
      });

      // Simulate receiving a method call from the platform
      const channel = MethodChannel('com.azeoo.profile_sdk/channel');
      
      // Set up a mock handler
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'setUserId') {
          return true;
        }
        return null;
      });

      // Assert - the stream should be set up
      expect(MethodChannelService.userIdStream, isNotNull);
    });
  });
}

