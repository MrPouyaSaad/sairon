class PaymentEntity {
  final String id;
  final String method;
  final String status;
  final double amount;
  final String? transactionId;
  final String? referenceId;
  final DateTime createdAt;
  final DateTime? paidAt;

  const PaymentEntity({
    required this.id,
    required this.method,
    required this.status,
    required this.amount,
    this.transactionId,
    this.referenceId,
    required this.createdAt,
    this.paidAt,
  });
}
