import 'package:flutter/material.dart';

class TopPairs extends StatefulWidget {
  @override
  _TopPairsState createState() => _TopPairsState();
}

class _TopPairsState extends State<TopPairs> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Top Tokens",
          style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 37,
        ),
        Text(
          "CHART HERE",
        ),
      ],
    );
  }
}
