import 'package:flutter/material.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/pair.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/pages/pair_page.dart';
import 'package:goswapinfo/pages/token_page.dart';

class TopPairs extends StatefulWidget {
  @override
  _TopPairsState createState() => _TopPairsState();
}

class _TopPairsState extends State<TopPairs> {
  Future<List<Pair>> pairsF;

  @override
  initState() {
    super.initState();
    pairsF = Api.fetchPairs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Top Pairs",
          style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder<List<Pair>>(
            future: pairsF, // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Pair>> snapshot) {
              // print(snapshot);
              // print(snapshot.data);
              if (snapshot.hasError) {
                return Styles.errorText(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                // print("DATA: ${snapshot.data}");
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: table(context, snapshot.data),
                );
              }
              return Styles.waiting();
            }),
      ],
    );
  }

  Widget table(BuildContext context, List<Pair> pairs) {
    List<DataRow> rows = [];
    for (final p in pairs) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(
            InkWell(
              child: Text(
                p.toString(),
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  // decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
              onTap: () {
                // launch(// TODO Change the route
                //     "${Globals.uiURL}/#/swap?inputCurrency=${p.token0.address}&outputCurrency=${p.token1.address}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PairPage(
                        pair: p.toString(),
                        liquidity: Globals.formatCurrency(p.stats.liquidityUSD),
                        volume: Globals.formatCurrency(p.stats.volumeUSD),
                        pairAdress: p.address,
                        token0Address: p.token0.address,
                        token1Address: p.token1.address,
                        token0Symbol: p.token0.symbol,
                        token1Symbol: p.token1.symbol,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // LINK:
          DataCell(Text('${Globals.formatCurrency(p.stats.liquidityUSD)}')),
          DataCell(Text('${Globals.formatCurrency(p.stats.volumeUSD)}')),
        ],
      ));
    }
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Liquidity',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Volume (24hr)',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: rows,
    );
  }
}
