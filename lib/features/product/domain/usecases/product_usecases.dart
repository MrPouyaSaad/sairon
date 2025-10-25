import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

/// UseCases related to Product feature
class ProductUseCases {
  final ProductRepository repository;

  ProductUseCases(this.repository);

  /// Fetch single product by ID
  Future<Either<Failure, ProductModel>> fetchProductById(int id) async {
    return await repository.fetchProductById(id);
  }

  /// Fetch all products with pagination
  Future<Either<Failure, List<ProductModel>>> fetchProducts(int page) async {
    return await repository.fetchProducts(page);
  }

  /// Fetch products filtered by category ID
  Future<Either<Failure, List<ProductModel>>> fetchProductsByCategory(
    int categoryId,
    int page,
  ) async {
    return await repository.fetchProductsByCategory(categoryId, page);
  }

  /// Fetch products filtered by label (e.g., "new", "popular")
  Future<Either<Failure, List<ProductModel>>> fetchProductsByLabel(
    String label,
    int page,
  ) async {
    return await repository.fetchProductsByLabel(label, page);
  }

  /// Search products by keyword
  Future<Either<Failure, List<ProductModel>>> fetchProductsBySearch(
    String keyword,
    int page,
  ) async {
    return await repository.fetchProductsBySearch(keyword, page);
  }

  /// Fetch recommended products based on product ID
  Future<Either<Failure, List<ProductModel>>> fetchRecommendedProducts(
    int productId,
    int page,
  ) async {
    return await repository.fetchRecommendedProducts(productId, page);
  }
}
