import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/centered_view/centered_view.dart';
import 'package:goswapinfo/widgets/pairs_list/pairs_list.dart';
import 'package:goswapinfo/widgets/navigation_bar/navigation_bar.dart';

class PairsListView extends StatelessWidget {
  const PairsListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(
              child: PairsList(),
            )
          ],
        ),
      ),
    );
  }
}
