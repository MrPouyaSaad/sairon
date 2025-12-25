import 'package:sairon/core/utils/formatters.dart';

extension PriceLable on String {
  String get withPriceLable => '$this تومان';
}

extension StringPriceFormat on String {
  String get formattedStringPrice => PriceFormatter.format(this);
}

extension DoublePriceFormat on double {
  String get formattedDoublePrice => PriceFormatter.formatDouble(this);
}
