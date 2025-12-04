// ============================================================================
// FICHIER : method_channel_service.dart
// RÔLE : Gère la communication avec React Native via MethodChannel
// ============================================================================
//
// Ce service :
// - Écoute les appels depuis React Native
// - Met à jour l'userId quand React Native l'envoie
// - Permet de rafraîchir le profil sur demande
//
// Canal de communication : com.azeoo.profile_sdk/channel
//
// ============================================================================

import 'dart:async';
import 'package:flutter/services.dart';

/// Service pour la communication avec React Native
class MethodChannelService {
  static const _channel = MethodChannel('com.azeoo.profile_sdk/channel');
  
  // StreamController pour notifier les changements d'userId
  static final _userIdController = StreamController<String>.broadcast();
  
  // StreamController pour les demandes de rafraîchissement
  static final _refreshController = StreamController<void>.broadcast();
  
  /// Stream des changements d'userId
  static Stream<String> get userIdStream => _userIdController.stream;
  
  /// Stream des demandes de rafraîchissement
  static Stream<void> get refreshStream => _refreshController.stream;
  
  /// Dernier userId reçu
  static String? _lastUserId;
  static String? get lastUserId => _lastUserId;
  
  /// Initialise le MethodChannel et écoute les appels
  static void initialize() {
    _channel.setMethodCallHandler(_handleMethodCall);
    print('🔗 MethodChannel initialisé');
  }
  
  /// Gère les appels reçus de React Native
  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'setUserId':
        final userId = call.arguments as String;
        _lastUserId = userId;
        _userIdController.add(userId);
        print('📱 userId reçu de RN: $userId');
        return true;
        
      case 'refresh':
        _refreshController.add(null);
        print('🔄 Demande de rafraîchissement reçue');
        return true;
        
      default:
        throw PlatformException(
          code: 'NOT_IMPLEMENTED',
          message: 'Méthode ${call.method} non implémentée',
        );
    }
  }
  
  /// Envoie un message à React Native
  static Future<void> sendToReactNative(String method, dynamic arguments) async {
    try {
      await _channel.invokeMethod(method, arguments);
    } on PlatformException catch (e) {
      print('❌ Erreur MethodChannel: ${e.message}');
    }
  }
  
  /// Notifie React Native que le profil a été chargé
  static Future<void> notifyProfileLoaded(String userId) async {
    await sendToReactNative('onProfileLoaded', {
      'userId': userId,
      'success': true,
    });
  }
  
  /// Notifie React Native d'une erreur
  static Future<void> notifyError(String message) async {
    await sendToReactNative('onError', {
      'message': message,
    });
  }
  
  /// Ferme les streams
  static void dispose() {
    _userIdController.close();
    _refreshController.close();
  }
}

