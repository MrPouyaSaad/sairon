import 'package:sairon/features/order/domain/entities/order_item_entity.dart';
import 'package:sairon/features/product/data/models/product_model.dart';

class OrderItemModel extends OrderItemEntity {
  OrderItemModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id']?.toString() ?? '',
        productId: json['productId']?.toString() ?? '',
        variantId: json['variantId']?.toString(),
        quantity: (json['quantity'] as num?)?.toInt() ?? 0,
        unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
        originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0,
        discountType: json['discountType']?.toString() ?? 'amount',
        total: (json['total'] as num?)?.toDouble() ?? 0,
        product: ProductModel.fromJson(json['product'] ?? {}),
        variantAttributes: json['variantAttributes'] != null
            ? Map<String, dynamic>.from(json['variantAttributes'])
            : null,
      );
}
