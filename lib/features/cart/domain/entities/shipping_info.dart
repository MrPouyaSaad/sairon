class ShippingInfoEntity {
  final String method;
  final int cost;
  final int freeShippingThreshold;
  final bool isFree;
  final String message;

  ShippingInfoEntity({
    required this.method,
    required this.cost,
    required this.freeShippingThreshold,
    required this.isFree,
    required this.message,
  });
}
