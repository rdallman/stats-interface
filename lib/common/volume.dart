import 'package:decimal/decimal.dart';

import 'globals.dart';

class TokenBucket {
  DateTime timeStamp;
  String symbol;
  Decimal amountIn;
  Decimal amountOut;
  Decimal priceUSD;
  Decimal volumeUSD;
  Decimal liquidityUSD;

  TokenBucket(
      {DateTime timeStamp,
      String symbol,
      Decimal amountIn,
      Decimal amountOut,
      Decimal priceUSD,
      Decimal volumeUSD})
      : this.timeStamp = timeStamp,
        this.volumeUSD = volumeUSD,
        this.amountIn = amountIn,
        this.amountOut = amountOut,
        this.priceUSD = priceUSD,
        this.symbol = symbol;

  TokenBucket.fromJson(Map<String, dynamic> json)
      : timeStamp = json['time'] != null ? DateTime.parse(json['time']) : null,
        symbol = json['symbol'],
        volumeUSD = Globals.toDec(json['volumeUSD']),
        amountIn = Globals.toDec(json['amountIn']),
        amountOut = Globals.toDec(json['amountOut']),
        priceUSD = Globals.toDec(json['priceUSD']),
        liquidityUSD = Globals.toDec(json['liquidityUSD']);

  Map<String, dynamic> toJson() => {
        'time': timeStamp,
        'volumeUSD': volumeUSD,
        'amountIn': amountIn,
        'amountOut': amountOut,
        'priceUSD': priceUSD,
        'symbol': symbol
      };
}
