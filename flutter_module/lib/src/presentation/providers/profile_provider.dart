import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/datasources/user_local_datasource.dart';

// Provider pour Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// Provider pour UserLocalDataSource
final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource();
});

// Provider pour UserRemoteDataSource
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return UserRemoteDataSource(dio);
});

// Provider pour UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.read(userRemoteDataSourceProvider);
  final localDataSource = ref.read(userLocalDataSourceProvider);
  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

// Provider pour GetUserProfile UseCase
final getUserProfileProvider = Provider<GetUserProfile>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return GetUserProfile(repository);
});

// StateNotifier pour gérer l'état du profil
class ProfileNotifier extends StateNotifier<AsyncValue<User?>> {
  final GetUserProfile getUserProfile;
  final Ref ref;

  ProfileNotifier(this.getUserProfile, this.ref) : super(const AsyncValue.data(null));

  /// Charge le profil (utilise le cache si disponible)
  Future<void> loadProfile(String userId) async {
    state = const AsyncValue.loading();

    try {
      final user = await getUserProfile.call(userId);
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Rafraîchit le profil (invalide le cache et recharge depuis l'API)
  Future<void> refreshProfile(String userId) async {
    state = const AsyncValue.loading();

    try {
      // Invalider le cache
      ref.read(userLocalDataSourceProvider).clearCache();
      print('🔄 Cache invalidé, rechargement depuis l\'API...');
      
      final user = await getUserProfile.call(userId);
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Provider pour ProfileNotifier
final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<User?>>((ref) {
  final getUserProfile = ref.read(getUserProfileProvider);
  return ProfileNotifier(getUserProfile, ref);
});
