import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/charts/liquidity_chart/liquidity_chart.dart';
import 'package:goswapinfo/widgets/padded_card.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Row(
          children: [
            SizedBox(height: 30, child: Image.asset('assets/logo-white.png')),
            //  Text("Stats")
          ],
        ),
        // title: const Text('GoSwap Stats'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
                color: Colors.white,
                child:
                    Text("Go to GoSwap", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  launch('https://goswap.exchange');
                }),
          ),
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
              // padding: const EdgeInsets.symmetric(horizontal: 30),
              // alignment: Alignment.topCenter,
              // constraints: BoxConstraints(maxWidth: 1200),
              // child: ConstrainedBox(
              // constraints: BoxConstraints(maxWidth: 1200),
              // child: child,
              // ),

              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // constraints: BoxConstraints(maxHeight: 300),
                    child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: 40,
                        runSpacing: 30,
                        children: [
                          PaddedCard(child: LiquidityChart()),
                          PaddedCard(child: VolumeChart()),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(spacing: 30, runSpacing: 30, children: [
                    PaddedCard(child: TopPairs()),
                    PaddedCard(child: TopTokens()),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
