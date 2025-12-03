// ============================================================================
// FICHIER : user_local_datasource.dart
// RÔLE : Gère le cache local (en mémoire)
// COUCHE : Data Layer
// ============================================================================
//
// Ce fichier contient la classe UserLocalDataSource qui :
// - Stocke les profils utilisateurs en cache (Map en mémoire)
// - Permet de récupérer un profil depuis le cache
// - Permet d'ajouter un profil au cache
//
// INSTRUCTIONS :
// 1. Créer un Map privé pour stocker le cache
// 2. Méthode getCachedUser(String userId) → retourne UserModel? (peut être null)
// 3. Méthode cacheUser(String userId, UserModel user) → stocke dans le cache
//
// ============================================================================

import '../models/user_model.dart';

// ============================================================================
// TODO: Définir la classe UserLocalDataSource ici
// Exemple de structure :
// class UserLocalDataSource {
//   final Map<String, UserModel> _cache = {};
//   
//   UserModel? getCachedUser(String userId) {
//     return _cache[userId];
//   }
//   
//   void cacheUser(String userId, UserModel user) {
//     _cache[userId] = user;
//   }
// }
// ============================================================================
