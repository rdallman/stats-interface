import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class Globals {
  static const uiURL = "https://goswap.exchange";

  static Decimal toDec(var d) {
    return d != null ? Decimal.parse(d) : Decimal.zero;
  }

  static NumberFormat usdFormatCompact =
      NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");
}
