import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/accounts_list/accounts_table.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      child: Column(
        children: <Widget>[
          Text(
            'Wallet analytics',
            style: TextStyle(
                fontWeight: FontWeight.w800, height: 1.9, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: '0x...'),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                onPressed: () {},
                child:
                    const Text('Load Account', style: TextStyle(fontSize: 12)),
              )
            ],
          ),
          // new Flexible(
          //   child: TextField(
          //     decoration: InputDecoration(hintText: '0x...'),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 300, child: AccountsTable()),
        ],
      ),
    );
  }
}
