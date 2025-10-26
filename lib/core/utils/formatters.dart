import 'package:intl/intl.dart';

class PriceFormatter {
  /// Formats the price string with thousand separators
  /// Example: "1200000" => "1,200,000"
  static String format(String price) {
    final value = double.tryParse(price) ?? 0;
    final formatter = NumberFormat.decimalPattern(
      'en_US',
    ); // برای فارسی می‌تونی 'fa_IR' بذاری
    return formatter.format(value);
  }

  static String formatDouble(double value) {
    final formatter = NumberFormat.decimalPattern('fa_IR'); // فارسی
    return formatter.format(value);
  }
}
