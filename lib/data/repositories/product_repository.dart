import 'package:sairon/data/models/product_model.dart';
import 'package:sairon/domain/repositories/product_repository_impl.dart';

class ProductRepository implements ProductRepositoryImpl {
  @override
  Future<ProductModel> fetchProductById(int id) {
    // TODO: implement fetchProductById
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchProducts(int page) {
    // TODO: implement fetchProducts
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(int id, int page) {
    // TODO: implement fetchProductsByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchProductsByLabel(String label, int page) {
    // TODO: implement fetchProductsByLabel
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchProductsBySearch(String keyword, int page) {
    // TODO: implement fetchProductsBySearch
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> fetchRecommendedProducts(int productId, int page) {
    // TODO: implement fetchRecommendedProducts
    throw UnimplementedError();
  }
}
