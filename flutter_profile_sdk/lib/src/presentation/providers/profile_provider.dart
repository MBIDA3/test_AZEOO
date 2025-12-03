// ============================================================================
// FICHIER : profile_provider.dart
// RÔLE : State Management avec Riverpod - Gère l'état du profil
// COUCHE : Presentation Layer
// ============================================================================
//
// Ce fichier contient le Provider Riverpod qui :
// - Gère les 3 états : Loading, Success, Error
// - Appelle le UseCase GetUserProfile
// - Notifie l'UI quand l'état change
//
// LES 3 ÉTATS POSSIBLES :
// - AsyncValue.loading() → En train de charger
// - AsyncValue.data(user) → Chargé avec succès
// - AsyncValue.error(error) → Erreur
//
// INSTRUCTIONS :
// 1. Créer un StateNotifierProvider avec Riverpod generator (@riverpod)
// 2. État initial : AsyncValue.loading()
// 3. Méthode loadProfile(String userId) qui :
//    a. Met l'état en loading
//    b. Appelle le UseCase
//    c. Met l'état en data(user) si succès
//    d. Met l'état en error si échec
//
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';

part 'profile_provider.g.dart';

// ============================================================================
// TODO: Définir le ProfileProvider ici
// Exemple de structure :
// @riverpod
// class ProfileNotifier extends _$ProfileNotifier {
//   @override
//   AsyncValue<User?> build() {
//     return const AsyncValue.data(null);
//   }
//   
//   Future<void> loadProfile(String userId) async {
//     state = const AsyncValue.loading();
//     
//     try {
//       final useCase = ref.read(getUserProfileProvider);
//       final user = await useCase(userId);
//       state = AsyncValue.data(user);
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }
// }
// ============================================================================
