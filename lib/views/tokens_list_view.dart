import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/centered_view/centered_view.dart';
import 'package:goswapinfo/widgets/tokens_list/tokens_list.dart';
import 'package:goswapinfo/widgets/navigation_bar/navigation_bar.dart';

class TokensListView extends StatelessWidget {
  const TokensListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(
              child: TokensList(),
            )
          ],
        ),
      ),
    );
  }
}
