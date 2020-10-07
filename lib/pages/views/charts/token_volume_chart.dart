import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:goswapinfo/common/volume.dart';

class TokenVolumeChart extends StatefulWidget {
  final String tokenAddress;
  TokenVolumeChart({this.tokenAddress});
  @override
  _TokenVolumeChartState createState() => _TokenVolumeChartState();
}

class _TokenVolumeChartState extends State<TokenVolumeChart> {
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
            id: 'Volume',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (TokenBucket sales, _) => sales.timeStamp,
            measureFn: (TokenBucket sales, _) => sales.volumeUSD.toDouble(),
            data: data,
          );
          seriesList.add(s0);

          var last = data[data.length - 1];
          Decimal totalVolume = last.volumeUSD;

          var labelColor = charts.ColorUtil.fromDartColor(Colors.grey[200]);
          return Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    nf.format(totalVolume.toDouble()),
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
                  // Expanded(
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: Container(
                      height: 400,
                      child: charts.TimeSeriesChart(
                        seriesList,
                        defaultRenderer:
                            new charts.BarRendererConfig<DateTime>(),
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
                          // To make bar charts only have 2 ticks like on the homepage
                          tickProviderSpec:
                              new charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 2),

                          tickFormatterSpec:
                              charts.BasicNumericTickFormatterSpec
                                  .fromNumberFormat(Globals.usdFormatCompact),
                          renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 18, // size in Pts.
                                color: labelColor),
                            lineStyle:
                                new charts.LineStyleSpec(color: labelColor),
                          ),
                        ),
                        behaviors: [
                          new charts.DomainHighlighter(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text('Loading...');
      },
    );
  }
}
