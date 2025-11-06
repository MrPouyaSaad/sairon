import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendVerifyCode(String phoneNumber);
  Future<String> verifyCode(String phoneNumber, String code);
  Future<void> clearToken();
  Future<void> saveToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio httpClient;

  AuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<void> sendVerifyCode(String phoneNumber) async => await httpClient
      .post(AppRoutes.auth.requestCode, data: {'phone': phoneNumber});

  @override
  Future<String> verifyCode(String phoneNumber, String code) async {
    final res = await httpClient.post(
      AppRoutes.auth.verifyCode,
      data: {'phone': phoneNumber, 'code': code},
    );

    final token = res.data['token'];
    await saveToken(token);
    return token;
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
