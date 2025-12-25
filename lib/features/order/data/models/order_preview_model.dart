import 'package:sairon/features/order/domain/entities/order_preview_entity.dart';

import '../../../cart/data/model/shipping_info_model.dart';

class OrderPreviewModel extends OrderPreviewEntity {
  OrderPreviewModel.fromJson(Map<String, dynamic> json)
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
        itemsCount: (json['itemsCount'] as num?)?.toInt() ?? 0,
        cartId: json['cartId']?.toString() ?? '',
        shippingInfo: ShippingInfoModel.fromJson(json['shippingInfo'] ?? {}),
        taxInfo: TaxInfoModel.fromJson(json['taxInfo'] ?? {}),
        isValid: json['isValid'] as bool? ?? false,
      );
}

class TaxInfoModel extends TaxInfoEntity {
  TaxInfoModel.fromJson(Map<String, dynamic> json)
    : super(
        rate: json['rate']?.toString() ?? '0%',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
      );
}
