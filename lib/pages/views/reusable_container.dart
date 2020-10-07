import 'package:flutter/material.dart';
import 'dart:ui';

class ReusableContainer extends StatelessWidget {
  final String title;
  final String value;
  ReusableContainer({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double width;

    if (pixelRatio <= 2 &&
        (screenSize.width >= 1000 || screenSize.height >= 1000)) {
      width = 258.5;
    } else {
      width = 500;
    }

    return Card(
      child: Container(
        // TODO make width property become relative to width of chart
        // As of now, adding another reusable container will require width to be changed
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
              height: 15,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
