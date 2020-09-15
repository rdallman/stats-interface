import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class AccountsTable extends StatefulWidget {
  @override
  _AccountsTableState createState() => _AccountsTableState();
}

class _AccountsTableState extends State<AccountsTable> {
  final String jsonSample = '''[
        {
          "Account": "0x3e9dd14976239d461e391dbe051084bfb674cba2",
          "Pair": "HKMT-USDT",
          "Value": "\$445,097,454"
        },
        {
          "Account": "0x3e9dd14976239d461e391dbe051084bfb674cba2",
          "Pair": "HKMT-USDT",
          "Value": "\$445,097,454"
        },
        {
          "Account": "0x3e9dd14976239d461e391dbe051084bfb674cba2",
          "Pair": "HKMT-USDT",
          "Value": "\$445,097,454"
        },
        {
          "Account": "0x3e9dd14976239d461e391dbe051084bfb674cba2",
          "Pair": "HKMT-USDT",
          "Value": "\$445,097,454"
        },
        {
          "Account": "0x3e9dd14976239d461e391dbe051084bfb674cba2",
          "Pair": "HKMT-USDT",
          "Value": "\$445,097,454"
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
