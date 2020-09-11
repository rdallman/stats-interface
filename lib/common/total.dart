class Total {
  DateTime timeStamp;
  double volumeUSD;
  double liquidityUSD;

  Total({DateTime timeStamp, double volumeUSD, double liquidityUSD})
      : this.timeStamp = timeStamp,
        this.volumeUSD = volumeUSD,
        this.liquidityUSD = liquidityUSD;

  Total.fromJson(Map<String, dynamic> json)
      : timeStamp = DateTime.parse(json['Time']),
        volumeUSD = double.parse(json['volumeUSD']),
        liquidityUSD = double.parse(json['liquidityUSD']);

  Map<String, dynamic> toJson() =>
      {'Time': timeStamp, 'volumeUSD': volumeUSD, 'liquidityUSD': liquidityUSD};
}
