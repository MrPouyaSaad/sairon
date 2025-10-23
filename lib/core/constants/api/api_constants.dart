import 'package:dio/dio.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.saironstore.ir';

  static final httpClient = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // final authInfo = AuthRepository.authNotifier.value;
          // if (authInfo != null) {
          //   options.headers['Authorization'] = 'Bearer $authInfo';
          //   // options.headers['Content-Type'] = 'application / json';
          // }
          handler.next(options);
        },
      ),
    );
}
