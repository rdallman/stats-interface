import 'package:flutter/material.dart';
import 'dart:ui';

class ReusableContainer extends StatelessWidget {
  final String title;
  final String value;
  final double desiredWidth;
  final bool pool;
  final String value2;
  final String token0Name;
  final String token1Name;
  ReusableContainer({
    @required this.title,
    @required this.value,
    this.desiredWidth = 193.875,
    this.pool = false,
    this.value2,
    this.token0Name,
    this.token1Name,
  });
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double width;
    // 258.5
    if (pixelRatio <= 2 &&
        (screenSize.width >= 1000 || screenSize.height >= 1000)) {
      width = desiredWidth;
    } else {
      width = 500;
    }

    return Card(
      child: Container(
        constraints: BoxConstraints(minWidth: width),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xff827daa),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: !pool ? 15 : 6,
            ),
            pool
                ? Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/goswap/cryptocurrency-icons/master/128/color/${token0Name.toLowerCase()}.png',
                            height: 15,
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/goswap/cryptocurrency-icons/master/128/color/${token1Name.toLowerCase()}.png',
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: !pool ? 24 : 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }
}
