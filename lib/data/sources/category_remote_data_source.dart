import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/data/models/category_model.dart';

import '../../core/errors/exceptions.dart';

class CategoryRemoteDataSource {
  final Dio httpClient;

  CategoryRemoteDataSource({required this.httpClient});

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final res = await httpClient.get(AppRoutes.categories.categories);
      final List<CategoryModel> categories = (res.data['data'] as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      return categories;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      throw UnknownException('مشکلی در پردازش داده رخ داده است.');
    }
  }
}
