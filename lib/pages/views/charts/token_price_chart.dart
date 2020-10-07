import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:goswapinfo/common/volume.dart';

class TokenPriceChart extends StatefulWidget {
  final String tokenAddress;
  TokenPriceChart({this.tokenAddress});
  @override
  State<StatefulWidget> createState() => TokenPriceChartState();
}

class TokenPriceChartState extends State<TokenPriceChart> {
  bool priceIsLowerThanOneDollar;
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
            id: 'Price',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (TokenBucket sales, _) => sales.timeStamp,
            measureFn: (TokenBucket sales, _) => sales.priceUSD.toDouble(),
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
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      nf.format(last.priceUSD.toDouble()),
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
                                  fontSize: 18, color: labelColor),
                              lineStyle:
                                  new charts.LineStyleSpec(color: labelColor),
                            ),
                          ),
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            // To make bar chart Y axis range be relative to price
                            viewport: new charts.NumericExtents(
                                0, last.priceUSD.toDouble() * 2),

                            tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(
                              desiredTickCount: 5,
                              desiredMinTickCount: 3,
                              dataIsInWholeNumbers: false,
                            ),

                            tickFormatterSpec: charts
                                .BasicNumericTickFormatterSpec.fromNumberFormat(
                              Globals.usdFormatCompact,
                            ),
                            renderSpec: new charts.GridlineRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 18, // size in Pts.
                                  color: labelColor),
                              lineStyle:
                                  new charts.LineStyleSpec(color: labelColor),
                            ),
                          ),
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
