import '../../../address/domain/entities/address.dart';
import '../../../cart/domain/entities/shipping_info.dart';
import 'invoice_entity.dart';
import 'order_item_entity.dart';
import 'payment_entity.dart';
import 'step_entity.dart';
import 'summery_entity.dart';

class OrderEntity {
  final String id;
  final String orderNumber;
  final String status;
  final String statusText;
  final double subtotal;
  final double discount;
  final double tax;
  final double shippingCost;
  final double total;
  final String paymentMethod;
  final String paymentStatus;
  final String shippingMethod;
  final String? deliveryTime;
  final String? trackingCode;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? paidAt;
  final DateTime? processingAt;
  final DateTime? preparingAt;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final List<OrderItemEntity> items;
  final AddressEntity? address;
  final List<PaymentEntity> payments;
  final InvoiceEntity? invoice;
  final List<OrderStepEntity> steps;
  final ShippingInfoEntity? shippingInfo;
  final FinancialSummaryEntity? financialSummary;

  OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.statusText,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.shippingCost,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingMethod,
    required this.deliveryTime,
    required this.trackingCode,
    required this.createdAt,
    required this.updatedAt,
    required this.paidAt,
    required this.processingAt,
    required this.preparingAt,
    required this.shippedAt,
    required this.deliveredAt,
    required this.items,
    required this.address,
    required this.payments,
    required this.invoice,
    required this.steps,
    required this.shippingInfo,
    required this.financialSummary,
  });

  bool get isPendingPayment => status == 'pending_payment';
  bool get isPaid => status == 'paid';
  bool get isProcessing => status == 'processing';
  bool get isPreparing => status == 'preparing';
  bool get isShipped => status == 'shipped';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';

  bool get canBeCancelled {
    return status == 'pending_payment' ||
        status == 'paid' ||
        status == 'processing';
  }

  bool get hasTrackingCode => trackingCode != null && trackingCode!.isNotEmpty;
}
