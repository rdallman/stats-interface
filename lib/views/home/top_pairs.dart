import 'package:flutter/material.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/pair.dart';
import 'package:goswapinfo/common/styles.dart';

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
          height: 37,
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
                return table(context, snapshot.data);
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
          DataCell(InkWell(
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
              launch(
                  "${Globals.uiURL}/#/swap?inputCurrency=${p.token0.address}&outputCurrency=${p.token1.address}");
            },
          )),
          // LINK:
          DataCell(Text(' ABC')),
          // '${Globals.usdFormatCompact.format(p.stats.liquidityUSD.toDouble())}')),
          DataCell(Text('123')),
          // '${Globals.usdFormatCompact.format(p.stats.volumeUSD.toDouble())}')),
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
