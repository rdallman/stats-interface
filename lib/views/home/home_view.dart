import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/charts/liquidity_chart/liquidity_chart.dart';

import 'top_pairs.dart';
import 'top_tokens.dart';
import 'volume_chart.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            SizedBox(height: 30, child: Image.asset('assets/logo-white.png')),
        // title: const Text('GoSwap Stats'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.add_alert),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     scaffoldKey.currentState.showSnackBar(snackBar);
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.navigate_next),
          //   tooltip: 'Next page',
          //   onPressed: () {
          //     openPage(context);
          //   },
          // ),
        ],
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              // alignment: Alignment.topCenter,
              // constraints: BoxConstraints(maxWidth: 1200),
              // child: ConstrainedBox(
              // constraints: BoxConstraints(maxWidth: 1200),
              // child: child,
              // ),

              child: Column(
                children: <Widget>[
                  // NavigationBar(),
                  Container(
                    // constraints: BoxConstraints(maxHeight: 300),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: LiquidityChart()),
                          SizedBox(width: 50),
                          // Expanded(
                          // child:
                          // AnalyticsDetails(),
                          // ),
                          Expanded(child: VolumeChart()),
                        ]),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  TopPairs(),
                  const SizedBox(
                    height: 37,
                  ),
                  TopTokens(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
