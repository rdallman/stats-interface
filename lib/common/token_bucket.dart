import 'package:decimal/decimal.dart';

import 'globals.dart';

class TokenBucket {
  DateTime timeStamp;
  String symbol;
  String address;
  Decimal amountIn;
  Decimal amountOut;
  Decimal priceUSD;
  Decimal volumeUSD;
  Decimal reserve;
  Decimal liquidityUSD;

  TokenBucket(
      {DateTime timeStamp,
      String symbol,
      String address,
      Decimal amountIn,
      Decimal amountOut,
      Decimal priceUSD,
      Decimal reserve,
      Decimal volumeUSD})
      : this.timeStamp = timeStamp,
        this.volumeUSD = volumeUSD,
        this.amountIn = amountIn,
        this.amountOut = amountOut,
        this.priceUSD = priceUSD,
        this.reserve = reserve,
        this.symbol = symbol;

  TokenBucket.fromJson(Map<String, dynamic> json)
      : timeStamp = json['time'] != null ? DateTime.parse(json['time']) : null,
        symbol = json['symbol'],
        address = json['address'],
        volumeUSD = Globals.toDec(json['volumeUSD']),
        amountIn = Globals.toDec(json['amountIn']),
        amountOut = Globals.toDec(json['amountOut']),
        priceUSD = Globals.toDec(json['priceUSD']),
        reserve = Globals.toDec(json['reserve']),
        liquidityUSD = Globals.toDec(json['liquidityUSD']);

  Map<String, dynamic> toJson() => {
        'time': timeStamp,
        'volumeUSD': volumeUSD,
        'amountIn': amountIn,
        'amountOut': amountOut,
        'priceUSD': priceUSD,
        'reserve': reserve,
        'symbol': symbol,
        'address': address
      };

  String toString() {
    if (symbol == "WGO") return "GO";
    return symbol;
  }
}
