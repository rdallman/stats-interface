import 'package:decimal/decimal.dart';

import 'token.dart';

class Pair {
  int index;
  String address;

  Token token0;
  Token token1;

  Decimal totalSupply;

  Pair({
    this.index,
    this.address,
    this.token0,
    this.token1,
    thistotalSupply,
  });

  Pair.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        index = json['index'],
        token0 = Token.fromJson(json['token0']),
        token1 = Token.fromJson(json['token1']),
        totalSupply = json['totalSupply'] != null
            ? Decimal.parse(json['totalSupply'])
            : Decimal.zero;

  Map<String, dynamic> toJson() => {
        'index': index,
        'address': address,
        'token0': token0,
        'token1': token1,
        'totalSupply': totalSupply,
      };

  String toString() {
    return "${token0.symbol}-${token1.symbol}";
  }
}
