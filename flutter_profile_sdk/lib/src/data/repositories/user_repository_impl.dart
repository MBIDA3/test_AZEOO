// ============================================================================
// FICHIER : user_repository_impl.dart
// RÔLE : Implémentation concrète du Repository (orchestre cache + API)
// COUCHE : Data Layer
// ============================================================================
//
// Ce fichier contient la classe UserRepositoryImpl qui :
// - Implémente l'interface UserRepository (du Domain Layer)
// - Décide si on utilise le cache ou l'API
// - Logique : Cache d'abord, sinon API, puis met en cache
// - Convertit UserModel (Data) → User (Domain)
//
// INSTRUCTIONS :
// 1. Implémenter l'interface UserRepository
// 2. Injecter UserRemoteDataSource et UserLocalDataSource
// 3. Dans getUserProfile(String userId) :
//    a. Checker le cache (localDataSource.getCachedUser)
//    b. Si trouvé → convertir en User et retourner
//    c. Sinon → appeler l'API (remoteDataSource.getUserById)
//    d. Mettre en cache (localDataSource.cacheUser)
//    e. Convertir en User et retourner
//
// ============================================================================

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../datasources/user_local_datasource.dart';

// ============================================================================
// TODO: Définir la classe UserRepositoryImpl ici
// Exemple de structure :
// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource remoteDataSource;
//   final UserLocalDataSource localDataSource;
//   
//   UserRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });
//   
//   @override
//   Future<User> getUserProfile(String userId) async {
//     // 1. Checker le cache
//     final cachedUser = localDataSource.getCachedUser(userId);
//     if (cachedUser != null) {
//       return cachedUser.toEntity();
//     }
//     
//     // 2. Appeler l'API
//     final userModel = await remoteDataSource.getUserById(userId);
//     
//     // 3. Mettre en cache
//     localDataSource.cacheUser(userId, userModel);
//     
//     // 4. Retourner l'Entity
//     return userModel.toEntity();
//   }
// }
// ============================================================================
