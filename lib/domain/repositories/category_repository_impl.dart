import '../../data/models/category_model.dart';

abstract class CategoryRepositoryImpl {
  Future<List<CategoryModel>> fetchCategories();
}
