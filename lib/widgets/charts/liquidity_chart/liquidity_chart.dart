import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/common/total.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class LiquidityChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LiquidityChartState();
}

class LiquidityChartState extends State<LiquidityChart> {
  bool isShowingMainData;
  Future<List<Total>> totalsF;

  var nf = NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");

  @override
  void initState() {
    super.initState();
    totalsF = Api.fetchTotals();
    isShowingMainData = false;
    // Api.fetchPairLiquidity('FAST-WGO').then((value) {
    //   for (var e in value) {
    //     print(e);
    //     print(e.toJson());
    //   }
    // }, onError: (e) {
    //   print(e);
    // });
    // Api.fetchPairVolume('FAST-WGO').then((value) {
    //   for (var e in value) {
    //     print(e);
    //     print(e.toJson());
    //   }
    // }, onError: (e) {
    //   print(e);
    // });
    // Api.fetchTokens().then((value) {
    //   print("tokens");
    //   for (var e in value) {
    //     print(e);
    //     print(e.toJson());
    //   }
    // }, onError: (e) {
    //   print(e);
    // });
    // Api.fetchVolume('WGO').then((value) {
    //   print("token volume");
    //   for (var e in value) {
    //     print(e);
    //     print(e.toJson());
    //   }
    // }, onError: (e) {
    //   print(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Total>>(
        future: totalsF,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Styles.errorText(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            var data = snapshot.data;
            // TODO: if len 0, show something else
            var last = data[data.length - 1];
            print("LAST BUCKET: ${last.timeStamp} ${last.liquidityUSD}");
            return Center(
              child: Center(
                child: Container(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: const [
                  //       Color(0xff2c274c),
                  //       Color(0xff46426c),
                  //     ],
                  //     begin: Alignment.bottomCenter,
                  //     end: Alignment.topCenter,
                  //   ),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 37,
                      ),
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
                            data[data.length - 1].liquidityUSD.toDouble()),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      // Expanded(
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: Container(
                          height: 400,
                          child: LineChart(
                            sampleData(snapshot.data),
                            swapAnimationDuration:
                                const Duration(milliseconds: 250),
                          ),
                        ),
                      ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Text('Loading...');
        });
  }

  LineChartData sampleData(List<Total> totals) {
    int ycount = 0;
    int xcount = 0;
    return LineChartData(
      // extraLinesData: ExtraLinesData(horizontalLines: [HorizontalLine(y: 0)]),
      lineTouchData: LineTouchData(
          // enabled: false,
          ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          checkToShowTitle: (double minValue, double maxValue,
              SideTitles sideTitles, double appliedInterval, double value) {
            // print("BOTTOM min: $minValue, max: $maxValue, applied: $appliedInterval, value: $value");
            xcount++;
            if ((xcount - 1) % 10 == 0) {
              return true;
            }
            return false;
          },
          rotateAngle: 90,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            // print("title: $value");
            var dt = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            return "${Globals.mdFormat.format(dt)}";
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          checkToShowTitle: (double minValue, double maxValue,
              SideTitles sideTitles, double appliedInterval, double value) {
            // print("LEFT min: $minValue, max: $maxValue, applied: $appliedInterval, value: $value");
            ycount++;
            if ((ycount - 1) % (10) == 0) {
              return true;
            }
            return false;
          },
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            // print("lefttitle: $value");
            return nf.format(value.round());
          },
          margin: 8,
          reservedSize: 60,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      lineBarsData: linesBarData(totals),
    );
  }

  List<LineChartBarData> linesBarData(List<Total> totals) {
    var rand = new Random();
    List<FlSpot> l = List<FlSpot>.from(totals.map((a) => FlSpot(
        a.timeStamp.millisecondsSinceEpoch.toDouble(),
        a.liquidityUSD.toDouble() +
            (rand.nextDouble() *
                100000)))); // TODO:: remove rand, just doing this to have some fluctuation
    // l[0] = FlSpot(l[0].x, 0);
    return [
      LineChartBarData(
        spots: l,
        isCurved: true,
        curveSmoothness: 0.1,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
    ];
  }
}
