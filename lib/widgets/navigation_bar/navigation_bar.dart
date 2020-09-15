import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 150,
            child: Image.asset('assets/logo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _NavBarItem('Overview', '/'),
              SizedBox(
                width: 30,
              ),
              _NavBarItem('Tokens', 'tokens'),
              SizedBox(
                width: 30,
              ),
              _NavBarItem('Pairs', 'pairs'),
              SizedBox(
                width: 30,
              ),
              _NavBarItem('Accounts', 'accounts'),
              SizedBox(
                width: 30,
              ),
              _NavBarItem('Transactions', 'transactions'),
            ],
          )
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final String route;
  const _NavBarItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(title, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pushNamed(context, this.route);
      },
    );
  }
}
