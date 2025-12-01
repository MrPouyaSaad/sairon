class FinancialSummaryEntity {
  final double subtotal;
  final double discount;
  final double tax;
  final double shippingCost;
  final double total;

  const FinancialSummaryEntity({
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.shippingCost,
    required this.total,
  });
}
