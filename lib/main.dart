import 'package:flutter/material.dart';
import 'package:goswapinfo/views/home/home_view.dart';

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
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        // scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          // brightness: Brightness.dark,
          // color: Color(0xff2c274c),
          color: Color(0xff46426c),
        ),
        cardTheme: CardTheme(
          // color: Colors.deepPurple[800],
          color: Color(0xff2c274c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey[600]),
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}
