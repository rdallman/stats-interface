import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class PairsTable extends StatefulWidget {
  @override
  _PairsTableState createState() => _PairsTableState();
}

class _PairsTableState extends State<PairsTable> {
  final String jsonSample = '''[
        {
          "Name": "ETH-USDT",
          "Liquidity": "\$455459598",
          "Volume (24hrs)": "\$445,097,454",
          "Volume (7d)": "\$373.92",
          "Fees (24hrs)": "\$373.92",
          "1y Fees": "+4.05%"
        },
        {
          "Name": "ETH-USDT",
          "Liquidity": "\$455459598",
          "Volume (24hrs)": "\$445,097,454",
          "Volume (7d)": "\$373.92",
          "Fees (24hrs)": "\$373.92",
          "1y Fees": "+4.05%"
        },
        {
          "Name": "ETH-USDT",
          "Liquidity": "\$455459598",
          "Volume (24hrs)": "\$445,097,454",
          "Volume (7d)": "\$373.92",
          "Fees (24hrs)": "\$373.92",
          "1y Fees": "+4.05%"
        },
        {
          "Name": "ETH-USDT",
          "Liquidity": "\$455459598",
          "Volume (24hrs)": "\$445,097,454",
          "Volume (7d)": "\$373.92",
          "Fees (24hrs)": "\$373.92",
          "1y Fees": "+4.05%"
        }
      ]''';

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              JsonTable(
                json,
                showColumnToggle: true,
                allowRowHighlight: true,
                rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                paginationRowCount: 4,
                onRowSelect: (index, map) {
                  print(index);
                  print(map);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
