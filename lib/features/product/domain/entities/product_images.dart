class ProductImages {
  final List<String> images;
  ProductImages.fromJson(List<dynamic> json)
    : images = json.map((e) => e['url'] as String).toList();
}
