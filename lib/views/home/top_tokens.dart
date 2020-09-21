import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/common/token.dart';

class TopTokens extends StatefulWidget {
  @override
  _TopTokensState createState() => _TopTokensState();
}

class _TopTokensState extends State<TopTokens> {
  Future<List<Token>> pairsF;

  @override
  initState() {
    super.initState();
    pairsF = Api.fetchTokens();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Top Tokens",
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
        FutureBuilder<List<Token>>(
            future: pairsF, // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Token>> snapshot) {
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

  Widget table(BuildContext context, List<Token> tokens) {
    List<DataRow> rows = [];
    for (final p in tokens) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(p.toString())),
          DataCell(Text('${Globals.formatCurrency(p.stats.liquidityUSD)}')),
          DataCell(Text('${Globals.formatCurrency(p.stats.volumeUSD)}')),
          DataCell(Text('${Globals.formatCurrency(p.stats.priceUSD)}')),
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
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: rows,
    );
  }
}
