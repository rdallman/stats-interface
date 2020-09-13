import 'package:flutter/material.dart';

class TopTokens extends StatefulWidget {
  @override
  _TopTokensState createState() => _TopTokensState();
}

class _TopTokensState extends State<TopTokens> {
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
        )
      ],
    );
  }
}
