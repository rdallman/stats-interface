import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/pairs_list/pairs_table.dart';

class PairsList extends StatelessWidget {
  const PairsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      child: Column(
        children: <Widget>[
          Text('Top Pairs',
              style: TextStyle(
                  fontWeight: FontWeight.w800, height: 1.9, fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 500, child: PairsTable()),
        ],
      ),
    );
  }
}
