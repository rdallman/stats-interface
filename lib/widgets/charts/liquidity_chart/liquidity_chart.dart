import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/totals.dart';

class LiquidityChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LiquidityChartState();
}

class LiquidityChartState extends State<LiquidityChart> {
  bool isShowingMainData;
  Future<List<Total>> totalsF;

  @override
  void initState() {
    super.initState();
    totalsF = Api.fetchTotals();
    isShowingMainData = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Total>>(
        future: totalsF,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? AspectRatio(
                  aspectRatio: 1.23,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [
                          Color(0xff2c274c),
                          Color(0xff46426c),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 37,
                            ),
                            const Text(
                              'Liquidity 2020',
                              style: TextStyle(
                                color: Color(0xff827daa),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              '\$782.78m',
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, left: 6.0),
                                child: LineChart(
                                  sampleData(snapshot),
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 250),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Text('Loading...');
        });
  }

  LineChartData sampleData(AsyncSnapshot<List<Total>> totals) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return value.floor().toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return value.floor().toString();
          },
          margin: 8,
          reservedSize: 30,
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

  List<LineChartBarData> linesBarData(AsyncSnapshot<List<Total>> totals) {
    for (var e in totals.data) {
      print(e.timeStamp.hour.toDouble());
      print(e.liquidityUSD);
      print(e.volumeUSD);
    }

    return [
      LineChartBarData(
        spots: List<FlSpot>.from(totals.data.map((a) => FlSpot(
            a.timeStamp.hour.toDouble(),
            (a.volumeUSD / 1000).roundToDouble()))),
        isCurved: true,
        curveSmoothness: 0.1,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
    ];
  }
}
