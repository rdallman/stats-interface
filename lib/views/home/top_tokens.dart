import 'package:flutter/material.dart';
import 'package:goswapinfo/common/api.dart';
import 'package:goswapinfo/common/globals.dart';
import 'package:goswapinfo/common/styles.dart';
import 'package:goswapinfo/common/token_bucket.dart';
import 'package:goswapinfo/pages/token_page.dart';

class TopTokens extends StatefulWidget {
  @override
  _TopTokensState createState() => _TopTokensState();
}

class _TopTokensState extends State<TopTokens> {
  Future<List<TokenBucket>> tokensF;

  @override
  initState() {
    super.initState();
    tokensF = Api.fetchTokensStats();
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
        FutureBuilder<List<TokenBucket>>(
            future: tokensF, // a previously-obtained Future<String> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<TokenBucket>> snapshot) {
              // print(snapshot);
              // print(snapshot.data);
              if (snapshot.hasError) {
                return Styles.errorText(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                // print("DATA: ${snapshot.data}");
                if (snapshot.data.length == 0) {
                  return Text("No tokens found");
                }
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

  Widget table(BuildContext context, List<TokenBucket> tokens) {
    List<DataRow> rows = [];
    for (final p in tokens) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TokenPage(
                        tokenName: p.toString(),
                        liquidity: Globals.formatCurrency(p.liquidityUSD),
                        volume: Globals.formatCurrency(p.volumeUSD),
                        price: Globals.formatCurrency(p.priceUSD),
                        address: p.address,
                        reserve: p.reserve.toStringAsFixed(0),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          DataCell(Text('${Globals.formatCurrency(p.liquidityUSD)}')),
          DataCell(Text('${Globals.formatCurrency(p.volumeUSD)}')),
          DataCell(Text('${Globals.formatCurrency(p.priceUSD)}')),
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
