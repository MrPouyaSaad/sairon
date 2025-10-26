import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart' show Failure;
import '../../data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> fetchCategories();
}
