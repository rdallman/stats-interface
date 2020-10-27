import 'package:decimal/decimal.dart';

class Token {
  // "tokens": [
  //   {
  //     "address": "0x0000000000000000000000000000000000000000",
  //     "name": "WGO",
  //     "symbol": "WGO",
  //     "decimals": 0,
  //     "totalSupply": "0",
  //     "CMCPrice": "0"
  String address;
  String name;
  String symbol;
  int decimals;

  Token(
      {String address,
      String name,
      String symbol,
      int decimals})
      : this.address = address,
        this.name = name,
        this.symbol = symbol,
        this.decimals = decimals;

  Token.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        name = json['name'],
        symbol = json['symbol'],
        decimals = json['decimals'];

  Map<String, dynamic> toJson() => {
        'address': address,
        'name': name,
        'symbol': symbol,
        'decimals': decimals,
      };

  String toString() {
    return "${symbol}";
  }
}
