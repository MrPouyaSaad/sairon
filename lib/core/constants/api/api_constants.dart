import 'package:dio/dio.dart';

import '../../../features/auth/data/repositories/token_repo.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.saironstore.ir';

  static final httpClient = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenRepository.currentToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },
      ),
    );
}
