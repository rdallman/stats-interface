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
  BigInt totalSupply;
  BigInt cMCPrice;

  Token(
      {String address,
      String name,
      String symbol,
      int decimals,
      BigInt totalSupply,
      BigInt cMCPrice})
      : this.address = address,
        this.name = name,
        this.symbol = symbol,
        this.decimals = decimals,
        this.totalSupply = totalSupply,
        this.cMCPrice = cMCPrice;

  Token.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        name = json['name'],
        symbol = json['symbol'],
        decimals = json['decimals'],
        totalSupply = BigInt.parse(json['totalSupply']),
        cMCPrice = BigInt.parse(json['CMCPrice']);

  Map<String, dynamic> toJson() => {
        'address': address,
        'name': name,
        'symbol': symbol,
        'decimals': decimals,
        'totalSupply': totalSupply,
        'CMCPrice': cMCPrice,
      };
}
