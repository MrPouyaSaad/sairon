import 'package:dartz/dartz.dart';
import 'package:sairon/features/category/data/models/category_model.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/category_repository.dart';

class CategoryUseCases {
  final CategoryRepository repository;

  CategoryUseCases({required this.repository});

  Future<Either<Failure, List<CategoryModel>>> fetchCategories() {
    return repository.fetchCategories();
  }
}
