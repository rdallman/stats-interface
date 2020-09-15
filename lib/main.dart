import 'package:flutter/material.dart';
import 'package:goswapinfo/views/home/home_view.dart';
import 'router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoSwap Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      onGenerateRoute: router.gerenateRoute,
    );
  }
}
