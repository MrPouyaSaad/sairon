class ProductImages {
  final List<String> urls;
  ProductImages.fromJson(List<dynamic> json)
    : urls = json.map((e) => e['url'] as String).toList();
}
