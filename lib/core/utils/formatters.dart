import 'package:intl/intl.dart';

class PriceFormatter {
  static String format(String price) {
    final value = double.tryParse(price) ?? 0;
    final formatter = NumberFormat.decimalPattern('en_US');
    return formatter.format(value);
  }

  static String formatDouble(double value) {
    final formatter = NumberFormat.decimalPattern('fa_IR');
    return formatter.format(value);
  }
}
