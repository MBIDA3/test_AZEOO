// ============================================================================
// FICHIER : user_remote_datasource.dart
// RÔLE : Fait les appels HTTP vers l'API AZEOO
// COUCHE : Data Layer
// ============================================================================
//
// Ce fichier contient la classe UserRemoteDataSource qui :
// - Utilise Dio pour faire des requêtes HTTP
// - Appelle l'API AZEOO avec les 3 headers obligatoires
// - Retourne un UserModel (pas encore un User)
//
// INSTRUCTIONS :
// 1. Créer la classe UserRemoteDataSource
// 2. Injecter Dio dans le constructeur
// 3. Créer la méthode getUserById(String userId)
// 4. URL : https://api.azeoo.dev/v1/users/me
// 5. Headers obligatoires :
//    - Accept-Language: fr-FR
//    - X-User-Id: [userId]
//    - Authorization: Bearer api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20
//
// ============================================================================

import 'package:dio/dio.dart';
import '../models/user_model.dart';

// ============================================================================
// TODO: Définir la classe UserRemoteDataSource ici
// Exemple de structure :
// class UserRemoteDataSource {
//   final Dio dio;
//   
//   UserRemoteDataSource(this.dio);
//   
//   Future<UserModel> getUserById(String userId) async {
//     final response = await dio.get(
//       'https://api.azeoo.dev/v1/users/me',
//       options: Options(headers: {
//         'Accept-Language': 'fr-FR',
//         'X-User-Id': userId,
//         'Authorization': 'Bearer api_474758da...',
//       }),
//     );
//     
//     return UserModel.fromJson(response.data);
//   }
// }
// ============================================================================
