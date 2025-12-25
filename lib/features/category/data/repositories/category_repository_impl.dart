import 'package:dartz/dartz.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/features/category/data/models/category_model.dart';
import '../../../../core/constants/api/api_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

final dataSource = CategoryRemoteDataSource(ApiConstants.httpClient);
final categoryRepository = CategoryRepositoryImpl(dataSource);

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    return safeCall(() => remoteDataSource.fetchCategories());
  }
}
