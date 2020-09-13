import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/charts/liquidity_chart/liquidity_chart.dart';
import 'package:goswapinfo/widgets/navigation_bar/navigation_bar.dart';

import 'top_pairs.dart';
import 'top_tokens.dart';
import 'volume_chart.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
          child: Center(
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 60),
              // alignment: Alignment.topCenter,
              constraints: BoxConstraints(maxWidth: 1200),
              // child: ConstrainedBox(
              // constraints: BoxConstraints(maxWidth: 1200),
              // child: child,
              // ),

              child: Column(
                children: <Widget>[
                  NavigationBar(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(child: LiquidityChart()),
                        // Expanded(
                        // child:
                        // AnalyticsDetails(),
                        // ),
                        VolumeChart(),
                      ]),
                  TopTokens(),
                  TopPairs(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
