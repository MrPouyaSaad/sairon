import 'package:sairon/features/order/domain/entities/cart_validation_entity.dart';
import '../../../cart/data/model/shipping_info_model.dart';
import 'order_item_model.dart';

class CartValidationModel extends CartValidationEntity {
  CartValidationModel.fromJson(Map<String, dynamic> json)
    : super(
        isValid: json['isValid'] as bool? ?? false,
        cartId: json['cartId']?.toString() ?? '',
        itemsCount: (json['itemsCount'] as num?)?.toInt() ?? 0,
        items: (json['items'] as List<dynamic>? ?? [])
            .map((item) => OrderItemModel.fromJson(item))
            .toList(),
        priceSummary: PriceSummaryModel.fromJson(json['priceSummary'] ?? {}),
        shippingInfo: ShippingInfoModel.fromJson(json['shippingInfo'] ?? {}),
        errorMessage: json['errorMessage']?.toString(),
      );
}

class PriceSummaryModel extends PriceSummaryEntity {
  PriceSummaryModel.fromJson(Map<String, dynamic> json)
    : super(
        subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
        shipping: (json['shipping'] as num?)?.toDouble() ?? 0,
        tax: (json['tax'] as num?)?.toDouble() ?? 0,
        total: (json['total'] as num?)?.toDouble() ?? 0,
        totalQuantity: (json['totalQuantity'] as num?)?.toInt() ?? 0,
        totalDiscount: (json['totalDiscount'] as num?)?.toDouble() ?? 0,
        isFreeShipping: json['isFreeShipping'] as bool? ?? false,
        freeShippingThreshold: (json['freeShippingThreshold'] as num?)
            ?.toDouble(),
        remainingForFreeShipping: (json['remainingForFreeShipping'] as num?)
            ?.toDouble(),
      );
}
