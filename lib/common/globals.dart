import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class Globals {
  static const uiURL = "https://goswap.exchange";

  static Decimal toDec(var d) {
    return d != null ? Decimal.parse(d) : Decimal.zero;
  }

  static NumberFormat usdFormatCompact =
      NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");

  static NumberFormat usdFormat = NumberFormat.simpleCurrency(locale: "en_US");

  static String formatCurrency(Decimal d) {
    if (d == null) {
      return usdFormat.format(0.0);
    }
    return usdFormat.format(d.toDouble());
  }
}
