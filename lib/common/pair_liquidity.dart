class PairLiquidity {
  // "overTime": [
  //   {
  //     "time": "2020-09-10T22:00:00Z",
  //     "pair": "FAST-WGO",
  //     "token0": "FAST",
  //     "token1": "WGO",
  //     "totalSupply": "1262021.6044361742384418",
  //     "reserve0": "273615.8830946097875746",
  //     "reserve1": "6085369.2526775527441837",
  //     "price0": "0.250288643448904",
  //     "price1": "0.0107618482577019"
  DateTime timeStamp;
  String pair;
  String token0;
  String token1;
  double totalSupply;
  double reserve0;
  double reserve1;
  double price0;
  double price1;

  PairLiquidity(
      {DateTime timeStamp,
      String pair,
      String token0,
      String token1,
      double totalSupply,
      double reserve0,
      double reserve1,
      double price0,
      double price1})
      : this.pair = pair,
        this.token0 = token0,
        this.token1 = token1,
        this.totalSupply = totalSupply,
        this.reserve0 = reserve0,
        this.reserve1 = reserve1,
        this.price0 = price0,
        this.price1 = price1;

  PairLiquidity.fromJson(Map<String, dynamic> json)
      : timeStamp = DateTime.parse(json['time']),
        token0 = json['token0'],
        token1 = json['token1'],
        totalSupply = double.parse(json['totalSupply']),
        reserve0 = double.parse(json['reserve0']),
        reserve1 = double.parse(json['reserve1']),
        price0 = double.parse(json['price0']),
        price1 = double.parse(json['price1']),
        pair = json['pair'];

  Map<String, dynamic> toJson() => {
        'pair': pair,
        'token0': token0,
        'token1': token1,
        'totalSupply': totalSupply,
        'reserve0': reserve0,
        'reserve1': reserve1,
        'price0': price0,
        'price1': price1
      };
}
