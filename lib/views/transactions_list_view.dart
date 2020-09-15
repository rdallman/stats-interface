import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/centered_view/centered_view.dart';
import 'package:goswapinfo/widgets/transactions_list/transactions_list.dart';
import 'package:goswapinfo/widgets/navigation_bar/navigation_bar.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(
              child: TransactionsList(),
            )
          ],
        ),
      ),
    );
  }
}
