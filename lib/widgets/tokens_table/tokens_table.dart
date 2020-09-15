import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class TokensTable extends StatefulWidget {
  @override
  _TokensTableState createState() => _TokensTableState();
}

class _TokensTableState extends State<TokensTable> {
  final String jsonSample = '''[
        {
          "Name": "Ether",
          "Symbol": "ETH",
          "Liquidity": "\$455459598",
          "Volume": "\$445,097,454",
          "Price": "\$373.92",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "Tether USD",
          "Symbol": "USDT",
          "Liquidity": "\$150,556,128",
          "Volume": "\$78,056,245",
          "Price": "\$0.99",
          "Price Chainge (24hrs)": "-0.61%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        },
        {
          "Name": "Ether",
          "Symbol": "ETH",
          "Liquidity": "\$455459598",
          "Volume": "\$445,097,454",
          "Price": "\$373.92",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "Tether USD",
          "Symbol": "USDT",
          "Liquidity": "\$150,556,128",
          "Volume": "\$78,056,245",
          "Price": "\$0.99",
          "Price Chainge (24hrs)": "-0.61%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        },
        {
          "Name": "Ether",
          "Symbol": "ETH",
          "Liquidity": "\$455459598",
          "Volume": "\$445,097,454",
          "Price": "\$373.92",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "Tether USD",
          "Symbol": "USDT",
          "Liquidity": "\$150,556,128",
          "Volume": "\$78,056,245",
          "Price": "\$0.99",
          "Price Chainge (24hrs)": "-0.61%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        },
        {
          "Name": "Ether",
          "Symbol": "ETH",
          "Liquidity": "\$455459598",
          "Volume": "\$445,097,454",
          "Price": "\$373.92",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "Tether USD",
          "Symbol": "USDT",
          "Liquidity": "\$150,556,128",
          "Volume": "\$78,056,245",
          "Price": "\$0.99",
          "Price Chainge (24hrs)": "-0.61%"
        },
        {
          "Name": "USD//C",
          "Symbol": "USDC",
          "Liquidity": "\$110,607,975",
          "Volume": "\$72,417,571",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+4.05%"
        },
        {
          "Name": "DAI Stablecoin",
          "Symbol": "DAI",
          "Liquidity": "\$5459598",
          "Volume": "\$97,454",
          "Price": "\$1.00",
          "Price Chainge (24hrs)": "+3.05%"
        },
        {
          "Name": "yearn.finance",
          "Symbol": "YFI",
          "Liquidity": "\$459598",
          "Volume": "\$1,245,097,454",
          "Price": "\$39,170",
          "Price Chainge (24hrs)": "+0.92%"
        }
      ]''';
  bool toggle = true;

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
                paginationRowCount: 12,
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
