import 'package:decimal/decimal.dart';

class Total {
  DateTime timeStamp;
  Decimal volumeUSD;
  Decimal liquidityUSD;

  Total({DateTime timeStamp, Decimal volumeUSD, Decimal liquidityUSD})
      : this.timeStamp = timeStamp,
        this.volumeUSD = volumeUSD,
        this.liquidityUSD = liquidityUSD;

  Total.fromJson(Map<String, dynamic> json)
      : timeStamp = DateTime.parse(json['Time']),
        volumeUSD = Decimal.parse(json['volumeUSD']),
        liquidityUSD = Decimal.parse(json['liquidityUSD']);

  Map<String, dynamic> toJson() =>
      {'Time': timeStamp, 'volumeUSD': volumeUSD, 'liquidityUSD': liquidityUSD};
}
