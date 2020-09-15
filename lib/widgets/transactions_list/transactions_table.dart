import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class TransactionsTable extends StatefulWidget {
  @override
  _TransactionsTableState createState() => _TransactionsTableState();
}

class _TransactionsTableState extends State<TransactionsTable> {
  final String jsonSample = '''[
        {
          "All": "Add ETH and MOON",
          "Total Value": "\$408.17",
          "Tokens Amount": "0.54579 ETH",
          "Tokens Amount 2": "0.54579 MOON",
          "Account": "0x1a2a...2c61",
          "Time": "32 minutes ago"
        },
        {
          "All": "Add ETH and MOON",
          "Total Value": "\$408.17",
          "Tokens Amount": "0.54579 ETH",
          "Tokens Amount 2": "0.54579 MOON",
          "Account": "0x1a2a...2c61",
          "Time": "32 minutes ago"
        },
        {
          "All": "Add ETH and MOON",
          "Total Value": "\$408.17",
          "Tokens Amount": "0.54579 ETH",
          "Tokens Amount 2": "0.54579 MOON",
          "Account": "0x1a2a...2c61",
          "Time": "32 minutes ago"
        },
        {
          "All": "Add ETH and MOON",
          "Total Value": "\$408.17",
          "Tokens Amount": "0.54579 ETH",
          "Tokens Amount 2": "0.54579 MOON",
          "Account": "0x1a2a...2c61",
          "Time": "32 minutes ago"
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
