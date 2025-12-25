class CartTotalEntity {
  final int subTotal;
  final int shipping;
  final int tax;
  final int total;

  CartTotalEntity({
    required this.subTotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });
}
