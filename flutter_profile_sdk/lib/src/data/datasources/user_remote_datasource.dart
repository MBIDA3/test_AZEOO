import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<UserModel> getUserById(String userId) async {
    final response = await dio.get(
      'https://api.azeoo.dev/v1/users/me',
      options: Options(
        headers: {
          'Accept-Language': 'fr-FR',
          'X-User-Id': userId,
          'Authorization':
              'Bearer api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20',
        },
      ),
    );

    return UserModel.fromJson(response.data);
  }
}
