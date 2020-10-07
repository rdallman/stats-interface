import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/pair_volume.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PairLiquidityChart extends StatefulWidget {
  final String pairAddress;
  PairLiquidityChart({this.pairAddress});
  @override
  State<StatefulWidget> createState() => PairLiquidityChartState();
}

class PairLiquidityChartState extends State<PairLiquidityChart> {
  Future<List<PairBucket>> pairBucketF;

  var nf = NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");

  @override
  void initState() {
    super.initState();
    pairBucketF = Api.fetchPairBuckets(widget.pairAddress);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PairBucket>>(
      future: pairBucketF,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Styles.errorText(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          var data = snapshot.data;

          List<charts.Series<PairBucket, DateTime>> seriesList = [];
          var s0 = charts.Series<PairBucket, DateTime>(
            id: 'Liquidity',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (PairBucket sales, _) => sales.timeStamp,
            measureFn: (PairBucket sales, _) =>
                (sales.reserve0.toDouble() * sales.price0USD.toDouble()) +
                (sales.reserve1.toDouble() * sales.price1USD.toDouble()),
            data: data,
          );
          seriesList.add(s0);

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
                      nf.format((data[data.length - 1].reserve0.toDouble() *
                              data[data.length - 1].price0USD.toDouble()) +
                          (data[data.length - 1].reserve1.toDouble() *
                              data[data.length - 1].price1USD.toDouble())),
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
