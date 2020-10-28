import 'package:flutter/material.dart';
import 'package:goswapinfo/pages/views/reusable_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:goswapinfo/pages/views/info_container.dart';
import 'package:goswapinfo/pages/views/charts/token_price_chart.dart';
import 'package:goswapinfo/pages/views/charts/token_volume_chart.dart';
import 'package:goswapinfo/pages/views/charts/token_liquidity_chart.dart';
import 'package:goswapinfo/common/globals.dart';

class TokenPage extends StatefulWidget {
  final String tokenName;
  final String liquidity;
  final String volume;
  final String price;
  final String address;
  final String reserve;
  TokenPage({
    this.address,
    this.tokenName,
    this.liquidity,
    this.volume,
    this.price,
    this.reserve,
  });
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  int isShowingVolume = 0;
  Color inactiveButtonColor = Color(0xff827daa);
  Color activeButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;

    String text = Globals.formatCurrency(Globals.toDec(widget.reserve));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(height: 30, child: Image.asset('assets/logo-white.png')),
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
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.tokenName} Token',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        'https://raw.githubusercontent.com/goswap/cryptocurrency-icons/master/128/color/${widget.tokenName.toLowerCase()}.png',
                        height: 40,
                      ),
                    ],
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
                        title: 'Price USD',
                        value: widget.price,
                      ),
                      ReusableContainer(
                        title: 'Reserve Amount',
                        value: text.substring(1, text.length - 3),
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
                                    isShowingVolume = 0;
                                  });
                                },
                                child: Text(
                                  'Volume',
                                  style: TextStyle(
                                    color: isShowingVolume == 0
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
                                    isShowingVolume = 1;
                                  });
                                },
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: isShowingVolume == 1
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
                                    isShowingVolume = 2;
                                  });
                                },
                                child: Text(
                                  'Liquidity',
                                  style: TextStyle(
                                    color: isShowingVolume == 2
                                        ? activeButtonColor
                                        : inactiveButtonColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          isShowingVolume == 0
                              ? TokenVolumeChart(
                                  tokenAddress: widget.address,
                                )
                              : isShowingVolume == 1
                                  ? TokenPriceChart(
                                      tokenAddress: widget.address,
                                    )
                                  : TokenLiquidityChart(
                                      tokenAddress: widget.address,
                                    )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.tokenName} Information',
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
                              value: widget.tokenName,
                              title: 'Token Name',
                              copy: false,
                              tokenAddress: widget.address,
                            ),
                            InfoContainer(
                              value: widget.address,
                              title: '${widget.tokenName} Address',
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
