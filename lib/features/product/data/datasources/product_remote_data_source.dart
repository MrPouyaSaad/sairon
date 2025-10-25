import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> fetchProductById(int id);
  Future<List<ProductModel>> fetchProducts(int page);
  Future<List<ProductModel>> fetchProductsByCategory(int id, int page);
  Future<List<ProductModel>> fetchProductsByLabel(String label, int page);
  Future<List<ProductModel>> fetchProductsBySearch(String keyword, int page);
  Future<List<ProductModel>> fetchRecommendedProducts(int productId, int page);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio httpClient;

  ProductRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<ProductModel> fetchProductById(int id) async {
    final res = await httpClient.get(AppRoutes.products.byId(id));
    return ProductModel.fromJson(res.data['data']);
  }

  @override
  Future<List<ProductModel>> fetchProducts(int page) async {
    final res = await httpClient.get(AppRoutes.products.all(page: page));
    return (res.data['data'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(int id, int page) async {
    final res = await httpClient.get(
      AppRoutes.products.byCategory(categoryId: id, page: page),
    );
    return (res.data['data'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProductsByLabel(
    String label,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.byLabel(label: label, page: page),
    );
    return (res.data['data'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchProductsBySearch(
    String keyword,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.search(query: keyword, page: page),
    );
    return (res.data['data'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ProductModel>> fetchRecommendedProducts(
    int productId,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.recommended(productId, page: page),
    );
    return (res.data['data'] as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
