import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts(int page);
  Future<Either<Failure, List<ProductModel>>> fetchProductsByLabel(
    String label,
    int page,
  );
  Future<Either<Failure, List<ProductModel>>> fetchProductsByCategory(
    int id,
    int page,
  );
  Future<Either<Failure, List<ProductModel>>> fetchProductsBySearch(
    String keyword,
    int page,
  );
  Future<Either<Failure, List<ProductModel>>> fetchRecommendedProducts(
    int productId,
    int page,
  );
  Future<Either<Failure, ProductModel>> fetchProductById(int id);
}
