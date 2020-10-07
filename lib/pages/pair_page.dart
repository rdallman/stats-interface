import 'package:flutter/material.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/pages/views/reusable_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'views/charts/pair_volume_chart.dart';
import 'package:goswapinfo/pages/views/info_container.dart';
import 'package:goswapinfo/pages/views/charts/pair_liquidity_chart.dart';

class PairPage extends StatefulWidget {
  final String pair;
  final String liquidity;
  final String volume;
  final String pairAdress;
  final String token0Address;
  final String token1Address;
  final String token0Symbol;
  final String token1Symbol;

  PairPage({
    this.pair,
    this.liquidity,
    this.volume,
    this.pairAdress,
    this.token0Address,
    this.token1Address,
    this.token0Symbol,
    this.token1Symbol,
  });
  @override
  _PairPageState createState() => _PairPageState();
}

class _PairPageState extends State<PairPage> {
  bool isShowingVolume = true;
  Color inactiveButtonColor = Color(0xff827daa);
  Color activeButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    String fees =
        (double.parse(widget.volume.replaceAll(RegExp(r'[^\w\s .-]+'), '')) *
                0.003)
            .toStringAsFixed(2);
    var screenSize = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;
    // Could refactor this code
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(height: 30, child: Image.asset('assets/logo-white.png')),
            //  Text("Stats")
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              color: Colors.white,
              child: Text("Go to GoSwap", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                launch('https://goswap.exchange');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: screenSize.height - appBarHeight),
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
              constraints: BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    '${widget.pair} Pair',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Wrap(
                    children: [
                      ReusableContainer(
                        title: 'Liquidity',
                        value: widget.liquidity,
                      ),
                      ReusableContainer(
                        title: 'Volume (24hr)',
                        value: widget.volume,
                      ),
                      ReusableContainer(
                        title: 'Fees (24hr)',
                        value: Globals.formatCurrency(Globals.toDec(fees)),
                      ),
                    ],
                  ),
                  Card(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    isShowingVolume = true;
                                  });
                                },
                                child: Text(
                                  'Volume',
                                  style: TextStyle(
                                    color: isShowingVolume
                                        ? activeButtonColor
                                        : inactiveButtonColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 1.0,
                                height: 20.0,
                                color: Colors.grey,
                              ),
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    isShowingVolume = false;
                                  });
                                },
                                child: Text(
                                  'Liquidity',
                                  style: TextStyle(
                                    color: !isShowingVolume
                                        ? activeButtonColor
                                        : inactiveButtonColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          isShowingVolume
                              ? PairVolumeChart(
                                  pairAddress: widget.pairAdress,
                                )
                              : PairLiquidityChart(
                                  pairAddress: widget.pairAdress,
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.pair} Information',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      child: Center(
                        child: Wrap(
                          runSpacing: 10.0,
                          children: [
                            InfoContainer(
                              value: widget.pair,
                              title: 'Pair Name',
                              copy: false,
                            ),
                            InfoContainer(
                              value: widget.pairAdress,
                              title: 'Pair Address',
                            ),
                            InfoContainer(
                              value: widget.token0Address,
                              title: '${widget.token0Symbol} Address',
                            ),
                            InfoContainer(
                              value: widget.token1Address,
                              title: '${widget.token1Symbol} Address',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
