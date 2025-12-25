import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/auth/data/models/user.dart';
import 'package:sairon/features/auth/domain/entities/user.dart';

class ProfileDataSource {
  final Dio httpClient;

  ProfileDataSource({required this.httpClient});

  Future<UserEntity> getUserInfo() async {
    final res = await httpClient.get(AppRoutes.profile.baseUrl);
    return UserModel.fromJson(res.data['data']);
  }

  Future<void> editUserInfo(UserEntity user) async {
    await httpClient.post(AppRoutes.profile.baseUrl, data: {});
  }
}
