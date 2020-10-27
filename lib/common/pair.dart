import 'package:decimal/decimal.dart';

class Pair {
  int index;
  String address;
  String pair;

  String token0;
  String token1;

  Decimal totalSupply;

  Pair({
    this.index,
    this.address,
    this.pair,
    this.token0,
    this.token1,
    thistotalSupply,
  });

  Pair.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        index = json['index'],
        pair = json['pair'],
        token0 = json['token0'],
        token1 = json['token1'],
        totalSupply = json['totalSupply'] != null
            ? Decimal.parse(json['totalSupply'])
            : Decimal.zero;

  Map<String, dynamic> toJson() => {
        'index': index,
        'address': address,
        'pair': pair,
        'token0': token0,
        'token1': token1,
        'totalSupply': totalSupply,
      };

  String toString() {
    return "${pair}";
  }
}
