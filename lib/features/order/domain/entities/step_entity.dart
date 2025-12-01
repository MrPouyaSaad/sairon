class OrderStepEntity {
  final String name;
  final String status; // 'completed', 'current', 'pending', 'cancelled'
  final DateTime? date;

  const OrderStepEntity({required this.name, required this.status, this.date});
}
