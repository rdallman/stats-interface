import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/pair_bucket.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/common/token_bucket.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TokenLiquidityChart extends StatefulWidget {
  final String tokenAddress;
  TokenLiquidityChart({this.tokenAddress});
  @override
  State<StatefulWidget> createState() => TokenLiquidityChartState();
}

class TokenLiquidityChartState extends State<TokenLiquidityChart> {
  Future<List<TokenBucket>> tokenBucketF;

  var nf = NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");

  @override
  void initState() {
    super.initState();
    tokenBucketF = Api.fetchTokenBuckets(widget.tokenAddress);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TokenBucket>>(
      future: tokenBucketF,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Styles.errorText(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          var data = snapshot.data;

          List<charts.Series<TokenBucket, DateTime>> seriesList = [];
          var s0 = charts.Series<TokenBucket, DateTime>(
            id: 'Liquidity',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (TokenBucket sales, _) => sales.timeStamp,
            measureFn: (TokenBucket sales, _) =>
                sales.reserve.toDouble() * sales.priceUSD.toDouble(),
            data: data,
          );
          seriesList.add(s0);

          var last = data[data.length - 1];

          var labelColor = charts.ColorUtil.fromDartColor(Colors.grey[200]);
          return Center(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Liquidity',
                      style: TextStyle(
                        color: Color(0xff827daa),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      nf.format(
                          last.reserve.toDouble() * last.priceUSD.toDouble()),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                      child: Container(
                        height: 400,
                        child: charts.TimeSeriesChart(
                          seriesList,
                          domainAxis: new charts.DateTimeAxisSpec(
                            renderSpec: new charts.SmallTickRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 18, // size in Pts.
                                  color: labelColor),
                              lineStyle:
                                  new charts.LineStyleSpec(color: labelColor),
                            ),
                          ),
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                              tickFormatterSpec: charts
                                      .BasicNumericTickFormatterSpec
                                  .fromNumberFormat(Globals.usdFormatCompact),
                              renderSpec: new charts.GridlineRendererSpec(
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 18, // size in Pts.
                                      color: labelColor),
                                  lineStyle: new charts.LineStyleSpec(
                                      color: labelColor))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Text('Loading...');
      },
    );
  }
}
