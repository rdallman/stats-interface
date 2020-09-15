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
<<<<<<< HEAD
      title: 'Goswap info',
=======
      title: 'GoSwap Stats',
>>>>>>> 36b63a5c149423d20279ed94160dbf47f3e9d8a1
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      onGenerateRoute: router.gerenateRoute,
    );
  }
}
