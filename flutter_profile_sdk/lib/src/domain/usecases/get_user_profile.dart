// ============================================================================
// FICHIER : get_user_profile.dart
// RÔLE : UseCase - Encapsule une action métier
// COUCHE : Domain Layer
// ============================================================================
//
// Ce fichier contient le UseCase GetUserProfile qui :
// - Représente l'action "Récupérer le profil d'un utilisateur"
// - Fait le pont entre la Presentation Layer et le Domain
// - Isole la logique métier
//
// POURQUOI UN USECASE ?
// - Chaque action métier = 1 UseCase
// - Facilite l'ajout de règles métier (ex: validation, logs, etc.)
// - Rend le code testable
//
// INSTRUCTIONS :
// 1. Créer la classe GetUserProfile
// 2. Injecter UserRepository dans le constructeur
// 3. Créer la méthode call(String userId) → Future<User>
// 4. Cette méthode appelle repository.getUserProfile(userId)
//
// ============================================================================

import '../entities/user.dart';
import '../repositories/user_repository.dart';

// ============================================================================
// TODO: Définir la classe GetUserProfile ici
// Exemple de structure :
// class GetUserProfile {
//   final UserRepository repository;
//   
//   GetUserProfile(this.repository);
//   
//   Future<User> call(String userId) {
//     return repository.getUserProfile(userId);
//   }
// }
// ============================================================================
