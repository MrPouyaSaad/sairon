import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/data/models/product_model.dart';

class ProductRemoteDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});

  Future<ProductModel> fetchProductById(int id) async {
    final res = await httpClient.get(AppRoutes.products.byId(id));
    final ProductModel productModel = ProductModel.fromJson(res.data['data']);
    return productModel;
  }

  Future<List<ProductModel>> fetchProducts(int page) async {
    final res = await httpClient.get(AppRoutes.products.all(page: page));
    final List<ProductModel> products = (res.data['data'] as List)
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();

    return products;
  }

  Future<List<ProductModel>> fetchProductsByCategory(int id, int page) async {
    final res = await httpClient.get(
      AppRoutes.products.byCategory(categoryId: id, page: page),
    );
    final List<ProductModel> products = (res.data['data'] as List)
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return products;
  }

  Future<List<ProductModel>> fetchProductsByLabel(
    String label,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.byLabel(label: label, page: page),
    );
    final List<ProductModel> products = (res.data['data'] as List)
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return products;
  }

  Future<List<ProductModel>> fetchProductsBySearch(
    String keyword,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.search(query: keyword, page: page),
    );
    final List<ProductModel> products = (res.data['data'] as List)
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return products;
  }

  Future<List<ProductModel>> fetchRecommendedProducts(
    int productId,
    int page,
  ) async {
    final res = await httpClient.get(
      AppRoutes.products.recommended(productId, page: page),
    );
    final List<ProductModel> products = (res.data['data'] as List)
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    return products;
  }
}
