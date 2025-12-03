// ============================================================================
// FICHIER : user_model.dart
// RÔLE : Représente les données BRUTES venant de l'API (format JSON)
// COUCHE : Data Layer
// ============================================================================
// 
// Ce fichier contient le modèle UserModel qui :
// - Correspond EXACTEMENT à la structure JSON de l'API AZEOO
// - Utilise Freezed pour générer automatiquement les méthodes (copyWith, ==, etc.)
// - A une méthode fromJson pour convertir le JSON en objet Dart
// - A une méthode toEntity pour convertir UserModel → User (Domain)
//
// INSTRUCTIONS :
// 1. Définir la classe UserModel avec @freezed
// 2. Ajouter les champs : id, firstName, lastName, avatar
// 3. Ajouter factory fromJson
// 4. Ajouter méthode toEntity() qui retourne un User
//
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// ============================================================================
// TODO: Définir la classe UserModel ici
// Exemple de structure :
// @freezed
// class UserModel with _$UserModel {
//   factory UserModel({
//     required int id,
//     required String firstName,
//     required String lastName,
//     required String avatar,
//   }) = _UserModel;
//   
//   factory UserModel.fromJson(Map<String, dynamic> json) 
//       => _$UserModelFromJson(json);
// }
//
// extension UserModelX on UserModel {
//   User toEntity() {
//     return User(
//       id: id,
//       firstName: firstName,
//       lastName: lastName,
//       avatarUrl: avatar,
//     );
//   }
// }
// ============================================================================
