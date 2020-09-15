import 'package:decimal/decimal.dart';

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
      : timeStamp = DateTime.parse(json['Time']),
        volumeUSD = Decimal.parse(json['volumeUSD']),
        amountIn = Decimal.parse(json['amountIn']),
        amountOut = Decimal.parse(json['amountOut']),
        priceUSD = Decimal.parse(json['priceUSD']),
        symbol = json['Symbol'];

  Map<String, dynamic> toJson() => {
        'Time': timeStamp,
        'volumeUSD': volumeUSD,
        'amountIn': amountIn,
        'amountOut': amountOut,
        'priceUSD': priceUSD,
        'Symbol': symbol
      };
}
