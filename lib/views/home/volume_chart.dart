import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/common/total.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VolumeChart extends StatefulWidget {
  final Future<List<Total>> totalsF;

  VolumeChart(this.totalsF);

  @override
  _VolumeChartState createState() => _VolumeChartState(totalsF);
}

class _VolumeChartState extends State<VolumeChart> {
  bool isShowingMainData;
  var nf = NumberFormat.compactCurrency(locale: "en_US", symbol: "\$");
  Future<List<Total>> totalsF;

  _VolumeChartState(this.totalsF);

  @override
  void initState() {
    super.initState();

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
            // add up total volume
            List<charts.Series<Total, DateTime>> seriesList = [];
            var s0 = charts.Series<Total, DateTime>(
              id: 'Volume',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (Total sales, _) => sales.timeStamp,
              measureFn: (Total sales, _) => sales.volumeUSD.toDouble(),
              data: data,
            );
            seriesList.add(s0);

            // this was when it was hourly:
            // Decimal totalVolume = Decimal.zero;
            // for (final e in data) {
            //   totalVolume += e.volumeUSD;
            // }
            // Now that the default is daily, just use last bucket
            var last = data[data.length - 1];
            print("LAST VOL BUCKET: ${last.timeStamp} ${last.volumeUSD}");
            Decimal totalVolume = last.volumeUSD;

            var labelColor = charts.ColorUtil.fromDartColor(Colors.grey[200]);
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
                      const Text(
                        'Volume (24hr)',
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
                          // child: LineChart(
                          //   sampleData(snapshot.data),
                          //   swapAnimationDuration:
                          //       const Duration(milliseconds: 250),
                          // ),
                          child: charts.TimeSeriesChart(
                            seriesList,

                            // Convert into bar chart
                            defaultRenderer:
                                new charts.BarRendererConfig<DateTime>(),

                            domainAxis: new charts.DateTimeAxisSpec(
                                // tickFormatterSpec:
                                //     new charts.AutoDateTimeTickFormatterSpec(
                                //         day: new charts.TimeFormatterSpec(
                                //             format: 'd',
                                //             transitionFormat: 'MM/dd/yyyy')),
                                renderSpec: new charts.SmallTickRendererSpec(
                                    // Tick and Label styling here.
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 18, // size in Pts.
                                        color: labelColor),

                                    // Change the line colors to match text color.
                                    lineStyle: new charts.LineStyleSpec(
                                        color: labelColor))),

                            /// Assign a custom style for the measure axis.
                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                tickFormatterSpec: charts
                                        .BasicNumericTickFormatterSpec
                                    .fromNumberFormat(Globals.usdFormatCompact),
                                renderSpec: new charts.GridlineRendererSpec(

                                    // Tick and Label styling here.
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 18, // size in Pts.
                                        color: labelColor),

                                    // Change the line colors to match text color.
                                    lineStyle: new charts.LineStyleSpec(
                                        color: labelColor))),

                            // Hightlight selected bar
                            behaviors: [new charts.DomainHighlighter()],
                            // animate: animate,
                            // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                            // should create the same type of [DateTime] as the data provided. If none
                            // specified, the default creates local date time.
                            // dateTimeFactory:
                            //     const charts.LocalDateTimeFactory(),
                            // behaviors: [
                            //   charts.LinePointHighlighter(
                            //       symbolRenderer: CustomCircleSymbolRenderer())
                            // ],
                          ),
                        ),
                      ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
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
        a.volumeUSD.toDouble())));
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

// // from here: https://github.com/google/charts/issues/58#issuecomment-581776923
// class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
//   @override
//   void paint(charts.ChartCanvas canvas, Rectangle bounds,
//       {List dashPattern,
//       charts.Color fillColor,
//       charts.Color strokeColor,
//       double strokeWidthPx}) {
//     super.paint(canvas, bounds,
//         dashPattern: dashPattern,
//         fillColor: fillColor,
//         strokeColor: strokeColor,
//         strokeWidthPx: strokeWidthPx);
//     canvas.drawRect(
//         Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
//             bounds.height + 10),
//         fill: charts.Color.white);
//     // var textStyle = style.TextStyle();
//     // textStyle.color = Color.black;
//     // textStyle.fontSize = 15;
//     canvas.drawText(
//         charts.TextElement(
//           charts.CustomMeasureTickCount.pointerValue,
//           // style: textStyle
//         ),
//         (bounds.left).round(),
//         (bounds.top - 28).round());
//   }
// }
