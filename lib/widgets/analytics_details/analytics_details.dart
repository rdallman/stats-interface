import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/charts/liquidity_chart/liquidity_chart.dart';

class AnalyticsDetails extends StatelessWidget {
  const AnalyticsDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Uniswap Protocol Analytics',
            style: TextStyle(
                fontWeight: FontWeight.w800, height: 0.9, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          new Flexible(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search Uniswap pairs and tokens...'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          LiquidityChart(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
