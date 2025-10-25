import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/product/data/datasources/product_remote_data_source.dart';
import 'package:sairon/features/product/data/models/product_model.dart';
import 'package:sairon/features/product/domain/repositories/product_repository.dart';

import '../../../../core/errors/exception_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, ProductModel>> fetchProductById(int id) async {
    return safeCall(() => dataSource.fetchProductById(id));
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts(int page) async {
    return safeCall(() => dataSource.fetchProducts(page));
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProductsByCategory(
    int id,
    int page,
  ) async {
    return safeCall(() => dataSource.fetchProductsByCategory(id, page));
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProductsByLabel(
    String label,
    int page,
  ) async {
    return safeCall(() => dataSource.fetchProductsByLabel(label, page));
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProductsBySearch(
    String keyword,
    int page,
  ) async {
    return safeCall(() => dataSource.fetchProductsBySearch(keyword, page));
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchRecommendedProducts(
    int productId,
    int page,
  ) async {
    return safeCall(() => dataSource.fetchRecommendedProducts(productId, page));
  }
}
