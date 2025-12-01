class InvoiceEntity {
  final String id;
  final String invoiceNumber;
  final String status;
  final DateTime issueDate;
  final double subtotal;
  final double discount;
  final double tax;
  final double shippingCost;
  final double total;
  final List<InvoiceItemEntity> items;

  const InvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.status,
    required this.issueDate,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.shippingCost,
    required this.total,
    required this.items,
  });
}

class InvoiceItemEntity {
  final String id;
  final String description;
  final int quantity;
  final double unitPrice;
  final double total;

  const InvoiceItemEntity({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });
}
