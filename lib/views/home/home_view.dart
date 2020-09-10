import 'package:flutter/material.dart';
import 'package:goswapinfo/widgets/centered_view/centered_view.dart';
import 'package:goswapinfo/widgets/analytics_details/analytics_details.dart';
import 'package:goswapinfo/widgets/navigation_bar/navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(
              child: AnalyticsDetails(),
            )
          ],
        ),
      ),
    );
  }
}
