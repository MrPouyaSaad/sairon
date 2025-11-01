class ProductVariantEntity {
  final String id;
  final String sku;
  final String price;
  final String stock;
  final Map<String, String> attributes;
  final bool isAvailable;

  ProductVariantEntity({
    required this.id,
    required this.sku,
    required this.price,
    required this.stock,
    required this.attributes,
    required this.isAvailable,
  });
}
