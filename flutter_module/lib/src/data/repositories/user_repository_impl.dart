import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../datasources/user_local_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> getUserProfile(String userId) async {
    // 1. Vérifier le cache
    final cachedUser = localDataSource.getCachedUser(userId);
    if (cachedUser != null) {
      print('📦 Profil chargé depuis le cache');
      return cachedUser.toEntity();
    }

    // 2. Si pas dans le cache, appeler l'API
    print('🌐 Appel API pour userId: $userId');
    final userModel = await remoteDataSource.getUserById(userId);

    // 3. Mettre en cache
    localDataSource.cacheUser(userId, userModel);
    print('✅ Profil mis en cache');

    // 4. Retourner l'Entity
    return userModel.toEntity();
  }
}
