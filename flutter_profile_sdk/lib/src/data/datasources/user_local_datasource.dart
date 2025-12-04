import '../models/user_model.dart';

class UserLocalDataSource {
  final Map<String, UserModel> _cache = {};

  UserModel? getCachedUser(String userId) {
    return _cache[userId];
  }

  void cacheUser(String userId, UserModel user) {
    _cache[userId] = user;
  }

  void clearCache() {
    _cache.clear();
  }
}
