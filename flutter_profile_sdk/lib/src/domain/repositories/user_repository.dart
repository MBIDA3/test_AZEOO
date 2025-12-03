// ============================================================================
// FICHIER : user_repository.dart
// RÔLE : Interface (contrat) du Repository
// COUCHE : Domain Layer
// ============================================================================
//
// Ce fichier contient l'INTERFACE UserRepository qui :
// - Définit le CONTRAT que le Repository doit respecter
// - Ne contient PAS d'implémentation (juste des signatures)
// - Permet au Domain Layer d'être indépendant du Data Layer
//
// POURQUOI UNE INTERFACE ?
// - Principe SOLID : Dependency Inversion
// - Le Domain ne dépend PAS de l'implémentation concrète
// - On peut changer l'implémentation sans toucher au Domain
//
// INSTRUCTIONS :
// 1. Définir une classe abstraite UserRepository
// 2. Déclarer la méthode getUserProfile(String userId) → Future<User>
//
// ============================================================================

import '../entities/user.dart';

// ============================================================================
// TODO: Définir l'interface UserRepository ici
// Exemple de structure :
// abstract class UserRepository {
//   Future<User> getUserProfile(String userId);
// }
// ============================================================================
