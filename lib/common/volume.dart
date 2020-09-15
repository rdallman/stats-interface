import 'package:decimal/decimal.dart';

import 'globals.dart';

class TokenBucket {
  // "overTime": [
  //   {
  //     "Time": "2020-09-10T18:00:00Z",
  //     "Symbol": "WGO",
  //     "amountIn": "753197.1215886803707055",
  //     "amountOut": "227317.5702229650265146",
  //     "priceUSD": "0.0107618482577019",
  //     "volumeUSD": "8105.79313067522597805019378751169045"
  //   },
  DateTime timeStamp;
  String symbol;
  Decimal amountIn;
  Decimal amountOut;
  Decimal priceUSD;
  Decimal volumeUSD;

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
        volumeUSD = Globals.toDec(json['volumeUSD']),
        amountIn = Globals.toDec(json['amountIn']),
        amountOut = Globals.toDec(json['amountOut']),
        priceUSD = Globals.toDec(json['priceUSD']),
        symbol = json['symbol'];

  Map<String, dynamic> toJson() => {
        'time': timeStamp,
        'volumeUSD': volumeUSD,
        'amountIn': amountIn,
        'amountOut': amountOut,
        'priceUSD': priceUSD,
        'symbol': symbol
      };
}
