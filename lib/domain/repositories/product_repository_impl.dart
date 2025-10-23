import '../../data/models/product_model.dart';

abstract class ProductRepositoryImpl {
  Future<List<ProductModel>> fetchProducts(int page);
  Future<List<ProductModel>> fetchProductsByLabel(String label, int page);
  Future<List<ProductModel>> fetchProductsByCategory(int id, int page);
  Future<List<ProductModel>> fetchProductsBySearch(String keyword, int page);
  Future<List<ProductModel>> fetchRecommendedProducts(int productId, int page);
  Future<ProductModel> fetchProductById(int id);
}
