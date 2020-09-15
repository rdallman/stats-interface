import 'package:decimal/decimal.dart';

import 'globals.dart';

class PairBucket {
  // "overTime": [
  //   {
  //     "time": "2020-09-10T18:00:00Z",
  //     "pair": "FAST-WGO",
  //     "amount0In": "5388.8364686725754781",
  //     "amount1In": "525953.8559134333107807",
  //     "amount0Out": "23385.380361733117194",
  //     "amount1Out": "127030.4844234197912842",
  //     "price0USD": "0.250288643448904",
  //     "price1USD": "0.0107618482577019",
  //     "volumeUSD": "7009.00015740561960383837348579787573"
  DateTime timeStamp;
  String pair;
  Decimal amount0In;
  Decimal amount0Out;
  Decimal price0USD;
  Decimal amount1In;
  Decimal amount1Out;
  Decimal price1USD;
  Decimal volumeUSD;

  Decimal totalSupply;
  Decimal reserve0;
  Decimal reserve1;
  Decimal liquidityUSD;

  PairBucket(
      {DateTime timeStamp,
      String pair,
      Decimal amount0In,
      Decimal amount0Out,
      Decimal price0USD,
      Decimal amount1In,
      Decimal amount1Out,
      Decimal price1USD,
      Decimal volumeUSD,
      this.totalSupply,
      this.reserve0,
      this.reserve1,
      this.liquidityUSD})
      : this.timeStamp = timeStamp,
        this.volumeUSD = volumeUSD,
        this.amount0In = amount0In,
        this.amount0Out = amount0Out,
        this.price0USD = price0USD,
        this.amount1In = amount1In,
        this.amount1Out = amount1Out,
        this.price1USD = price1USD,
        this.pair = pair;

  PairBucket.fromJson(Map<String, dynamic> json)
      : timeStamp = json['time'] != null ? DateTime.parse(json['time']) : null,
        pair = json['pair'],
        volumeUSD = Globals.toDec(json['volumeUSD']),
        amount0In = Globals.toDec(json['amount0In']),
        amount0Out = Globals.toDec(json['amount0Out']),
        price0USD = Globals.toDec(json['price0USD']),
        amount1In = Globals.toDec(json['amount1In']),
        amount1Out = Globals.toDec(json['amount1Out']),
        price1USD = Globals.toDec(json['price1USD']),
        totalSupply = Globals.toDec(json['totalSupply']),
        reserve0 = Globals.toDec(json['reserve0']),
        reserve1 = Globals.toDec(json['reserve1']),
        liquidityUSD = Globals.toDec(json['liquidityUSD']);

  Map<String, dynamic> toJson() => {
        'time': timeStamp,
        'volumeUSD': volumeUSD,
        'amount0In': amount0In,
        'amount0Out': amount0Out,
        'price0USD': price0USD,
        'amount1In': amount1In,
        'amount1Out': amount1Out,
        'price1USD': price1USD,
        'pair': pair,
        'totalSupply': totalSupply,
        'reserve0': reserve0,
        'reserve1': reserve1,
      };
}
