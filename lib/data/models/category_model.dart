class CategoryModel {
  final int id;
  final String name;
  final String imageUrl;
  CategoryModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      imageUrl = json['image'];
}
