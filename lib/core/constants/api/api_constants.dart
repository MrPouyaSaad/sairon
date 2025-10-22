import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.saironstore.ir';
  static String errorMessage = 'لطفا دستررسی به اینترنت خود را بررسی کنید!';

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

  static validateResponse(Response response) {
    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 204) {
      errorMessage = response.data['message'];
      throw Text(response.data['message']);
    }
  }
}
