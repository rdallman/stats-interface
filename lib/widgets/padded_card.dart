import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  final Widget child;
  const PaddedCard({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 600),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: child,
      ),
    );
  }
}
