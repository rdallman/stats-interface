import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/charts/liquidity_chart/liquidity_chart.dart';
import 'package:goswapinfo/widgets/tokens_table/tokens_table.dart';

class AnalyticsDetails extends StatelessWidget {
  const AnalyticsDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        children: <Widget>[
          Text(
            'Uniswap Protocol Analytics',
            style: TextStyle(
                fontWeight: FontWeight.w800, height: 1.9, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          LiquidityChart(),
        ],
      ),
    );
  }
}
