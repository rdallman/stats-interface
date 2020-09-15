import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/transactions_list/transactions_table.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      child: Column(
        children: <Widget>[
          Text('Latest Transactions',
              style: TextStyle(
                  fontWeight: FontWeight.w800, height: 1.9, fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 500, child: TransactionsTable()),
        ],
      ),
    );
  }
}
