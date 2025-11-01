import '../../domain/entities/variants.dart';

class ProductVariantModel extends ProductVariantEntity {
  ProductVariantModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        sku: json['sku']?.toString() ?? '',
        price: json['price']?.toString() ?? '0',
        stock: json['stock']?.toString() ?? '0',
        isAvailable: json['isAvailable'] ?? false,
        attributes: _parseAttributes(json['attributes']),
      );

  static Map<String, String> _parseAttributes(dynamic data) {
    if (data == null) return {};

    if (data is Map) {
      return data.map(
        (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
      );
    }

    return {};
  }
}
